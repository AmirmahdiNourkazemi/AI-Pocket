class PivotModel {
  int? product_id;
  DateTime? expire_date;

  PivotModel({this.product_id, this.expire_date}) {
    // Calculate remaining days during initialization
  }
  PivotModel.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    expire_date = DateTime.parse(json['expire_at'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
      'expire_at': expire_date?.toIso8601String(),
    };
  }
}
