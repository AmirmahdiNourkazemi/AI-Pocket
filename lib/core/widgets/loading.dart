import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

Widget aiLoadingWidget(BuildContext context) {
  return Center(
    child: Lottie.asset('assets/json/ai.json', height: 80),
  );
}
