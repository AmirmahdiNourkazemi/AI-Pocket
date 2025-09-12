import 'package:appro_chat/core/const/app_string.dart';
import 'package:appro_chat/core/widgets/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

PreferredSizeWidget appBar(
    {Widget? child,
    List<Widget>? action,
    bool? automaticallyImplyLeading,
    GlobalKey<ScaffoldState>? key,
    bool? showUsage = false}) {
  return AppBar(
    centerTitle: true,
    elevation: 2,
    title: const Text(AppString.appName),
    leadingWidth: 110,
    // leading: Padding(
    //   padding: const EdgeInsets.only(left: 10),
    //   child: showUsage == true
    //       ? ValueListenableBuilder(
    //           valueListenable: LocalData.statusNotifier,
    //           builder: (context, value, child) {
    //             bool isPro;
    //             if (value == null || value.products!.isEmpty) {
    //               isPro = false;
    //             } else {
    //               isPro = true;
    //             }
    //             if (isPro) {
    //               return const Row(
    //                 children: [
    //                   Text(
    //                     'اشتراک دارید',
    //                     style: TextStyle(fontSize: 10),
    //                   ),
    //                   SizedBox(
    //                     width: Dimensions.marginExtraSmall,
    //                   ),
    //                   Icon(
    //                     MingCute.trophy_line,
    //                     size: 20,
    //                   ),
    //                 ],
    //               );
    //             } else {
    //               return ValueListenableBuilder(
    //                 valueListenable: LocalData.freeUsageCount,
    //                 builder: (context, value, child) {
    //                   if (value == 0) {
    //                     return GestureDetector(
    //                       onTap: () {
    //                         showModalBottomSheet(
    //                             showDragHandle: true,
    //                             isScrollControlled: true,
    //                             context: context,
    //                             builder: (context) {
    //                               return const ProductBottomSheet();
    //                             });
    //                       },
    //                       child: const Row(
    //                         children: [
    //                           Text(
    //                             'اشتراک ندارید',
    //                             style: TextStyle(fontSize: 10),
    //                           ),
    //                           SizedBox(
    //                             width: Dimensions.marginExtraSmall,
    //                           ),
    //                           Icon(
    //                             MingCute.shopping_cart_1_line,
    //                             size: 20,
    //                           ),
    //                         ],
    //                       ),
    //                     );
    //                   } else {
    //                     return Row(
    //                       children: [
    //                         const Text(
    //                           'فرصت رایگان',
    //                           style: TextStyle(fontSize: 10),
    //                         ),
    //                         const SizedBox(
    //                           width: Dimensions.marginExtraSmall,
    //                         ),
    //                         Text(
    //                           value.toString(),
    //                           style: const TextStyle(fontSize: 12),
    //                         ),
    //                         const SizedBox(
    //                           width: Dimensions.marginExtraSmall,
    //                         ),
    //                         const Icon(
    //                           MingCute.shopping_cart_1_line,
    //                           size: 20,
    //                         ),
    //                       ],
    //                     );
    //                   }
    //                 },
    //               );
    //             }
    //           },
    //         )
    //       : null,
    // ),
    actions: [
      if (action != null) ...[...action],
      key != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconContainer(
                icon: MingCute.menu_line,
                onTap: () => key.currentState!.openEndDrawer(),
                size: 28,
                padding: 5,
              ),
            )
          : Container(),
    ],
    automaticallyImplyLeading: automaticallyImplyLeading ?? false,
  );
}
