import 'package:appro_chat/core/locator/locator.dart';
import 'package:appro_chat/core/theme/theme.dart';
import 'package:appro_chat/core/widgets/app_bar.dart';
import 'package:appro_chat/core/widgets/loading_dialog.dart';
import 'package:appro_chat/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:appro_chat/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/widgets/show_toast.dart';
import '../bloc/auth_event.dart';
import '../bloc/login_status.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController mobileController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  // final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AuthBloc>(),
      child: Scaffold(
        appBar: appBar(),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.authStatus is LoginSuccess) {
              hideLoadingDialog(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (route) => false, // Remove all previous routes
              );
            } else if (state.authStatus is LoginError) {
              LoginError error = state.authStatus as LoginError;
              hideLoadingDialog(context);
              showToast(
                context,
                "",
                error.message,
                ToastificationType.error,
              );
            } else if (state.authStatus is LoginLoading ||
                state.otpStatus is LoginAsGustLoading) {
              showLoadingDialog(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Column(
                        //   children: [
                        //     Text(
                        //       FlutterI18n.translate(context, 'welcome-text'),
                        //       style: Theme.of(context).textTheme.titleLarge,
                        //     ),
                        //     const SizedBox(
                        //       height: Dimensions.spaceMedium,
                        //     ),
                        //     Text(
                        //       FlutterI18n.translate(context, 'welcome-page'),
                        //       style: Theme.of(context).textTheme.titleSmall,
                        //     ),
                        //   ],
                        // ),
                        // SvgPicture.asset(
                        //   'assets/images/otp.svg',
                        //   height: MediaQuery.of(context).size.height * 0.35,
                        // )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       FlutterI18n.translate(context, 'login-des'),
                      //       style: Theme.of(context).textTheme.bodyMedium,
                      //     ),
                      //   ],
                      // ),
                      // ValueListenableBuilder(
                      //   valueListenable: LocalData.countAsGuest ,
                      //   builder: (context, value, child) {
                         
                      //     if (value! < 3) {
                      //      return Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 8),
                      //     child: SubmitButton(
                      //         text: 'Login as guest',
                      //         backgroundColor:
                      //             Theme.of(context).colorScheme.secondary,
                      //         isLoading: state.authStatus is LoginAsGustLoading,
                      //         onClick: () {
                      //           locator<LocalData>().saveCountAsGuest(
                      //             LocalData.countAsGuest.value! + 1,
                      //           );
                      //           BlocProvider.of<AuthBloc>(context)
                      //               .add(LoginAsGuestEvent());
                      //         }),
                      //   );   
                      //     } else {
                      //       return Container();
                      //     }
                           
                      //   },
                        
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 8),
                      //   child: SubmitButton(
                      //       text: 'Login with Google',
                      //       icon: AppIcons.google,
                      //       isLoading: state.authStatus is LoginLoading,
                      //       onClick: () {
                              
                      //       }),
                      // ),
                      ElevatedButton(onPressed: (){
                        BlocProvider.of<AuthBloc>(context)
                                  .add(LoginOtpEvent());
                      }, child: Text('Login with google'))
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.spaceLarge,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
