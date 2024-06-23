import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/animated_widget.dart';
import '../../../../components/custom_btn.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../core/app_state.dart';
import '../../../../core/validator.dart';
import '../../../../helpers/styles.dart';
import '../../../../helpers/text_styles.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../bloc/login_bloc.dart';
import '../widgets/welcome_widget.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginBloc(),
          child: BlocBuilder<LoginBloc, AppState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: context.read<LoginBloc>().globalKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListAnimator(
                          data: [
                            SizedBox(height: 32.h),
                            const WelcomeWidget(),
                            SizedBox(height: 32.h),
                            CustomTextField(
                              hint: allTranslations.text("enter_email"),
                              label: allTranslations.text("email"),
                              type: TextInputType.emailAddress,
                              controller: context.read<LoginBloc>().mailTEC,
                              validation: EmailValidator.emailValidator,
                            ),
                            CustomTextField(
                              hint: allTranslations.text("enter_password"),
                              label: allTranslations.text("password"),
                              type: TextInputType.visiblePassword,
                              isPassword: true,
                              controller: context.read<LoginBloc>().passwordTEC,
                              validation: PasswordValidator.passwordValidator,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(child: SizedBox()),
                                GestureDetector(
                                  onTap: () {
                                    CustomNavigator.push(
                                        Routes.FORGET_PASSWORD);
                                  },
                                  child: Text(
                                    allTranslations.text("forget_password"),
                                    style: AppTextStyles.w400.copyWith(
                                      fontSize: 14,
                                      color: Styles.HEADER,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      CustomBtn(
                        text: allTranslations.text("login"),
                        loading: state is Loading,
                        onPressed: () {
                          if (context
                              .read<LoginBloc>()
                              .globalKey
                              .currentState!
                              .validate()) {
                            // context.read<LoginBloc>().add(Click());
                            CustomNavigator.push(Routes.MAIN_PAGE, clean: true);
                          }
                        },
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
