import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';

import '../../../../helpers/styles.dart';
import '../../../../helpers/text_styles.dart';
import '../../../../helpers/translation/all_translation.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Center(child: Styles.logo(width: 150, height: 150)),
      SizedBox(height: 32.h),
      Text(
        allTranslations.text("welcome_back"),
        style: AppTextStyles.w600
            .copyWith(color: Styles.HEADER, fontSize: 24, height: 1),
      ),
      Text(
        allTranslations.text("login_to_your_account"),
        style: AppTextStyles.w400
            .copyWith(color: Styles.DETAILS, fontSize: 14, height: 1),
      ),
    ]);
  }
}
