import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/constants/api-url.dart';
import 'package:thelawala/models/response/get-user-profile.dart';
import 'package:thelawala/utils/helpers/rest-api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RestApiBuilder api;

  HomeBloc(this.api) : super(HomeState(status: DashboardStatus.INITIAL)) {
    add(GetUserProfile());
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetUserProfile) {
      yield* _mapGetUserDetail();
    }
  }

  Stream<HomeState> _mapGetUserDetail() async* {
    try {
      yield state.copyWith(status: DashboardStatus.LOADING);
      RestOptions options = RestOptions(path: ApiUrl.GET_VENDOR_PROFILE);
      var response = await api.get(restOptions: options);
      UserProfileResponse resp = UserProfileResponse.fromJson(api.parsedResponse(response));
      print(resp);
      yield state.copyWith(status: DashboardStatus.PROFILE_SUCCESSFULLY_LOADED, userDetail: resp);
    } catch(e) {
      print(e);
      yield state.copyWith(status: DashboardStatus.FAILURE);
    }
  }


}
