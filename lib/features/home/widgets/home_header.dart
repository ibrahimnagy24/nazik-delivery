import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_bloc.dart';
import '../../../components/custom_images.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/text_styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 16.w, right: 16.w, bottom: 16.h),
      child: BlocBuilder<UserBloc, AppState>(
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: allTranslations.text(
                            DateTime.now().format("a", cutomlocale: "en") ==
                                    "AM"
                                ? "morning"
                                : "evening"),
                        style: AppTextStyles.w700
                            .copyWith(fontSize: 22, color: Styles.HEADER),
                        children: [
                          TextSpan(
                            text:
                                " ${UserBloc.instance.user?.name?.split(" ").first ?? "Test"} 🌞",
                            style: AppTextStyles.w700.copyWith(
                                fontSize: 22, color: Styles.PRIMARY_COLOR),
                          )
                        ],
                      ),
                    ),
                    Text(
                      allTranslations
                          .text("are_you_ready_to_deliver_requests_today"),
                      style: AppTextStyles.w400
                          .copyWith(fontSize: 14, color: Styles.SUBTITLE),
                    )
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              customImageIconSVG(
                  imageName: "notification",
                  width: 24,
                  height: 24,
                  color: Styles.PRIMARY_COLOR,
                  onTap: () => CustomNavigator.push(Routes.NOTIFICATION))
            ],
          );
        },
      ),
    );
  }
}
