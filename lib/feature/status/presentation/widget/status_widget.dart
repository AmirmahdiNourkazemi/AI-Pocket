// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:med_ai/core/Theme/app_icons.dart';
// import 'package:med_ai/core/Theme/theme.dart';
// import 'package:med_ai/core/widgets/show_toast.dart';
// import 'package:med_ai/features/status/data/model/status_model.dart';
// import 'package:med_ai/utils/icon_container.dart';
// import 'package:med_ai/utils/sheet_container.dart';
// import 'package:toastification/toastification.dart';

// import '../../../../core/localstorage/local_data.dart';
// import '../../../../utils/cal_time_dif.dart';
// import '../../../product/presentation/widget/product_buttom_sheet.dart';
// import '../../data/model/status_model.dart';

// class StatusWidget extends StatelessWidget {
//   const StatusWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<StatusModel?>(
//       valueListenable: LocalData.statusNotifier,
//       builder: (context, status, child) {
//         return SheetContainer(
//           onTap: () {
//              showModalBottomSheet(
//                 showDragHandle: true,
//                 backgroundColor: Theme.of(context).colorScheme.onPrimary,
//                 context: context,
//                 builder: (BuildContext context) {
//                   return const ProductBottomSheet();
//                 },
//               );
//             // if (status == null || status.products!.isEmpty) {
//             //   showModalBottomSheet(
//             //     showDragHandle: true,
//             //     backgroundColor: Theme.of(context).colorScheme.onPrimary,
//             //     context: context,
//             //     builder: (BuildContext context) {
//             //       return const ProductBottomSheet();
//             //     },
//             //   );
//             // } else {
//             //   showToast(
//             //       context, 'شما اشتراک دارید', '', ToastificationType.warning,
//             //       isIconMessage: true);
//             // }
//           },
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               if (status != null &&
//                   status.products != null &&
//                   status.products!.isNotEmpty) ...[
//                 Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(status.products![0].title!,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodySmall!
//                               .copyWith(fontWeight: FontWeight.bold)),
//                       const SizedBox(
//                         height: Dimensions.spaceSmall,
//                       ),
//                       if (status.products![0].pivot != null) ...[
//                         Text(
//                           '${calculateRemainingDays(status.products![0].pivot!.expire_date)} روز باقی مانده',
//                           style: Theme.of(context).textTheme.bodySmall,
//                         )
//                       ] else ...[
//                         Text(
//                           'اشتراک نامحدود',
//                           style: Theme.of(context).textTheme.bodySmall,
//                         )
//                       ]
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 if (status.products![0].pivot == null) ...[
//                   const IconContainer(
//                     icon: AppIcons.shop,
//                   )
//                 ] else ...[
//                   const IconContainer(
//                     icon: AppIcons.crown,
//                   ),
//                 ]
//               ] else ...[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           'شما اشتراک ندارید',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodySmall!
//                               .copyWith(fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           height: Dimensions.spaceSmall,
//                         ),
//                         InkWell(
//                           onTap: () {},
//                           child: Text('لطفا اشتراک تهیه کنید',
//                               style: Theme.of(context).textTheme.bodySmall),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const IconContainer(
//                       icon: AppIcons.shop,
//                     )
//                   ],
//                 )
//               ],
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
