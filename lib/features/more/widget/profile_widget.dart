import 'package:flutter/material.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_bloc.dart';
import '../../../core/app_state.dart';
import '../../../helpers/media_query_helper.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/text_styles.dart';
import 'profile_image.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, AppState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 24.h),
          child: Container(
            height: 240.h,
            width: MediaQueryHelper.width,
            decoration: const BoxDecoration(color: Styles.FILL_COLOR),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ProfileImage(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    UserBloc.instance.user?.name ?? "name",
                    style: AppTextStyles.w600.copyWith(
                      fontSize: 16,
                      color: Styles.HEADER,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wallet,
                        color: Styles.PRIMARY_COLOR, size: 24),
                    SizedBox(width: 12.w),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "${allTranslations.text("balance")}  ",
                        style: AppTextStyles.w400.copyWith(
                          fontSize: 14,
                          color: Styles.HEADER,
                        ),
                        children: [
                          TextSpan(
                            text: UserBloc.instance.user?.balance ?? "100",
                            style: AppTextStyles.w600.copyWith(
                              fontSize: 18,
                              color: Styles.PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
