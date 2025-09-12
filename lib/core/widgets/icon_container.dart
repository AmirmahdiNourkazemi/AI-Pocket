import 'package:appro_chat/core/theme/theme.dart';
import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final IconData icon;
  final double size;
  final double padding;
  final TextDirection? textDirection;
  final VoidCallback? onTap;
  final Color? color;
  const IconContainer(
      {super.key,
      required this.icon,
      this.size = 30,
      this.padding = 4,
      this.textDirection,
      this.onTap,
      this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Directionality(
        textDirection: textDirection ?? TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(Dimensions.cornerRadiusSmall),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Icon(
              icon,
              size: size,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double padding;
  const CustomContainer({super.key, required this.child, this.padding = 4});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryFixedDim,
        borderRadius: BorderRadius.circular(Dimensions.cornerRadiusSmall),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
