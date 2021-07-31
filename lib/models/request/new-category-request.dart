class NewCategoryRequest {
  late String category;
  late String name;

  NewCategoryRequest({required this.category, required this.name});

  NewCategoryRequest.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['name'] = this.name;
    return data;
  }
}
