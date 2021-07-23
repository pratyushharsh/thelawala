part of 'update_profile_bloc.dart';

enum UpdateProfileStatus { INITIAL, PREFILLED_DATA, AWAITING_CONFIRMATION, SUCCESS, FAILURE }

class UpdateProfileState extends Equatable {
  final String name;
  final List<String> cities;
  final List<String> dishes;
  final String introduction;
  final String phone;
  final String email;
  final String website;
  final String facebook;
  final String twitter;
  final String instagram;
  final String youtube;
  final UpdateProfileStatus status;

  bool isValid() {
    var _valid = true;
    if (_valid && !name.isValid(required: true)) {
      _valid = false;
      return _valid;
    }

    if (_valid &&
        !phone.isValid(required: true, regex: InputValidator.phoneValidator)) {
      _valid = false;
      return _valid;
    }

    // if (_valid && !email.isValid(required: true)) {
    //   _valid = false;
    //   return _valid;
    // }

    if (_valid && !introduction.isValid(required: true)) {
      _valid = false;
      return _valid;
    }

    return _valid;
  }

  UpdateProfileState(
      {required this.name,
      required this.cities,
      required this.dishes,
      required this.introduction,
      required this.phone,
      required this.email,
      required this.website,
      required this.facebook,
      required this.twitter,
      required this.instagram,
      required this.youtube,
      required this.status});

  UpdateProfileState copyWith(
      {String? name,
      List<String>? cities,
      List<String>? dishes,
      String? introduction,
      String? phone,
      String? email,
      String? website,
      String? facebook,
      String? twitter,
      String? instagram,
      String? youtube,
      UpdateProfileStatus? status}) {
    return UpdateProfileState(
        name: name ?? this.name,
        cities: cities ?? this.cities,
        dishes: dishes ?? this.dishes,
        introduction: introduction ?? this.introduction,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        website: website ?? this.website,
        facebook: facebook ?? this.facebook,
        twitter: twitter ?? this.twitter,
        instagram: instagram ?? this.instagram,
        youtube: youtube ?? this.youtube,
        status: status ?? this.status);
  }

  @override
  String toString() {
    return 'UpdateProfileState{name: $name, cities: $cities, dishes: $dishes, introduction: $introduction, phone: $phone, email: $email, website: $website, facebook: $facebook, instagram: $instagram, youtube: $youtube, status: $status}';
  }

  @override
  List<Object?> get props => [
        name,
        cities,
        dishes,
        introduction,
        phone,
        email,
        website,
        facebook,
    twitter,
        instagram,
        youtube,
        status
      ];
}
