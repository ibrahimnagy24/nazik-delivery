import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/animated_widget.dart';
import '../../../../components/custom_btn.dart';
import '../../../../components/custom_images.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../core/app_event.dart';
import '../../../../core/app_state.dart';
import '../../../../core/validator.dart';
import '../../../../helpers/styles.dart';
import '../../../../helpers/text_styles.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../../../navigation/custom_navigation.dart';
import '../bloc/forget_password_bloc.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ForgetPasswordBloc(),
          child: BlocBuilder<ForgetPasswordBloc, AppState>(
            builder: (context, state) {
              return Form(
                key: context.read<ForgetPasswordBloc>().globalKey,
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
                            allTranslations.text("forget_password"),
                            style: AppTextStyles.w700.copyWith(
                              color: Styles.HEADER,
                              fontSize: 28,
                            ),
                          ),
                          Text(
                            allTranslations.text("forget_password_description"),
                            style: AppTextStyles.w400.copyWith(
                              color: Styles.DETAILS,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          CustomTextField(
                            hint: allTranslations.text("enter_email"),
                            label: allTranslations.text("email"),
                            type: TextInputType.emailAddress,
                            controller:
                                context.read<ForgetPasswordBloc>().mailTEC,
                            validation: EmailValidator.emailValidator,
                          ),
                          SizedBox(height: 24.h),
                          CustomBtn(
                            text: allTranslations.text("submit"),
                            loading: state is Loading,
                            onPressed: () {
                              if (context
                                  .read<ForgetPasswordBloc>()
                                  .globalKey
                                  .currentState!
                                  .validate()) {
                                context.read<ForgetPasswordBloc>().add(Click());
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
                              CustomNavigator.pop();
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
