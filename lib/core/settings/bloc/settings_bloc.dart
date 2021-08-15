import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/utils/helpers/rest-api.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final RestApiBuilder api;
  GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  late Isolate _isolate;
  late ReceivePort _port;

  SettingsBloc(this.api) : super(SettingsState());

  @override
  Future<void> close() {
    _isolate.kill();
    return super.close();
  }

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is GetCurrentLocation) {
      await _handlePermission();
      this.add(UpdateCurrentLocationToServer());
      spawnNewIsolate();
    } else if (event is UpdateCurrentLocationToServer) {
      yield* _mapUpdateLocation();
    }
  }

  Stream<SettingsState> _mapUpdateLocation() async* {
    Position? loc = await getLocationInBackgroundAndUpdate();
    if (loc != null) {
      try {
        Map<String, double> body = {
          "latitude": loc.latitude,
          "longitude": loc.longitude
        };
        RestOptions options = RestOptions(path: "/location", body: json.encode(body));
        var resp = await api.post(restOptions: options);
        print(loc);
      } catch (e) {
        print('Error while updating location to server');
      }
    } else {
      print("Unable to find the current location");
    }
  }



  void spawnNewIsolate() async {
    _port = ReceivePort();
    try {

      _isolate = await Isolate.spawn(sayHello, _port.sendPort);
      _port.listen((dynamic message) async {
        if (message != null) {
          this.add(UpdateCurrentLocationToServer());
        }
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<Position?> getLocationInBackgroundAndUpdate() async {
    GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
    var permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      var currentLocation = await _geolocatorPlatform.getCurrentPosition();
      print(currentLocation);
      return currentLocation;
    }
  }

  //spawn accepts only static methods or top-level functions
  static void sayHello(SendPort sendPort) async {
    // sendPort.send("Hello from Isolate");
    Timer.periodic(Duration(minutes: 5), (timer) async {
      // var loc = await getLocationInBackgroundAndUpdate();
      sendPort.send("Current Location: ");
    });
  }

  Future<void> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
  }
}
