import 'package:appro_chat/core/const/app_string.dart';
import 'package:dio/dio.dart';

import '../../../../../core/locator/locator.dart';
import '../../../../../core/network/api_provider_imp.dart';


class AuthApiProvider {
  // Future<Response> loginOtp(String mobile) async {
  //   final res = await locator<ApiProviderImp>()
  //       .post('https://payment.vada.ir/api/auth/login-otp', bodyParameter: {
  //     "mobile": mobile,
  //     'package_name': Constants.packageName,
  //   });
  //   return res;
  // }
  //   Future<Response> loginWithApprroo(String otpToken) async {
  //   final loginWithApprooResponse = await locator<ApiProviderImp>().post(
  //       'https://shenas.vsrv.ir/api/LoginWithApprooTokenV2',
  //       bodyParameter: {
  //         'token': otpToken,
  //         'package_name': Constants.packageName
  //       });
  //   return loginWithApprooResponse;
  // }
  Future<Response> checkOtp(String mobileNumber, String otpToken) async {
    final checkOtpResponse = await locator<ApiProviderImp>().post(
        'https://payment.vada.ir/api/auth/check-otp',
        bodyParameter: {'mobile': mobileNumber, 'token': otpToken});
    return checkOtpResponse;
  }
  Future<Response> approGoogleLogin(String accessToken) async{
 final getApproToken = await  locator
        <ApiProviderImp>().post(
          'https://api.approagency.ir/api/auth/login-google',
          bodyParameter: {
            'access_token': accessToken,
            'package_name': AppString.packageName
          },
        );
         return getApproToken;
  }
 
  // Future<Response> loginAsGust() async{
  //   final getApproToken = await  locator
  //       <ApiProviderImp>().post(
  //         'https://payment.vada.ir/api/auth/check-otp',
  //         bodyParameter: {
  //           'mobile' : '09001234567',
  //           'token' : '96969'
  //         },
  //       );
  //       return getApproToken;
  // } 
  

  
}
