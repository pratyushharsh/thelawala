import 'dart:async';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  late Isolate _isolate;
  late ReceivePort _port;

  SettingsBloc() : super(SettingsState());


  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is GetCurrentLocation) {
      _handlePermission();
      spawnNewIsolate();

    }
  }

  void spawnNewIsolate() async {
    _port = ReceivePort();

    try {

      _isolate = await Isolate.spawn(sayHello, _port.sendPort);
      _port.listen((dynamic message) {
        print('New message from Isolate: $message');
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  //spawn accepts only static methods or top-level functions
  static void sayHello(SendPort sendPort) {
    // sendPort.send("Hello from Isolate");
    Timer.periodic(Duration(seconds: 2), (timer) {
      sendPort.send("Hello from Isolate");
    });
  }

  Future<void> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();

    permission = await _geolocatorPlatform.requestPermission();

    var resp = await _geolocatorPlatform.getCurrentPosition();
    print(resp);

  }
}
