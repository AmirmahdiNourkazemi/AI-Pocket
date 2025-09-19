import 'package:appro_chat/core/locator/locator.dart';
import 'package:appro_chat/core/theme/theme.dart';
import 'package:appro_chat/core/widgets/icon_container.dart';
import 'package:appro_chat/core/widgets/loading.dart';
import 'package:appro_chat/core/widgets/shimmer_loading.dart';
import 'package:appro_chat/feature/status/presentation/bloc/status_bloc.dart';
import 'package:appro_chat/feature/status/presentation/bloc/status_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/widgets/show_toast.dart';
import '../bloc/payment_status.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../bloc/product_status.dart';

class ProductBottomSheet extends StatelessWidget {
  const ProductBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            ProductBloc productBloc = locator<ProductBloc>();
            productBloc.add(ProdcutStartEvent());
            return productBloc;
          },
        ),
        BlocProvider(
          create: (context) => locator<StatusBloc>(),
        ),
      ],
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) async {
          if (state.paymentStatus is ProductPaymentError) {
            ProductPaymentError error =
                state.paymentStatus as ProductPaymentError;
            showToast(context, 'خطا', error.message, ToastificationType.error);
          } else if (state.paymentStatus is ProductPaymentError) {
            ProductPaymentError error =
                state.paymentStatus as ProductPaymentError;
            showToast(context, 'خطا', error.message, ToastificationType.error);
          } else if (state.paymentStatus is ProductPaymentSuccess) {
            showToast(context, 'خرید موفق', 'اشتراک شما با موفقیت ثبت شد',
                ToastificationType.success);
            Navigator.pop(context);
            BlocProvider.of<StatusBloc>(context).add(StatusInitialEvent());
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 20, left: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'برای استفاده از امکانات برنامه باید اشتراک تهیه کنید',
                      style: Theme.of(context).textTheme.bodySmall,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(
                      width: Dimensions.marginSmall,
                    ),
                    const IconContainer(
                      icon: MingCute.left_line,
                      padding: 2,
                      size: 22,
                    ),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.spaceSmall,
                ),
                if (state.status is ProductLoading) ...[
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ...List.generate(2, (val) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Positioned(
                                right: 20,
                                child: ShimmerWidget.text(
                                  width: 70,
                                ),
                              ),
                              Positioned(
                                left: 20,
                                child: ShimmerWidget.container(
                                  width: 70,
                                  height: 40,
                                ),
                              ),
                              ShimmerWidget.container(
                                width: MediaQuery.of(context).size.width,
                                height: 70,
                              ),
                            ],
                          ),
                        );
                      }),

                      // ...productText.map((e) => Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     ShimmerWidget.text(width: MediaQuery.of(context).size.width * 0.5,),
                      //     const SizedBox(
                      //       width: Dimensions.marginSmall,
                      //     ),
                      //     ShimmerWidget.icon(),
                      //   ],
                      // ))
                    ],
                  )
                ] else if (state.status is ProductSuccess) ...[
                  ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      ProductSuccess success = state.status as ProductSuccess;
                      String price =
                          (success.productEntity[index].price! * 1.25)
                              .toStringAsFixed(0);

                      return GestureDetector(
                        onTap: () {
                          context.read<ProductBloc>().add(ProductPaymentEvent(
                              success.productEntity[index].id.toString(),
                              success.productEntity[index].uuid.toString()));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          context.read<ProductBloc>().add(
                                              ProductPaymentEvent(
                                                  success
                                                      .productEntity[index].id
                                                      .toString(),
                                                  success
                                                      .productEntity[index].uuid
                                                      .toString()));
                                        },
                                        child: FittedBox(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (state.paymentStatus
                                                      is ProductPaymentLoading &&
                                                  int.parse((state.paymentStatus
                                                              as ProductPaymentLoading)
                                                          .id) ==
                                                      int.parse(success
                                                          .productEntity[index]
                                                          .id
                                                          .toString())) ...[
                                                Center(
                                                    child: aiLoadingWidget(
                                                  context,
                                                ))
                                              ] else ...[
                                                const Icon(
                                                  Iconsax.arrow_left_2_outline,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ],
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'پرداخت',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              ' تومان',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              success
                                                  .productEntity[index].price!
                                                  .toString()
                                                  .seRagham(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              success
                                                  .productEntity[index].title!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    wordSpacing: 1.5,
                                                  ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text(
                                                  ' تومان',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    // The text with no line-through decoration
                                                    Text(
                                                      price
                                                          .toString()
                                                          .seRagham(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                    // Rotated line overlay
                                                    Positioned(
                                                      top:
                                                          8, // Adjust vertical position if needed
                                                      child: Transform.rotate(
                                                        angle:
                                                            -0.3, // Adjust angle as desired
                                                        child: Container(
                                                          width: price
                                                                  .toString()
                                                                  .length *
                                                              7.0, // Set width based on text length
                                                          height:
                                                              2.0, // Adjust thickness
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if ((state.status as ProductSuccess)
                                        .productEntity
                                        .length -
                                    1 ==
                                index)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                          ],
                        ),
                      );
                    },
                    itemCount:
                        (state.status as ProductSuccess).productEntity.length,
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
