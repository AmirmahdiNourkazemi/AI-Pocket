import 'pivot_model.dart';

class ProductModel {
  int? id;
  int? package_name_id;
  String? title;
  num? price;
  String? uuid;
  PivotModel? pivot;

  ProductModel({
    this.id,
    this.package_name_id,
    this.title,
    this.price,
    this.uuid,
    this.pivot,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    package_name_id = json['package_name_id'];
    title = json['title'];
    price = json['price'];
    uuid = json['uuid'];
    pivot = json['pivot'] != null ? PivotModel.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'package_name_id': package_name_id,
      'title': title,
      'price': price,
      'uuid': uuid,
      'pivot': pivot?.toJson(),
    };
  }
}