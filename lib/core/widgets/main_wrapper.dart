// import 'package:calorie/core/localstorage/local_data.dart';
// import 'package:calorie/core/locator/locator.dart';
// import 'package:calorie/core/session/session_bloc.dart';
// import 'package:calorie/core/session/session_event.dart';
// import 'package:calorie/core/session/session_state.dart';
// import 'package:calorie/feature/auth/presentation/screen/intro_screen.dart';
// import 'package:calorie/feature/home/presentation/bloc/home_bloc.dart';
// import 'package:calorie/feature/status/presentation/bloc/status_bloc.dart';
// import 'package:calorie/feature/status/presentation/bloc/status_event.dart';
// import 'package:calorie/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../utils/vpn_services.dart';

// class MainWrapper extends StatefulWidget {
//   const MainWrapper({super.key});

//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// class _MainWrapperState extends State<MainWrapper> {
//   Future<void> _checkVpnStatus() async {
//     bool isVpnActive = await VpnService.isVpnActive();
//     if (isVpnActive) {
//       VpnService.showVpnSnackBar(context);
//     }
//   }

//   @override
//   void initState() {
//     _checkVpnStatus();
//     Future.delayed(const Duration(seconds: 3), () {
//       BlocProvider.of<CheckAuthBloc>(context).add(CheckAuthStart());
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CheckAuthBloc, CheckAuthState>(
//       listener: (context, state) {
//         if (state is CheckAuthRequired) {
//           Navigator.of(context).pushReplacementNamed('/login');
//         } else if (state is CheckAuthNotRequired) {
//           BlocProvider.of<StatusBloc>(context).add(StatusInitialEvent());

//          Navigator.of(context).pushReplacementNamed('/home');
//         }else if (state is CheckAuthCompleteProfile) {
//             Navigator.of(context).pushReplacementNamed('/completeProfile');
//         }
//       },
//       child: BlocProvider(
//         create: (context) => locator<HomeBloc>(),
//         child: const SplashScreen(),
//       ),
//       // child: const SplashScreen(),
//     );
//   }
// }
