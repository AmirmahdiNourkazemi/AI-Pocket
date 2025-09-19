import 'package:appro_chat/core/localstorage/local_data.dart';
import 'package:appro_chat/core/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class StatusValueListenable extends StatelessWidget {
  final Widget statusEmpty;
  final bool showToastBool;
  const StatusValueListenable(
      {super.key, required this.statusEmpty, this.showToastBool = false});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LocalData.statusNotifier,
      builder: (context, value, child) {
        if (value == null || value.products!.isEmpty) {
          return statusEmpty;
        } else {
          if (showToastBool) {
            showToast(
                context, 'شما اشتراک دارید', '', ToastificationType.warning,
                isIconMessage: true);
          }
          return const SizedBox.shrink();
        }
      },
    );
  }
}
