import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/theme.dart';


class ShimmerWidget extends StatelessWidget {
  final Color? baseColor;
  final Color? highlightColor;
  final double? radius;
  final double? width;
  final double? height;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.radius,
    this.baseColor,
    this.highlightColor,
  });

  factory ShimmerWidget.text({double width = 72}) {
    return ShimmerWidget(width: width, height: 24);
  }

  factory ShimmerWidget.icon({double size = 32, double? radius}) {
    return ShimmerWidget(
      width: size,
      height: size,
      radius: radius ?? Dimensions.cornerRadiusLarge,
    );
  }

  factory ShimmerWidget.container(
      {double width = 72, double height = 40, double? radius}) {
    return ShimmerWidget(
      width: width,
      height: height,
      radius: radius,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? const Color(0xFF888888).withOpacity(0.5),
      highlightColor: highlightColor ?? const Color(0xFF888888).withOpacity(0.1),
      enabled: true,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(radius ?? Dimensions.cornerRadiusSmall),
        child: Container(
          width: width,
          height: height,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}