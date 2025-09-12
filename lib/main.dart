import 'package:appro_chat/core/localstorage/local_data.dart';
import 'package:appro_chat/core/locator/locator.dart';
import 'package:flutter/material.dart';

import 'core/route/names.dart';
import 'core/route/routes.dart';
import 'core/theme/theme.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  await locator<LocalData>().loadTheme();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LocalData.isDark,
      builder: (context, theme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pocket Ai',
          routes: routes,
          initialRoute: ScreenNames.home,
          navigatorKey: navigatorKey,
          locale: const Locale('fa'),
          theme: AppTheme.light(),
          themeMode: theme ? ThemeMode.dark : ThemeMode.light,
          darkTheme: AppTheme.dark(),
        );
      },
    );
  }
}
