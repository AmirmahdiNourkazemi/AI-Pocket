import 'package:appro_chat/core/locator/locator.dart';
import 'package:appro_chat/core/route/names.dart';
import 'package:appro_chat/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:appro_chat/feature/auth/presentation/screen/login_screen.dart';
import 'package:appro_chat/feature/home/presentation/bloc/chat_bloc.dart';
import 'package:appro_chat/feature/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.home: (context) => BlocProvider<ChatBloc>(
        create: (context) => locator<ChatBloc>(),
        child: const HomeScreen(),
      ),

  ScreenNames.login : (context) => BlocProvider<AuthBloc>(
        create: (context) => locator<AuthBloc>(),
        child: const LoginScreen(),
      ),    
};
