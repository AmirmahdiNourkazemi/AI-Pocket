
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
  final String system;
  final String user;
  StoreMessage(this.system, this.user);
}

class MyketPayment {
  final String productId;
  final String productUuid;
  MyketPayment(this.productId, this.productUuid);
}

