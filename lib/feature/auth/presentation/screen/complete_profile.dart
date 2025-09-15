// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_i18n/flutter_i18n.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:med_ai/core/widgets/show_toast.dart';
// import 'package:med_ai/core/widgets/submit_button.dart';
// import 'package:med_ai/features/auth/presentation/bloc/local_status.dart';
// import 'package:med_ai/features/auth/presentation/widgets/age_widget.dart';
// import 'package:med_ai/features/auth/presentation/widgets/height_widget.dart';
// import 'package:med_ai/features/auth/presentation/widgets/weight_widget.dart';
// import 'package:toastification/toastification.dart';

// import '../../../../core/locator/locator.dart';
// import '../../../../core/widgets/app_bar.dart';
// import '../../data/model/user.dart';
// import '../bloc/auth_bloc.dart';
// import '../bloc/auth_event.dart';
// import '../bloc/auth_state.dart';
// import '../widgets/gender_widget.dart';

// class CompleteProfile extends StatefulWidget {
//   const CompleteProfile({super.key});

//   @override
//   State<CompleteProfile> createState() => _CompleteProfileState();
// }

// class _CompleteProfileState extends State<CompleteProfile> {
//   late final ValueNotifier<int> _currentPage;
//   late final PageController _pageController;
//   int? selectedGender;
//   int? selectedAge;
//   int? selectedHeight;
//   int? selectedWeight;
//   bool _isPageValid(int currentPage) {
//     switch (currentPage) {
//       case 0:
//         return selectedGender != null;
//       case 1:
//         return selectedAge != null;
//       case 2:
//         return selectedHeight != null;
//       case 3:
//         return selectedWeight != null;
//       default:
//         return true; // Assume valid for pages without specific requirements
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _currentPage = ValueNotifier<int>(0);
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _currentPage.dispose();
//     _pageController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => locator<AuthBloc>(),
//       child: BlocConsumer<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state.localStatus is LocalSuccess) {
//             Navigator.of(context).pushReplacementNamed('/home');
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             appBar: appBar(
              
//             ),
//             body: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
                    
//                     BackPageViewWidget(
//                       pageController: _pageController,
//                     ),
//                     const Expanded(
//                       flex: 4,
//                       child: ProgressPageView(),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: PageView(
//                       onPageChanged: (value) {
//                         _currentPage.value = value;
//                       },
//                       physics: const NeverScrollableScrollPhysics(),
//                       controller: _pageController,
//                       children: [
//                         GenderWidget(
//                           selectedGender: selectedGender,
//                           onGenderSelected: (p0) {
//                             setState(() {
//                               selectedGender = p0;
//                             });
//                           },
//                         ),
//                         AgeWidget(
//                           selectedAge: selectedAge,
//                           (value) {
//                             setState(() {
//                               selectedAge = value;
//                             });
//                           },
//                         ),
//                         HeightWidget(
//                           selectedHeight: selectedHeight,
//                           (value) {
//                             setState(() {
//                               selectedHeight = value;
//                             });
//                           },
//                         ),
//                         WeightWidget(selectedWeight: selectedWeight, (value) {
//                           setState(() {
//                             selectedWeight = value;
//                           });
//                         }),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//                   child: ValueListenableBuilder<int>(
//                     valueListenable: _currentPage,
//                     builder: (context, currentPage, child) {
//                       return Row(
//                         children: [
//                           Expanded(
//                             child: SubmitButton(
//                               text: FlutterI18n.translate(context, 'continue'),
//                               onClick: () {
//                                 if (_isPageValid(_currentPage.value)) {
//                                   _pageController.nextPage(
//                                     duration: const Duration(milliseconds: 300),
//                                     curve: Curves.easeIn,
//                                   );
//                                   if (_currentPage.value == 3) {
//                                     BlocProvider.of<AuthBloc>(context)
//                                         .add(SaveUserEvent(User(
//                                       gender: selectedGender!,
//                                       age: selectedAge!,
//                                       height: selectedHeight!.toDouble(),
//                                       weight: selectedWeight!.toDouble(),
//                                     )));
//                                   }
//                                 } else {
//                                   showToast(
//                                       context,
//                                      FlutterI18n.translate(context, 'fill_all_fields'),
//                                       '',
//                                       ToastificationType.info,
//                                       isIconMessage: true);
//                                 }
//                               },
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class BackPageViewWidget extends StatelessWidget {
//   final PageController pageController;
//   const BackPageViewWidget({
//     super.key,
//     required this.pageController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8),
//       child: ValueListenableBuilder(
//         valueListenable: context
//             .findAncestorStateOfType<_CompleteProfileState>()!
//             ._currentPage,
//         builder: (context, currentPage, child) {
//           return TextButton(
//             style: const ButtonStyle(
//                 padding: WidgetStatePropertyAll(
//               EdgeInsets.all(2),
//             )),
//             onPressed: () {
//               if (currentPage > 0) {
//                 if (pageController.page! > 0) {
//                   pageController.previousPage(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeIn,
//                   );
//                 }
//               } else {
//                 null;
//               }
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   MingCute.left_line,
//                   color: currentPage > 0
//                       ? Theme.of(context).colorScheme.primary
//                       : Colors.grey,
//                 ),
//                 Text(
//                   FlutterI18n.translate(context, 'back'),
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         color: currentPage > 0
//                             ? Theme.of(context).colorScheme.primary
//                             : Colors.grey)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class ProgressPageView extends StatelessWidget {
//   const ProgressPageView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 20),
//       child: Stack(
//         children: [
//           Container(
//             height: 12,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.surfaceContainer,
//                 borderRadius: BorderRadius.circular(10)),
//           ),
//           SizedBox(
//             height: 12,
//             child: ValueListenableBuilder(
//               valueListenable: context
//                   .findAncestorStateOfType<_CompleteProfileState>()!
//                   ._currentPage,
//               builder: (context, value, child) {
//                 print(value);
//                 return Padding(
//                   padding: const EdgeInsets.all(2.0),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 600),
//                     curve: Curves.easeInOutCubicEmphasized,
//                     height: 20,
//                     width: value * (MediaQuery.of(context).size.width / 5),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Theme.of(context).colorScheme.primaryFixedDim,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
