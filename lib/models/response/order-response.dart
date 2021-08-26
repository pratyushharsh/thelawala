class OrderResponse {
  late String orderId;
  late String userId;
  late String vendorId;
  late DateTime orderDate;
  late double total;
  late double subtotal;
  late double tax;
  late String orderCurrency;
  late String status;
  late List<LineItems> lineItems;

  OrderResponse(
      { required this.orderId,
        required this.userId,
        required this.vendorId,
        required this.orderDate,
        required this.total,
        required this.subtotal,
        required this.tax,
        required this.orderCurrency,
        required this.status,
        required this.lineItems});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    userId = json['userId'];
    vendorId = json['vendorId'];
    orderDate = DateTime.parse(json['orderDate']);
    total = json['total'].toDouble();
    subtotal = json['subtotal'].toDouble();
    tax = json['tax'].toDouble();
    orderCurrency = json['orderCurrency'];
    status = json['status'];
    if (json['lineItems'] != null) {
      List tmp = json['lineItems'] as List;
      lineItems = tmp.map((e) => LineItems.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['userId'] = this.userId;
    data['vendorId'] = this.vendorId;
    data['orderDate'] = this.orderDate;
    data['total'] = this.total;
    data['subtotal'] = this.subtotal;
    data['tax'] = this.tax;
    data['orderCurrency'] = this.orderCurrency;
    data['status'] = this.status;
    if (this.lineItems != null) {
      data['lineItems'] = this.lineItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineItems {
  late String itemId;
  late double price;
  late String itemDesc;
  late double tax;
  late int quantity;
  late String? imageUrl;

  LineItems(
      { required this.itemId,
        required this.price,
        required this.itemDesc,
        required this.tax,
        required this.quantity,
        required this.imageUrl});

  LineItems.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    price = json['price'].toDouble();
    itemDesc = json['itemDesc'];
    tax = json['tax'].toDouble();
    quantity = json['quantity'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['price'] = this.price;
    data['itemDesc'] = this.itemDesc;
    data['tax'] = this.tax;
    data['quantity'] = this.quantity;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
