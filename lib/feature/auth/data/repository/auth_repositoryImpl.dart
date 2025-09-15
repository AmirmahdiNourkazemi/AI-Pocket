import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/custome_error.dart';
import '../../../../core/localstorage/local_data.dart';
import '../../../../core/locator/locator.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/remote/api_provider.dart';
import '../model/user.dart' as userLocal;

class AuthRepositoryimpl extends AuthRepository {
  AuthApiProvider apiProvider;
  GoogleSignIn googleSignIn;
  AuthRepositoryimpl(this.apiProvider,this.googleSignIn);
  @override
  Future<DataState<String>> loginGoogleApprroo(String accessToken) async{
    Response response =    await apiProvider.approGoogleLogin(accessToken);

    if (response.statusCode == 200) {
      await locator<LocalData>().saveApproToken(response.data['token']);
      // print(right('ok'));
      return const DataSuccess('ok');
    } else {
      return DataError(
          errorConvertor(response.statusCode, response.data['message']));
    }
  }
  
  @override
  Future<DataState<String>?> signInWithGoogle() async{
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    return googleAuth.accessToken != null ? await loginGoogleApprroo(googleAuth.accessToken!) : null;
  }
  
  // @override
  // Future<DataState<String>?> signInAsGust() async{
  //  Response response =   await apiProvider.loginAsGust();

  //   if (response.statusCode == 200) {
  //     await locator<LocalData>().saveApproToken(response.data['token']);
  //     // print(right('ok'));
  //     return const DataSuccess('ok');
  //   } else {
  //     return DataError(
  //         errorConvertor(response.statusCode, response.data['message']));
  //   }
  // }

}
