import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/animated_widget.dart';
import '../../../../components/custom_btn.dart';
import '../../../../core/app_event.dart';
import '../../../../core/app_state.dart';
import '../../../../helpers/styles.dart';
import '../../../../helpers/text_styles.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../bloc/otp_bloc.dart';
import '../bloc/resend_code_bloc.dart';
import '../widgets/count_down.dart';
import '../widgets/pin_code.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => OtpBloc(),
          child: BlocBuilder<OtpBloc, AppState>(
            builder: (context, state) {
              return Form(
                key: context.read<OtpBloc>().globalKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ListAnimator(
                        customPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        data: [
                          SizedBox(height: 32.h),
                          Center(child: Styles.logo(width: 150, height: 150)),
                          SizedBox(height: 32.h),
                          Text(
                            allTranslations.text("verify_your_account"),
                            style: AppTextStyles.w700.copyWith(
                              color: Styles.HEADER,
                              fontSize: 28,
                            ),
                          ),
                          Text(
                            allTranslations
                                .text("verify_your_account_description"),
                            style: AppTextStyles.w400.copyWith(
                              color: Styles.DETAILS,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          const PinCodeWidget(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: CountDown(
                              onCount: () => context
                                  .read<ResendCodeBloc>()
                                  .add(Click(arguments: email)),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          CustomBtn(
                            text: allTranslations.text("submit"),
                            loading: state is Loading,
                            onPressed: () {
                              if (context
                                  .read<OtpBloc>()
                                  .globalKey
                                  .currentState!
                                  .validate()) {
                                context
                                    .read<OtpBloc>()
                                    .add(Click(arguments: email));
                              }
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomBtn(
                            text: allTranslations.text("go_to_login"),
                            loading: state is Loading,
                            borderColor: Styles.BORDER_COLOR,
                            color: Styles.WHITE_COLOR,
                            textColor: Styles.PRIMARY_COLOR,
                            onPressed: () {
                              CustomNavigator.push(Routes.LOGIN, clean: true);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
