part of 'home_bloc.dart';

enum DashboardStatus { INITIAL, PROFILE_SUCCESSFULLY_LOADED, LOADING, FAILURE }

class HomeState {
  final UserProfileResponse? userDetail;
  final DashboardStatus status;

  HomeState({this.userDetail, required this.status});

  HomeState copyWith(
      {UserProfileResponse? userDetail, DashboardStatus? status}) {
    return HomeState(
        userDetail: userDetail ?? this.userDetail,
        status: status ?? this.status);
  }
}
