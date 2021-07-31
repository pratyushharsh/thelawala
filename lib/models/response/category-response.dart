class CategoryResponse {
  late String vendorid;
  late String category;
  late String name;
  late String description;
  late int itemCount;

  CategoryResponse(
      { required this.vendorid,
        required this.category,
        required this.name,
        required this.description,
        required this.itemCount});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    vendorid = json['vendorid'];
    category = json['category'];
    name = json['name'];
    description = json['description'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorid'] = this.vendorid;
    data['category'] = this.category;
    data['name'] = this.name;
    data['description'] = this.description;
    data['itemCount'] = this.itemCount;
    return data;
  }
}