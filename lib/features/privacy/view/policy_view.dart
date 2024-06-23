import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_container.dart';
import '../../../core/app_event.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../bloc/policy_bloc.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: allTranslations.text("privacy_policy"),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => PrivacyPolicyBloc()..add(Click()),
          child: BlocBuilder<PrivacyPolicyBloc, AppState>(
            builder: (context, state) {
              if (state is Done) {
                String res = state.data as String;
                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                        child: ListAnimator(data: [
                          SizedBox(
                            height: 24.0.h,
                          ),
                          HtmlWidget(res),
                          SizedBox(
                            height: 24.0.h,
                          ),
                        ]),
                      ),
                    ),
                  ],
                );
              } else if (state is Empty || state is Error) {
                return Column(
                  children: [
                    Expanded(
                      child: ListAnimator(
                        data: [
                          SizedBox(
                            height: 50.h,
                          ),
                          EmptyContainer(
                            txt: state is Error
                                ? allTranslations.text("something_went_wrong")
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Column(
                  children: [
                    Expanded(
                        child: Center(
                            child: CircularProgressIndicator(
                      color: Styles.PRIMARY_COLOR,
                    ))),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
