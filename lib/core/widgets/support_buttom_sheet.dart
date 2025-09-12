import 'package:appro_chat/core/theme/theme.dart';
import 'package:appro_chat/core/widgets/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportButtomSheet extends StatelessWidget {
  const SupportButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   color: Theme.of(context).colorScheme.onPrimary,
      //   borderRadius: const BorderRadius.only(
      //       topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'ارتباط با پشتیبانی از طریق تلگرام و واتساپ',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: Dimensions.marginSmall,
              ),
              const IconContainer(
                icon: MingCute.question_line,
                padding: 2,
                size: 24,
              ),
            ],
          ),
          const SizedBox(
              height: 8.0), // Replace with AppDimens.smallDimen.sizedBoxHeight
          ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                ),
            onPressed: () async {
              launch("https://t.me/crmapps");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Telegram", // Replace with "تلگرام"
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ), // Replace with AppTextStyles.buttonTitleTextStyle
                ),
                const SizedBox(
                    width:
                        8.0), // Replace with AppDimens.mediumDimen.sizedBoxWidth
                const Icon(
                  Bootstrap.telegram,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
              onPressed: () {
                launch(
                    "https://wa.me/+989109838553?text= کاربر برنامه ی همکالری");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "WhatsApp", // Replace with "تلگرام"
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .white), // Replace with AppTextStyles.buttonTitleTextStyle
                  ),
                  const SizedBox(
                      width:
                          8.0), // Replace with AppDimens.mediumDimen.sizedBoxWidth
                  const Icon(
                    Bootstrap.whatsapp,
                    color: Colors.white,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
