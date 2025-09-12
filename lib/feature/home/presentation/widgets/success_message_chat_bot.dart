import 'package:appro_chat/core/widgets/loading_dialog.dart';
import 'package:appro_chat/core/widgets/validate.dart';
import 'package:appro_chat/feature/home/data/models/get_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:markdown_widget/widget/blocks/leaf/paragraph.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:printing/printing.dart';

class SuccessMessageChatBot extends StatefulWidget {
  final GetChat message;
  const SuccessMessageChatBot({super.key, required this.message});

  @override
  State<SuccessMessageChatBot> createState() => _SuccessMessageChatBotState();
}

class _SuccessMessageChatBotState extends State<SuccessMessageChatBot> {
  late DraggableScrollableController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = DraggableScrollableController();

    super.initState();
  }

  Future<Uint8List> generatePdf() async {
    try {
      final pdf = pw.Document();
      final fontData =
          await rootBundle.load("assets/fonts/IRANYekanRegularFaNum.ttf");
      final ttf = pw.Font.ttf(fontData);

      final messages = Validate.cleanText(widget.message.content);

      pdf.addPage(
        pw.MultiPage(
          textDirection: pw.TextDirection.rtl,
          build: (pw.Context context) {
            return [
              pw.Paragraph(
                text: messages,
                style: pw.TextStyle(fontSize: 14, height: 1.6, font: ttf),
                textAlign: pw.TextAlign.right,
              ),
            ];
          },
        ),
      );

      return pdf.save();
    } catch (e) {
      print(e);

      // showToast(context, 'خطا در تبدیل به فایل', '', ToastificationType.error);
      return Uint8List(0);
    }
  }

  Future<void> press() async {
    showLoadingDialog(context, title: 'در حال آماده‌سازی فایل');

    final pdfBytes = await generatePdf();

    hideLoadingDialog(context);

    if (pdfBytes.isNotEmpty) {
      await Printing.layoutPdf(
        usePrinterSettings: true,
        onLayout: (PdfPageFormat format) async => pdfBytes,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      controller: _controller,
      shouldCloseOnMinExtent: false,
      minChildSize: 0.20,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextButton.icon(
                                  iconAlignment: IconAlignment.end,
                                  label: Text(
                                    'دانلود',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  ),
                                  onPressed: () async {
                                    await press();
                                  },
                                  icon: const Icon(MingCute.download_line)),
                              TextButton.icon(
                                  iconAlignment: IconAlignment.end,
                                  label: Text(
                                    'اشتراک گذاری',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  ),
                                  onPressed: () async {
                                    SharePlus.instance.share(ShareParams(
                                        text:
                                            '${widget.message.content} \n تولید شده از اپلیکیشن اپروچت'));
                                  },
                                  icon: const Icon(MingCute.share_2_line))
                            ],
                          ),
                          TextButton.icon(
                              iconAlignment: IconAlignment.end,
                              label: Text(
                                'بازگشت',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              icon: const Icon(MingCute.arrow_left_line)),
                        ],
                      ),
                      Center(
                        child: MarkdownBlock(
                          data: Validate.cleanText(widget.message.content),
                          config: MarkdownConfig(configs: [
                            PConfig(
                              textStyle: Theme.of(context).textTheme.bodySmall!,
                            ),
                            H1Config(
                              style: Theme.of(context).textTheme.bodyLarge!,
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                          icon: const Icon(MingCute.copy_fill),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 40)),
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: widget.message.content),
                            );
                          },
                          label: const Text('کپی متن'))
                    ]),
              )),
        );
      },
    );
  }
}
