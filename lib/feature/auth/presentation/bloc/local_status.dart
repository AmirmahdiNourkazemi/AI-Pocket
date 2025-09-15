
abstract class LocalStatus{}

class LocalInitial extends LocalStatus {}

class LocalLoading extends LocalStatus {}
 
 class LocalSuccess extends LocalStatus {
  final String ok;
  LocalSuccess(this.ok);
 }

 class LocalError extends LocalStatus {
  final String message;
  LocalError(this.message);
 }