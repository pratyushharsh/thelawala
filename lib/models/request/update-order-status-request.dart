class UpdateOrderStatusRequest {
  late String previousStatus;
  late String status;

  UpdateOrderStatusRequest({required this.previousStatus, required this.status});

  UpdateOrderStatusRequest.fromJson(Map<String, dynamic> json) {
    previousStatus = json['previousStatus'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['previousStatus'] = this.previousStatus;
    data['status'] = this.status;
    return data;
  }
}
