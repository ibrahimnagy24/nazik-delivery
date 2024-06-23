import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_btn.dart';
import '../../../components/custom_text_field.dart';
import '../../../core/app_event.dart';
import '../../../core/app_state.dart';
import '../../../core/validator.dart';
import '../../../helpers/translation/all_translation.dart';
import '../bloc/change_password_bloc.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: allTranslations.text("change_password"),
        ),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => ChangePasswordBloc(),
            child: BlocBuilder<ChangePasswordBloc, AppState>(
              builder: (context, state) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListAnimator(
                          data: [
                            Form(
                              key: context.read<ChangePasswordBloc>().globalKey,
                              child: Column(
                                children: [
                                  /// password
                                  CustomTextField(
                                    controller: context
                                        .read<ChangePasswordBloc>()
                                        .oldPassword,
                                    label: allTranslations
                                        .text("current_password"),
                                    hint: allTranslations
                                        .text("enter_current_password"),
                                    verticalPadding: 8.h,
                                    isPassword: true,
                                    validation:
                                        PasswordValidator.passwordValidator,
                                  ),

                                  /// new password
                                  CustomTextField(
                                    controller: context
                                        .read<ChangePasswordBloc>()
                                        .newPassword,
                                    label: allTranslations.text("new_password"),
                                    hint: allTranslations
                                        .text("enter_new_password"),
                                    verticalPadding: 8.h,
                                    isPassword: true,
                                    validation: (v) =>
                                        NewPasswordValidator.passwordValidator(
                                            context
                                                .read<ChangePasswordBloc>()
                                                .oldPassword
                                                .text
                                                .trim(),
                                            v),
                                  ),

                                  /// confirm password
                                  CustomTextField(
                                    controller: context
                                        .read<ChangePasswordBloc>()
                                        .confirmNewPassword,
                                    label: allTranslations
                                        .text("confirm_new_password"),
                                    hint: allTranslations
                                        .text("enter_confirm_new_password"),
                                    verticalPadding: 8.h,
                                    isPassword: true,
                                    validation: (v) =>
                                        PasswordConfirmationValidator
                                            .passwordValidator(
                                                context
                                                    .read<ChangePasswordBloc>()
                                                    .newPassword
                                                    .text
                                                    .trim(),
                                                v),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomBtn(
                          loading: state is Loading,
                          text: allTranslations.text("save_changes"),
                          onPressed: () =>
                              context.read<ChangePasswordBloc>().add(Click()))
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
