class EditProfileRequest {
  late String name;
  late String email;
  late String phone;
  late String introduction;
  late String tagline;
  late String website;
  late String facebook;
  late String instagram;
  late String youtube;
  late String twitter;
  late List<String> cuisines;
  late List<String> tags;

  EditProfileRequest(
      { required this.name,
        required this.email,
        required this.phone,
        required this.introduction,
        required this.tagline,
        required this.website,
        required this.facebook,
        required this.instagram,
        required this.youtube,
        required this.twitter,
        required this.cuisines,
        required this.tags});

  EditProfileRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    introduction = json['introduction'];
    tagline = json['tagline'];
    website = json['website'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    twitter = json['twitter'];
    cuisines = json['cuisines'].cast<String>();
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['introduction'] = this.introduction;
    data['tagline'] = this.tagline;
    data['website'] = this.website;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    data['twitter'] = this.twitter;
    data['cuisines'] = this.cuisines;
    data['tags'] = this.tags;
    return data;
  }
}
