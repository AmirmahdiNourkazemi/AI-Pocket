import 'package:appro_chat/core/localstorage/local_data.dart';
import 'package:appro_chat/core/theme/theme.dart';
import 'package:appro_chat/core/widgets/icon_container.dart';
import 'package:flutter/material.dart';

import '../../../product/presentation/widget/product_buttom_sheet.dart';

class FreeUsageListenable extends StatelessWidget {
  final bool? showModalProduct;
  const FreeUsageListenable({super.key, this.showModalProduct = false});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LocalData.storeMessageCount,
      builder: (context, value, child) {
        if (value == 0) {
          if (showModalProduct!) {
            showModalBottomSheet(
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const ProductBottomSheet();
                });
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const IconContainer(
                icon: Icons.warning_amber_rounded,
                size: 20,
                padding: 2,
              ),
              const SizedBox(
                width: Dimensions.marginExtraSmall,
              ),
              Text(
                'فرصت رایگان شما به اتمام رسید',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const IconContainer(
                icon: Icons.warning_amber_rounded,
                size: 20,
                padding: 2,
              ),
              // Icon(Icons.warning_amber_rounded , color: Theme.of(context).colorScheme.primary,),
              const SizedBox(
                width: Dimensions.marginExtraSmall,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'فقط ', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: value.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        decoration: TextDecoration.underline)),
                TextSpan(
                    text: ' فرصت رایگان دارید',
                    style: Theme.of(context).textTheme.bodySmall),
              ])),
            ],
          );
        }
      },
    );
  }
}
