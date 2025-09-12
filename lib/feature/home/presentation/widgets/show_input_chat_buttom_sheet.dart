import 'package:appro_chat/core/locator/locator.dart';
import 'package:appro_chat/core/theme/theme.dart';
import 'package:appro_chat/core/usecase/use_case.dart';
import 'package:appro_chat/feature/home/presentation/bloc/chat_bloc.dart';
import 'package:appro_chat/feature/home/presentation/bloc/chat_event.dart';
import 'package:appro_chat/feature/home/presentation/bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

Future<void> showInputChatButtomSheet({
  required BuildContext context,
  required Map<String, dynamic> item,
}) {
  return showModalBottomSheet(
    context: context,
    enableDrag: true,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.background,
    builder: (context) => BlocProvider.value(
      value: locator<ChatBloc>(),
      child: ShowInputChatButtomSheet(
        item: item,
      ),
    ),
  );
}

class ShowInputChatButtomSheet extends StatefulWidget {
  final Map<String, dynamic> item;
  const ShowInputChatButtomSheet({super.key, required this.item});

  @override
  State<ShowInputChatButtomSheet> createState() =>
      _ShowInputChatButtomSheetState();
}

TextEditingController userTextEditingController = TextEditingController();

class _ShowInputChatButtomSheetState extends State<ShowInputChatButtomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        } else if (state is ChatSuccess) {
          userTextEditingController.clear();
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.only(
              right: 8,
              left: 8,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.background),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.item['label'],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: Dimensions.marginSmall,
                ),
                TextFormField(
                  controller: userTextEditingController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    alignLabelWithHint: true,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: const OutlineInputBorder(),
                    hintText: widget.item['hint'],
                    label: Text(widget.item['label']),
                  ),
                  maxLines: null,
                  minLines: 1,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.right,
                ),
                const SizedBox(
                  height: Dimensions.marginSmall,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: () {
                      context.read<ChatBloc>().add(SendMessageEvent(
                          StoreMessage(widget.item['system'],
                              userTextEditingController.text)));
                    },
                    label: const Text('ارسال به هوش مصنوعی'),
                    icon: state is ChatLoading
                        ? CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : const Icon(MingCute.chat_1_line))
              ],
            ),
          ),
        );
      },
    );
  }
}
