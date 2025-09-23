

import '../../../status/data/model/product_model.dart';

abstract class ProductStatus {}

 class ProductInitial extends ProductStatus {}

class ProductLoading extends ProductStatus {}

class ProductSuccess extends ProductStatus {
  final List<ProductModel> productEntity;
  ProductSuccess(this.productEntity);
}


class ProductError extends ProductStatus {
  final String message;
  ProductError(this.message);
}
