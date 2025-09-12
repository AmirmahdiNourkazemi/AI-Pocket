import 'package:appro_chat/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'loading.dart';

void showLoadingDialog(BuildContext context,
    {String title = '...لطفا صبر کنید'}) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing when tapping outside
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              aiLoadingWidget(context),
              const SizedBox(height: Dimensions.marginMedium),
              Text(title),
            ],
          ),
        ),
      );
    },
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
