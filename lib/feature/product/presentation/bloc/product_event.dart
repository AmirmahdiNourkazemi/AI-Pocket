abstract class ProductEvent {}

class ProdcutStartEvent extends ProductEvent {}

class ProductPaymentEvent extends ProductEvent {
  String productID;
  String productUuid;
  ProductPaymentEvent(this.productID , this.productUuid);
}