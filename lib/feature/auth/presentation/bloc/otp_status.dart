import '../../domain/entities/check_otp_entity.dart';

abstract class OtpStatus{}

class OtpInitial extends OtpStatus {}

class OtpLoading extends OtpStatus {}
 
 class OtpSuccess extends OtpStatus {
  final CheckOtpEntity otp;
  OtpSuccess(this.otp);
 }

 class OtpError extends OtpStatus {
  final String message;
  OtpError(this.message);
 }