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
import '../bloc/edit_profile_bloc.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: allTranslations.text("edit_profile"),
        ),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => EditProfileBloc()..add(Init()),
            child: BlocBuilder<EditProfileBloc, AppState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                      child: ListAnimator(
                        customPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        data: [
                          /// name
                          CustomTextField(
                            controller: context.read<EditProfileBloc>().name,
                            hint: allTranslations.text("name"),
                            type: TextInputType.name,
                            autoValidateMode: AutovalidateMode.disabled,
                            validation: NameValidator.nameValidator,
                            keyboardAction: TextInputAction.next,
                          ),

                          /// email
                          CustomTextField(
                            controller: context.read<EditProfileBloc>().name,
                            hint: allTranslations.text("email"),
                            type: TextInputType.emailAddress,
                            isReadOnly: true,
                            autoValidateMode: AutovalidateMode.disabled,
                            validation: EmailValidator.emailValidator,
                            keyboardAction: TextInputAction.next,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 16.w),
                      child: CustomBtn(
                          loading: state is Loading,
                          text: allTranslations.text("save_changes"),
                          onPressed: () =>
                              context.read<EditProfileBloc>().add(Click())),
                    )
                  ],
                );
              },
            ),
          ),
        ));
  }
}
