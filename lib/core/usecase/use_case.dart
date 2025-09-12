
abstract class UseCase<T, P> {
  Future<T> call(P params);
}

class NoParams {}

class OtpParams {
  final String mobile;
  final String otpToken;
  OtpParams(this.mobile, this.otpToken);
}

class StoreMessage {
  final int id;
  final String body;
  StoreMessage(this.id, this.body);
}

class MyketPayment {
  final String productId;
  final String productUuid;
  MyketPayment(this.productId, this.productUuid);
}

