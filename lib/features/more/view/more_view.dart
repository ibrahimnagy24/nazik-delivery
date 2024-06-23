import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/components/custom_app_bar.dart';
import '../../../components/animated_widget.dart';
import '../../../core/app_event.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../bloc/logout_bloc.dart';
import '../widget/more_button.dart';
import '../widget/profile_widget.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: allTranslations.text("profile"),
        withBack: false,
      ),
      body: SafeArea(child: Column(
        children: [
          Expanded(
            child: ListAnimator(
              data: [
                const ProfileWidget(),
                MoreButton(
                  title: allTranslations.text("edit_profile"),
                  icon: 'edit',
                  onTap: () => CustomNavigator.push(Routes.EDIT_PROFILE),
                ),    MoreButton(
                  title: allTranslations.text("change_password"),
                  icon: 'lock',
                  onTap: () => CustomNavigator.push(Routes.CHANGE_PASSWORD),
                ),
                MoreButton(
                  title: allTranslations.text("language"),
                  icon: 'global',
                  // onTap: () => CustomNavigator.push(Routes.LANGUAGE),
                ),
                MoreButton(
                  title: allTranslations.text("privacy_policy"),
                  icon: 'shield-tick',
                  onTap: () => CustomNavigator.push(Routes.PRIVACY),
                ),
                MoreButton(
                  title: allTranslations.text("terms_conditions"),
                  icon: 'document-text',
                  onTap: () => CustomNavigator.push(Routes.TERMS),
                ),
                BlocProvider(
                  create: (context) => LogoutBloc(),
                  child: BlocBuilder<LogoutBloc, AppState>(
                    builder: (context, state) {
                      return MoreButton(
                        isLogout: true,
                        isLoading: state is Loading,
                        title: allTranslations.text("logout"),
                        icon: 'logout',
                        onTap: () {
                          context.read<LogoutBloc>().add(Click());
                        },
                        color: Styles.DARK_RED,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),),
    );
  }
}
