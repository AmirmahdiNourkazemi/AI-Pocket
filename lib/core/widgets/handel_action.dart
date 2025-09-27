import 'package:appro_chat/core/localstorage/local_data.dart';
import 'package:appro_chat/core/locator/locator.dart';
import 'package:appro_chat/core/widgets/show_toast.dart';
import 'package:appro_chat/feature/product/presentation/widget/product_buttom_sheet.dart';
import 'package:appro_chat/feature/status/data/model/status_model.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class HandelAction {
  static Future<int?> freeUsage() async {
    return await locator<LocalData>().loadStoreMessageCount();
  }

  static Future<StatusModel?> getStatus() async {
    return await locator<LocalData>().loadStatus();
  }

  static void handleStatusUser({
    required BuildContext context,
    required VoidCallback? onTap,
    bool? navigateBack = false,
    bool? sub,
  }) async {
    await getStatus().then((value) async {
      print(value?.products);
      if (value?.products?.isEmpty ?? true) {
        await freeUsage();
        // print(LocalData.storeMessageCount.value);
        if (sub == false) {
          onTap?.call();
        } else {
          showToast(
            context,
            'خرید اشتراک',
            'برای استفاده لطفا اشتراک تهیه کنید',
            ToastificationType.warning,
          );
          // Navigator.of(context).pop();

          showModalBottomSheet(
            showDragHandle: true,
            context: context,
            builder: (BuildContext context) {
              return const ProductBottomSheet();
            },
          );
        }
      } else {
        onTap?.call();
      }
    });
  }
}
