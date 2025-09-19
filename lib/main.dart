import 'package:appro_chat/core/localstorage/local_data.dart';
import 'package:appro_chat/core/locator/locator.dart';
import 'package:appro_chat/core/session/session_bloc.dart';
import 'package:appro_chat/core/widgets/main_wrapper.dart';
import 'package:appro_chat/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:appro_chat/feature/product/presentation/bloc/product_bloc.dart';
import 'package:appro_chat/feature/status/presentation/bloc/status_bloc.dart';
import 'package:appro_chat/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/route/names.dart';
import 'core/route/routes.dart';
import 'core/theme/theme.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await setup();
  await locator<LocalData>().loadTheme();
  await locator<LocalData>().loadApproToken();
  await locator<LocalData>().loadFinalToken();
  await locator<LocalData>().loadImageUrl();
  await locator<LocalData>().loadFreeUsageCount();
  await locator<LocalData>().loadStatus();
  await locator<LocalData>().loadStoreMessageCount();
  // await locator<LocalData>().loadTheme();
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
          // initialRoute: ScreenNames.login,
          navigatorKey: navigatorKey,
          locale: const Locale('fa'),
          theme: AppTheme.light(),
          themeMode: theme ? ThemeMode.dark : ThemeMode.light,
          darkTheme: AppTheme.dark(),
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => locator<AuthBloc>(),
              ),
              BlocProvider(
                create: (context) => locator<CheckAuthBloc>(),
              ),
              BlocProvider(
                create: (context) => locator<StatusBloc>(),
              ),
              BlocProvider(
                create: (context) => locator<ProductBloc>(),
              ),
            ],
            child: const MainWrapper(),
          ),
        );
      },
    );
  }
}
