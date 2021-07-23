class EditProfileRequest {
  late String name;
  late List<String>? cities;
  late List<String>? cuisines;
  late String? introduction;
  late ContactRequest? contact;
  late SocialRequest? social;

  EditProfileRequest(
      {required this.name,
       this.cities,
       this.cuisines,
       this.introduction,
       this.contact,
       this.social});

  EditProfileRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cities = json['cities'].cast<String>();
    cuisines = json['cuisines'].cast<String>();
    introduction = json['introduction'];
    contact =
        (json['contact'] != null ? new ContactRequest.fromJson(json['contact']) : null)!;
    social =
        (json['social'] != null ? new SocialRequest.fromJson(json['social']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cities'] = this.cities;
    data['cuisines'] = this.cuisines;
    data['introduction'] = this.introduction;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.social != null) {
      data['social'] = this.social!.toJson();
    }
    return data;
  }
}

class ContactRequest {
  late String phone;
  late String email;
  late String website;

  ContactRequest({required this.phone, required this.email, required this.website});

  ContactRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['website'] = this.website;
    return data;
  }
}

class SocialRequest {
  late String facebook;
  late String instagram;
  late String? twitter;
  late String youtube;

  SocialRequest(
      {required this.facebook,
      required this.instagram,
      this.twitter,
      required this.youtube});

  SocialRequest.fromJson(Map<String, dynamic> json) {
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
