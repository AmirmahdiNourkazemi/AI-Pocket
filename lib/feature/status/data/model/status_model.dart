
import 'product_model.dart';

class StatusModel {
  List<ProductModel>? products;
  String? message;
  StatusModel({this.products});

  StatusModel.fromJson(Map<String, dynamic> json) {
 if (json['products'] != null && json['products'] is List) {
      products = (json['products'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } else {
      products = [];
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products?.map((product) => product.toJson()).toList(),
      'message': message
    };
  }
}
