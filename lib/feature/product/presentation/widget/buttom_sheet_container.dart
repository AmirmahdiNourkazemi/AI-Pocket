import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ButtomSheetContainer extends StatelessWidget {
  final Widget child;

  const ButtomSheetContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        // ...productText.map((e) => Padding(
        //       padding: const EdgeInsets.only(bottom: 8),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           Text(
        //             e['title'],
        //             style: Theme.of(context).textTheme.bodySmall,
        //             textDirection: TextDirection.rtl,
        //           ),
        //           const SizedBox(
        //             width: Dimensions.marginSmall,
        //           ),
        //           IconContainer(
        //             icon: MingCute.check_line,
        //             color: Theme.of(context).colorScheme.primary,
        //             size: 20,
        //             padding: 2,
        //           ),
        //         ],
        //       ),
        //     )),
      ],
    );
  }
}
