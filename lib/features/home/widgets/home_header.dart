import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_bloc.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/text_styles.dart';
import '../../../helpers/translation/all_translation.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 16.w, right: 16.w, bottom: 16.h),
      child: BlocBuilder<UserBloc, AppState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: allTranslations.text(DateTime.now().format("a") == "AM"
                      ? "morning"
                      : "evening"),
                  style: AppTextStyles.w700
                      .copyWith(fontSize: 22, color: Styles.HEADER),
                  children: [
                    TextSpan(
                      text: " ${UserBloc.instance.user?.name ?? "Test"} 🌞",
                      style: AppTextStyles.w700
                          .copyWith(fontSize: 22, color: Styles.PRIMARY_COLOR),
                    )
                  ],
                ),
              ),
              Text(
                allTranslations.text("are_you_ready_to_deliver_requests_today"),
                style: AppTextStyles.w400
                    .copyWith(fontSize: 14, color: Styles.SUBTITLE),
              )
            ],
          );
        },
      ),
    );
  }
}
