import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

Future<void> showToast(
  BuildContext currentContext,
  String title,
  String description,
  ToastificationType type, {
  bool isIconMessage = false,
}) async {
  // final currentContext = navigatorKey.currentContext;
  // if (currentContext == null) return;

  toastification.show(
    context: currentContext,
    type: type,
    alignment: Alignment.bottomCenter,
    direction: TextDirection.rtl,
    style: ToastificationStyle.minimal,
    showIcon: true,
    dragToClose: true,
    autoCloseDuration: const Duration(seconds: 5),
    applyBlurEffect: true,
    showProgressBar: !isIconMessage,
    title: Text(
      title,
      style: Theme.of(currentContext).textTheme.bodyMedium,
    ),
    description: isIconMessage || description.contains('.')
        ? null
        : Text(
            description,
            style: Theme.of(currentContext).textTheme.bodySmall,
          ),
  );
}
