import 'dart:io';
import 'package:appro_chat/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
class ViolationDioWrapper {
  static bool _isDialogOpen = false; 
  static Dio provide() {
    final dio = Dio();
    dio.interceptors.add(_getResponseInterceptor());
    return dio;
  }

  static QueuedInterceptor _getResponseInterceptor() {
    return QueuedInterceptorsWrapper(
      onRequest: _onRequest,
      onError: _onError,
      onResponse: _onResponse,
    );
  }

  static void _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    options.headers["Access-Control-Allow-Origin"] = "*";
    options.headers["Access-Control-Allow-Credentials"] = true;
    // options.headers["x-api-key"] = Constants.xApiKey;
    options.headers["Accept-Encoding"] = "gzip, deflate, br";
    options.headers["Access-Control-Allow-Headers"] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    options.headers["Access-Control-Allow-Methods"] =
        "GET, HEAD, POST, OPTIONS";
    options.connectTimeout = const Duration(seconds: 100);
    options.receiveTimeout = const Duration(seconds: 100);
    options.sendTimeout = const Duration(seconds: 100);
    return handler.next(options);
      
  }

  static void _onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  static void _onError(
      DioException errorOptions, ErrorInterceptorHandler handler) async {
        final context = navigatorKey.currentContext;
   if (_isDialogOpen) {
    return handler.reject(errorOptions);
  }

  if (errorOptions.type == DioExceptionType.connectionTimeout ||
      errorOptions.type == DioExceptionType.receiveTimeout ||
      errorOptions.type == DioExceptionType.sendTimeout ||
      errorOptions.error is SocketException ||
      errorOptions.type == DioExceptionType.connectionError ||
      errorOptions.response == null) {
    _showErrorDialog(
      "لطفا اتصال اینترنت خود را بررسی کنید و دوباره تلاش کنید",
    );
    return handler.reject(errorOptions);
  }
   if (errorOptions.response?.statusCode == 401) {
      if (context != null) {
        // showToast(
        //   context,
        //   'لطفا دوباره وارد شوید',
        //   '',
        //   isIconMessage: true,
        //   ToastificationType.error,
        // );
        
      }
      // _navigateToErrorScreen(ScreenNames.login);
      return handler.reject(errorOptions);
    }
    print(errorOptions.response?.statusCode);
    print(errorOptions.response);
    //  print("Request headers: ${errorOptions.response?.headers}");
    //  print("Request URL: ${errorOptions.requestOptions.uri}");
    // print("Status Code: ${errorOptions.response?.statusCode}");
    // print("Response Data: ${errorOptions.response?.data}");
    // print("Error Message: ${errorOptions.message}");
    if (errorOptions.error is SocketException) {
      return handler
          .reject(DioException(requestOptions: errorOptions.requestOptions));
    }
    switch (errorOptions.response?.statusCode) {
      case HttpStatus.forbidden:
        return handler.reject(DioException(
          requestOptions: errorOptions.requestOptions,
        ));
      // case 413:
      //   return handler.reject(DioException(
      //       requestOptions: errorOptions.requestOptions,
      //       error: AppException(exceptionMessage: 'Unauthorized')));
      // case 401:
      //   return handler.reject(DioException(
      //       requestOptions: errorOptions.requestOptions,
      //       error: AppException(exceptionMessage: 'Unauthorized')));
      default:
        if (errorOptions.response != null) {
          return handler.resolve(errorOptions.response!);
        }
    }
    return handler
        .next(DioException(requestOptions: errorOptions.requestOptions));
  }
   static void _navigateToErrorScreen(String routeName) async{
     await Future.delayed(Duration.zero); 
  if (navigatorKey.currentState?.mounted ?? false) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          routeName,
          (route) => false,
        );
      }
  }
static void _showErrorDialog(String message) async {
  if (_isDialogOpen) return;

  _isDialogOpen = true;

  await Future.delayed(Duration.zero);
  if (navigatorKey.currentState?.context != null) {
    showDialog(
      context: navigatorKey.currentState!.context,
      traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
      barrierDismissible: false,
      
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
           title: Text(
              'خطا در اتصال به سرور',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(message , style: Theme.of(context).textTheme.displayMedium!.copyWith(
              height: 1.6
            ),textDirection: TextDirection.rtl,),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(
                    Theme.of(context).textTheme.displayMedium,

                  ),
                ),
                onPressed: () {
                  _isDialogOpen = false;
                  // Navigator.of(context).pushNamedAndRemoveUntil(ScreenNames.mainWrapper, (route) => false);
                },
                child: const Text("تلاش مجدد" ),
              ),
            ],
          ),
        );
      },
    ).then((_) {
      _isDialogOpen = false;
    });
  }
}


}
