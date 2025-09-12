import 'package:appro_chat/core/route/names.dart';
import 'package:appro_chat/feature/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
Map<String, Widget Function(BuildContext)> routes = {
   ScreenNames.home : (context) => const HomeScreen()
};
