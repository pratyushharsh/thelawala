part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileEvent {}

class UpdateProfileDetailEvent extends UpdateProfileEvent {
}

class InitialUserDetail extends UpdateProfileEvent {
  final UserProfileResponse profile;

  InitialUserDetail(this.profile);
}

class OnNameChange extends UpdateProfileEvent {
  final String name;

  OnNameChange(this.name);
}

class OnIntroductionChange extends UpdateProfileEvent {
  final String intro;

  OnIntroductionChange(this.intro);
}

class OnPhoneChange extends UpdateProfileEvent {
  final String phone;

  OnPhoneChange(this.phone);
}

class OnEmailChange extends UpdateProfileEvent {
  final String email;

  OnEmailChange(this.email);
}

class OnWebsiteChange extends UpdateProfileEvent {
  final String website;

  OnWebsiteChange(this.website);
}

class OnFacebookChange extends UpdateProfileEvent {
  final String facebook;

  OnFacebookChange(this.facebook);
}

class OnInstagramChange extends UpdateProfileEvent {
  final String instagram;

  OnInstagramChange(this.instagram);
}

class OnYoutubeChange extends UpdateProfileEvent {
  final String youtube;

  OnYoutubeChange(this.youtube);
}