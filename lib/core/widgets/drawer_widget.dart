import 'package:appro_chat/core/const/app_string.dart';
import 'package:appro_chat/core/localstorage/local_data.dart';
import 'package:appro_chat/core/locator/locator.dart';
import 'package:appro_chat/core/theme/theme.dart';
import 'package:appro_chat/core/widgets/icon_container.dart';
import 'package:appro_chat/core/widgets/support_buttom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool? isDark;
  Future<void> loadIsDark() async {
    return await locator<LocalData>().loadTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadIsDark();
    isDark = LocalData.isDark.value;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                      child: Column(
                    children: [
                      // SvgPicture.asset(
                      //   'assets/images/ic_luncher.svg',
                      //   height: 70,
                      // ),
                      const SizedBox(
                        height: Dimensions.spaceSmall,
                      ),
                      Text(
                        AppString.appName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: Dimensions.marginSmall,
                      ),
                    ],
                  )),
                  SwitchListTile(
                      title: Row(
                        children: [
                          IconContainer(
                              icon: isDark == false
                                  ? MingCute.sun_line
                                  : MingCute.moon_line),
                          const SizedBox(
                            width: Dimensions.marginMedium,
                          ),
                          Text(
                            isDark == false ? 'حالت روز' : 'حالت شب',
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                      value: isDark!,
                      onChanged: (val) async {
                        setState(() {
                          isDark = val;
                        });
                        await locator<LocalData>().saveTheme(val);
                      }),

                  // const Divider(),
                  // ValueListenableBuilder(
                  //   valueListenable: LocalData.statusNotifier,
                  //   builder: (context, value, child) {
                  //     bool isPro;
                  //     if (value == null || value.products!.isEmpty) {
                  //       isPro = false;
                  //     } else {
                  //       isPro = true;
                  //     }
                  //     return ListTile(
                  //       leading: IconContainer(
                  //           icon: isPro
                  //               ? MingCute.trophy_line
                  //               : MingCute.shopping_cart_1_line),
                  //       title: Text(
                  //         isPro ? 'اشتراک دارید' : 'خرید اشتراک',
                  //         style: Theme.of(context).textTheme.titleSmall,
                  //       ),
                  //       subtitle: isPro && value!.products![0].pivot != null
                  //           ? Text(
                  //               '${Validation.calculateRemainingDays(value.products![0].pivot!.expire_date)} روز باقی مانده',
                  //               style: Theme.of(context).textTheme.bodySmall,
                  //             )
                  //           : null,
                  //       onTap: () async {
                  //         HandelAction.handleStatusUser(
                  //             context: context,
                  //             onTap: () {
                  //               if (isPro) {
                  //                 showToast(context, 'شما اشتراک دارید', '',
                  //                     ToastificationType.warning,
                  //                     isIconMessage: true);
                  //               } else {
                  //                 showModalBottomSheet(
                  //                   showDragHandle: true,
                  //                   backgroundColor:
                  //                       Theme.of(context).colorScheme.onPrimary,
                  //                   context: context,
                  //                   builder: (BuildContext context) {
                  //                     return const ProductBottomSheet();
                  //                   },
                  //                 );
                  //               }
                  //             });
                  //       },
                  //     );
                  //   },
                  // ),
                  const Divider(),
                  ListTile(
                    leading: const IconContainer(icon: MingCute.question_line),
                    title: Text(
                      'پشتیبانی',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        showDragHandle: true,
                        context: context,
                        builder: (BuildContext context) {
                          return const SupportButtomSheet();
                        },
                      );
                    },
                  ),
                  // const Divider(),
                  // ListTile(
                  //   leading:
                  //       const IconContainer(icon: MingCute.classify_2_line),
                  //   title: Text(
                  //     'سایر برنامه ها',
                  //     style: Theme.of(context).textTheme.titleSmall,
                  //   ),
                  //   onTap: () async {
                  //     launch(
                  //         'https://play.google.com/store/apps/developer?id=Developers+group');
                  //   },
                  // ),
                  // const Divider(),
                  // ListTile(
                  //   leading: const IconContainer(icon: MingCute.web_line),
                  //   title: Text(
                  //     'وبسایت',
                  //     style: Theme.of(context).textTheme.titleSmall,
                  //   ),
                  //   onTap: () async {
                  //     launch('https://hamkalori.ir/');
                  //   },
                  // ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      'خروج',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading: const IconContainer(icon: MingCute.exit_line),
                    onTap: () async {
                      await locator<LocalData>().saveApproToken('');
                      await locator<LocalData>().saveFinalToken('');
                      // await locator<LocalData>().logOut();
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
            // Version text at the bottom
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  AppString.version,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
