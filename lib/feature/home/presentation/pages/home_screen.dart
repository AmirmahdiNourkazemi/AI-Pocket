import 'package:appro_chat/core/theme/svg_icon.dart';
import 'package:appro_chat/core/theme/theme.dart';
import 'package:appro_chat/core/widgets/app_bar.dart';
import 'package:appro_chat/core/widgets/drawer_widget.dart';
import 'package:appro_chat/feature/home/presentation/widgets/ai_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/json/ai.json',
                  height: MediaQuery.of(context).size.height * 0.3),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // prevent scroll conflict
                mainAxisSpacing: Dimensions.marginSmall,
                crossAxisSpacing: Dimensions.marginSmall,
                children: [
                  for (var item in aiList.values)
                    AiContainer(
                      title: item['name'],
                      svgIcon: item['image'],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AiContainer extends StatelessWidget {
  final String title;
  final String svgIcon;
  const AiContainer({
    super.key,
    required this.title,
    required this.svgIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 75,
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.cornerRadiusMedium),
                shape: BoxShape.rectangle,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withOpacity(0.3)
                    ])),
            child: SvgPicture.string(
              svgIcon,
              height: 20,
              width: 20,
            ),
          ),
          const SizedBox(
            height: Dimensions.marginSmall,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 11),
            textDirection: TextDirection.rtl,
          )
        ],
      ),
    );
  }
}
