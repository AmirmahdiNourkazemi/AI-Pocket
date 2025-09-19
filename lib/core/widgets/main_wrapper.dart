import 'package:appro_chat/core/session/session_bloc.dart';
import 'package:appro_chat/core/widgets/loading.dart';
import 'package:appro_chat/feature/status/presentation/bloc/status_bloc.dart';
import 'package:appro_chat/feature/status/presentation/bloc/status_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../session/session_event.dart';
import '../session/session_state.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  // Future<void> _checkVpnStatus() async {
  //   bool isVpnActive = await VpnService.isVpnActive();
  //   if (isVpnActive) {
  //     VpnService.showVpnSnackBar(context);
  //   }
  // }

  @override
  void initState() {
    // _checkVpnStatus();
    Future.delayed(const Duration(seconds: 3), () {
      BlocProvider.of<CheckAuthBloc>(context).add(CheckAuthStart());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckAuthBloc, CheckAuthState>(
      listener: (context, state) {
        if (state is CheckAuthRequired) {
          Navigator.of(context).pushReplacementNamed('/login');
        } else if (state is CheckAuthNotRequired) {
          BlocProvider.of<StatusBloc>(context).add(StatusInitialEvent());
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Scaffold(
        body: Center(
          child: aiLoadingWidget(context),
        ),
      ),
    );
  }
}
