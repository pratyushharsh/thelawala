class UserProfileResponse {
  late List<String>? cities;
  late Contact contact;
  late List<String>? cuisines;
  late String id;
  late String introduction;
  late String name;
  late Social social;

  UserProfileResponse(
      {this.cities,
        required this.contact,
        this.cuisines,
        required this.id,
        required this.introduction,
        required this.name,
        required this.social});

  UserProfileResponse.fromJson(Map<String, dynamic> json) {
    cities = json['cities'] != null ? json['cities'].cast<String>() : [];
    contact =
    (json['contact'] != null ? new Contact.fromJson(json['contact']) : null)!;
    cuisines = json['cuisines'] != null ? json['cuisines'].cast<String>() : [];
    id = json['id'];
    introduction = json['introduction'];
    name = json['name'];
    social =
    (json['social'] != null ? new Social.fromJson(json['social']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cities'] = this.cities;
    if (this.contact != null) {
      data['contact'] = this.contact.toJson();
    }
    data['cuisines'] = this.cuisines;
    data['id'] = this.id;
    data['introduction'] = this.introduction;
    data['name'] = this.name;
    if (this.social != null) {
      data['social'] = this.social.toJson();
    }
    return data;
  }
}

class Contact {
  late String email;
  late String phone;
  late String? website;

  Contact({required this.email, required this.phone, this.website});

  Contact.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['website'] = this.website;
    return data;
  }
}

class Social {
  late String? facebook;
  late String? instagram;
  late String? twitter;
  late String? youtube;

  Social({this.facebook, this.instagram, this.twitter, this.youtube});

  Social.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['youtube'] = this.youtube;
    return data;
  }
}
