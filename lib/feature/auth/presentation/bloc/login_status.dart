abstract class LoginStatus{}

class LoginInitial extends LoginStatus {}

class LoginLoading extends LoginStatus {}
 
class LoginAsGustLoading extends LoginStatus {} 
 class LoginSuccess extends LoginStatus {
  final String country;
  LoginSuccess(this.country);
 }

 class LoginError extends LoginStatus {
  final String message;
  LoginError(this.message);
 }