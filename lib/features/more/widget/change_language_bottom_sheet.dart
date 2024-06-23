// import 'package:flutter/material.dart';
// import '../../../bloc/main_app_bloc.dart';
// import '../../../helpers/shared_helper.dart';
//
// class ChangeLanguageBottomSheet extends StatelessWidget {
//   const ChangeLanguageBottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<String>(
//       stream: mainAppBloc.langStream,
//       builder: (context, snapshot) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomRadioButtonCard(
//               title: "ُEnglish",
//               onTap: () {
//                 mainAppBloc.updateLang('en');
//                 SharedHelper().changeLanguage('en');
//               },
//               isSelect: snapshot.data == "en",
//               // icon: 'saudi-arabia',
//             ),
//             SizedBox(
//               height: 8.h,
//             ),
//             CustomRadioButtonCard(
//               title: "العربية",
//               isSelect: snapshot.data == "ar",
//               onTap: () {
//                 mainAppBloc.updateLang('ar');
//                 SharedHelper().changeLanguage('ar');
//               },
//               // icon: 'united-states-of-america',
//             ),
//             SizedBox(height: 24.h),
//           ],
//         );
//       },
//     );
//   }
// }
