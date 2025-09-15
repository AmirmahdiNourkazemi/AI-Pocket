import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../../data/model/user.dart';
import '../entities/check_otp_entity.dart';

abstract class AuthRepository {
  // Future<DataState<String>> loginOtp(String mobile);
  // Future<DataState<CheckOtpEntity>> checkOtp(OtpParams params);
  // Future<DataState<String>> storeUser(User user);
  // Future<DataState<User>> getUser();
  // Future<DataState<String>> removeUser();
  Future<DataState<String>> loginGoogleApprroo(String accessToken);
  Future<DataState<String>?> signInWithGoogle();
  //  Future<DataState<String>?> signInAsGust();
}