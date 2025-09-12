import 'package:appro_chat/core/widgets/app_bar.dart';
import 'package:appro_chat/core/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const DrawerWidget(),
      appBar: appBar(key: scaffoldKey),
      body: ListView(
        children: [
          Lottie.asset('assets/json/ai.json',
              height: MediaQuery.of(context).size.height * 0.3)
        ],
      ),
    );
  }
}
