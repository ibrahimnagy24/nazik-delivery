import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/animated_widget.dart';
import '../../../../components/custom_btn.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../core/app_event.dart';
import '../../../../core/app_state.dart';
import '../../../../core/validator.dart';
import '../../../../helpers/styles.dart';
import '../../../../helpers/text_styles.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../bloc/reset_password_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ResetPasswordBloc(),
          child: BlocBuilder<ResetPasswordBloc, AppState>(
            builder: (context, state) {
              return Form(
                key: context.read<ResetPasswordBloc>().globalKey,
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
                            allTranslations.text("create_your_new_password"),
                            style: AppTextStyles.w700.copyWith(
                              color: Styles.HEADER,
                              fontSize: 28,
                            ),
                          ),
                          Text(
                            allTranslations
                                .text("create_your_new_password_description"),
                            style: AppTextStyles.w400.copyWith(
                              color: Styles.DETAILS,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          CustomTextField(
                            hint: allTranslations.text("enter_password"),
                            label: allTranslations.text("new_password"),
                            type: TextInputType.visiblePassword,
                            isPassword: true,
                            controller:
                                context.read<ResetPasswordBloc>().passwordTEC,
                            validation: PasswordValidator.passwordValidator,
                          ),
                          CustomTextField(
                            hint: allTranslations.text("enter_password"),
                            label: allTranslations.text("confirm_password"),
                            type: TextInputType.visiblePassword,
                            isPassword: true,
                            controller: context
                                .read<ResetPasswordBloc>()
                                .confirmPasswordTEC,
                            validation: (v) =>
                                PasswordConfirmationValidator.passwordValidator(
                                    context
                                        .read<ResetPasswordBloc>()
                                        .passwordTEC
                                        .text
                                        .trim(),
                                    v),
                          ),
                          SizedBox(height: 24.h),
                          CustomBtn(
                            text: allTranslations.text("submit"),
                            loading: state is Loading,
                            onPressed: () {
                              if (context
                                  .read<ResetPasswordBloc>()
                                  .globalKey
                                  .currentState!
                                  .validate()) {
                                context
                                    .read<ResetPasswordBloc>()
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
