import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/config/validation/input-text-validator.dart';
import 'package:thelawala/models/request/edit-profile-request.dart';
import 'package:thelawala/models/response/get-user-profile.dart';
import 'package:thelawala/utils/helpers/rest-api.dart';

import '../bloc/../../../../utils/extension/input-string-extension.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final RestApiBuilder api;

  UpdateProfileBloc(this.api, { UserProfileResponse? profile })
      : super(UpdateProfileState(
            name: profile?.name ?? "",
            cities: profile?.cities ?? [],
            dishes: profile?.cuisines ?? [],
            introduction: profile?.introduction ?? "",
            phone: profile?.contact.phone ?? "",
            email: profile?.contact.email ?? "",
            website: profile?.contact.website ?? "",
            facebook: profile?.social.facebook ?? "",
            instagram: profile?.social.instagram ?? "",
            twitter: profile?.social.twitter ?? "",
            youtube: profile?.social.youtube ?? "",
            status: UpdateProfileStatus.INITIAL));

  @override
  Stream<UpdateProfileState> mapEventToState(
    UpdateProfileEvent event,
  ) async* {
    if (event is InitialUserDetail) {
      yield* _mapInitialUserDetail(event);
    } else if (event is UpdateProfileDetailEvent) {
      yield* _mapUpdateProfile(event, state);
    } if (event is OnNameChange) {
      yield state.copyWith(name: event.name);
    } else if (event is OnPhoneChange) {
      yield state.copyWith(phone: event.phone);
    } else if (event is OnEmailChange) {
      yield state.copyWith(email: event.email);
    } else if (event is OnWebsiteChange) {
      yield state.copyWith(website: event.website);
    } else if (event is OnFacebookChange) {
      yield state.copyWith(facebook: event.facebook);
    } else if (event is OnInstagramChange) {
      yield state.copyWith(instagram: event.instagram);
    } else if (event is OnYoutubeChange) {
      yield state.copyWith(youtube: event.youtube);
    } else if (event is OnIntroductionChange) {
      yield state.copyWith(introduction: event.intro);
    }
  }

  Stream<UpdateProfileState> _mapInitialUserDetail(InitialUserDetail event) async* {
    UserProfileResponse user = event.profile;
    await Future.delayed(Duration(seconds: 2));
    yield state.copyWith(
      name: user.name,
      introduction: user.introduction,
      youtube: user.social.youtube,
      instagram: user.social.instagram,
      facebook: user.social.facebook,
      website: user.contact.website,
      email: user.contact.email,
      phone: user.contact.phone,
      cities: user.cities,
      dishes: user.cuisines,
      status: UpdateProfileStatus.PREFILLED_DATA
    );
  }

  Stream<UpdateProfileState> _mapUpdateProfile(
      UpdateProfileDetailEvent event, UpdateProfileState state) async* {
    try {
      yield state.copyWith(status: UpdateProfileStatus.AWAITING_CONFIRMATION);
      EditProfileRequest req = EditProfileRequest(
        name: state.name,
        introduction: state.introduction,
        contact: ContactRequest(
          phone: state.phone,
          email: state.email,
          website: state.website
        ),
        social: SocialRequest(
          facebook: state.facebook,
          instagram: state.instagram,
          youtube: state.youtube
        )
      );
      RestOptions options = RestOptions(path: "/vendor", body: json.encode(req.toJson()));
      var response = await api.post(restOptions: options);
      print(response);
      yield state.copyWith(status: UpdateProfileStatus.SUCCESS);
    } catch (e) {
      print(e);
    }
  }
}
