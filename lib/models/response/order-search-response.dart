class OrderSearchResponse {
  late String orderId;
  late String userId;
  late String vendorId;
  late DateTime orderDate;
  late double total;
  late String status;

  OrderSearchResponse(
     {required this.orderId,
      required this.userId,
      required this.vendorId,
      required this.orderDate,
      required this.total,
      required this.status});

  OrderSearchResponse.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    userId = json['userId'];
    vendorId = json['vendorId'];
    orderDate = DateTime.tryParse(json['orderDate'])!;
    total = json['total'].toDouble();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['userId'] = this.userId;
    data['vendorId'] = this.vendorId;
    data['orderDate'] = this.orderDate;
    data['total'] = this.total;
    data['status'] = this.status;
    return data;
  }
}
