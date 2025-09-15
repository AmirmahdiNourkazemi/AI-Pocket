import 'package:appro_chat/feature/auth/data/model/check_otp_model.dart';

import '../../../../core/usecase/use_case.dart';
import '../../data/model/user.dart';

abstract class AuthEvent {}

class LoginOtpEvent extends AuthEvent {
  
}

class LoginAsGuestEvent extends AuthEvent {}

class CheckOtpEvent extends AuthEvent {
  final OtpParams params;
  CheckOtpEvent(this.params);
}
class SaveUserEvent extends AuthEvent {
  final User user;
  SaveUserEvent(this.user);
}