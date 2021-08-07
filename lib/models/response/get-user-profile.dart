import 'package:thelawala/models/response/image-response.dart';

class UserProfileResponse {
  late String vendorid;
  late String name;
  late String tagline;
  late String introduction;
  late String email;
  late String phone;
  late String website;
  late String facebook;
  late String instagram;
  late String youtube;
  late String twitter;
  late List<String> cuisines;
  late List<String> cities;
  late Images? logo;

  UserProfileResponse(
      { required this.vendorid,
        required this.name,
        required this.tagline,
        required this.introduction,
        required this.email,
        required this.phone,
        required this.website,
        required this.facebook,
        required this.instagram,
        required this.youtube,
        required this.twitter,
        required this.cuisines,
        required this.cities,
        required this.logo });

  UserProfileResponse.fromJson(Map<String, dynamic> json) {
    vendorid = json['vendorid'];
    name = json['name'];
    tagline = json['tagline'] ?? '';
    introduction = json['introduction'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    website = json['website'] ?? '';
    facebook = json['facebook'] ?? '';
    instagram = json['instagram'] ?? '';
    youtube = json['youtube'] ?? '';
    twitter = json['twitter'] ?? '';
    cuisines = json['cuisines']?.cast<String>() ?? [];
    cities = json['cities']?.cast<String>() ?? [];
    logo = json['logo'] != null ? Images.fromJson(json['logo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorid'] = this.vendorid;
    data['name'] = this.name;
    data['tagline'] = this.tagline;
    data['introduction'] = this.introduction;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['website'] = this.website;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    data['twitter'] = this.twitter;
    data['cuisines'] = this.cuisines;
    data['cities'] = this.cities;
    return data;
  }
}
