import 'package:appro_chat/core/localstorage/local_data.dart';
import 'package:appro_chat/core/theme/svg_icon.dart';
import 'package:appro_chat/core/theme/theme.dart';
import 'package:appro_chat/core/usecase/use_case.dart';
import 'package:appro_chat/core/widgets/app_bar.dart';
import 'package:appro_chat/core/widgets/drawer_widget.dart';
import 'package:appro_chat/core/widgets/handel_action.dart';
import 'package:appro_chat/core/widgets/loading_dialog.dart';
import 'package:appro_chat/feature/home/data/models/get_chat.dart';
import 'package:appro_chat/feature/home/presentation/bloc/chat_bloc.dart';
import 'package:appro_chat/feature/home/presentation/bloc/chat_event.dart';
import 'package:appro_chat/feature/home/presentation/bloc/chat_state.dart';
import 'package:appro_chat/feature/home/presentation/widgets/ai_list.dart';
import 'package:appro_chat/feature/home/presentation/widgets/show_input_chat_buttom_sheet.dart';
import 'package:appro_chat/feature/home/presentation/widgets/success_message_chat_bot.dart';
import 'package:appro_chat/feature/product/presentation/widget/product_buttom_sheet.dart';
import 'package:appro_chat/feature/status/presentation/widget/free_usage_listenable.dart';
import 'package:appro_chat/feature/status/presentation/widget/status_value_listenable.dart';
import 'package:appro_chat/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

import '../widgets/premium_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatSuccess) {
          // Navigator.pop(context);
          hideLoadingDialog(context);
          showModalBottomSheet(
              showDragHandle: true,
              isScrollControlled: true,
              useSafeArea: true,
              isDismissible: false,
              context: context,
              backgroundColor: Theme.of(context).colorScheme.background,
              builder: (context) {
                return SuccessMessageChatBot(
                  message: state.chat,
                );
              });
        } else if (state is ChatLoading) {
          Navigator.pop(context);
          showLoadingDialog(context);
        } else if (state is ChatFailure) {
          hideLoadingDialog(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        endDrawer: const DrawerWidget(),
        appBar: appBar(key: scaffoldKey),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: StatusValueListenable(statusEmpty:Directionality(
                      textDirection: TextDirection.rtl,
                      child: GoPremiumWidgetWithIcon(
                        onTap: () {
                          showModalBottomSheet(
                                      showDragHandle: true,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.onPrimary,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const ProductBottomSheet();
                                      },
                                    );
                        },
                      ),
                    ))),
                GridView.count(
                  padding: const EdgeInsets.all(Dimensions.marginSmall),
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // prevent scroll conflict
                  mainAxisSpacing: Dimensions.marginSmall,
                  crossAxisSpacing: Dimensions.marginSmall,
                  children: [
                    for (var item in aiList.values)
                      BlocProvider.value(
                        // create: (context) => SubjectBloc(),
                        value: context.read<ChatBloc>(),
                        child: AiContainer(
                          item: item,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AiContainer extends StatelessWidget {
  final Map<String, dynamic> item;
  const AiContainer({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LocalData.statusNotifier,
      builder: (context, value, child) {
        final notPaid = value?.products?.isEmpty;
        return InkWell(
          onTap: () {
            HandelAction.handleStatusUser(
              context: context,
              sub: item['subscription'],
              onTap: () {
                if (item['no-input'] == true) {
                  context.read<ChatBloc>().add(SendMessageEvent(
                      StoreMessage(item['system'], item['hint'])));
                }
                showInputChatButtomSheet(context: context, item: item);
              },
            );
          },
          child: SizedBox(
            height: 150,
            width: 75,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Column(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.cornerRadiusMedium),
                          shape: BoxShape.rectangle,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.3)
                              ])),
                      child: SvgPicture.string(
                        item['image'],
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.marginSmall,
                    ),
                    Text(
                      item['name'],
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 11),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                if (item['subscription'] == true) ...[
                  if (notPaid == true) ...[
                    Positioned(
                      top: 1,
                      left: 22,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.onBackground,
                            borderRadius: BorderRadius.circular(
                                Dimensions.cornerRadiusMedium)),
                        child: Icon(
                          Iconsax.crown_1_outline,
                          color: Theme.of(context).colorScheme.background,
                          size: 18,
                        ),
                      ),
                    ),
                  ]
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
