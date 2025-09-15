

import 'login_status.dart';
import 'otp_status.dart';

class AuthState {
  LoginStatus authStatus;
  OtpStatus otpStatus;
  // LocalStatus localStatus;
  AuthState({required this.authStatus , required this.otpStatus });

  AuthState copyWith({LoginStatus? authStatus , OtpStatus? otpStatus }) {
  return  AuthState(authStatus: authStatus ?? this.authStatus, 
  otpStatus: otpStatus ?? this.otpStatus,
  //  localStatus:  localStatus ?? this.localStatus
  );
  }     
}
