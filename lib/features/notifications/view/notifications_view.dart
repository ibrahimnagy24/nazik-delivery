import 'package:flutter/material.dart';
import 'package:flutter_base/components/animated_widget.dart';
import 'package:flutter_base/components/custom_app_bar.dart';
import 'package:flutter_base/components/empty_container.dart';
import 'package:flutter_base/components/shimmer/custom_shimmer.dart';
import 'package:flutter_base/features/notifications/model/notifications_model.dart';
import 'package:flutter_base/features/notifications/widgets/notifications_card.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/custom_loading_text.dart';
import '../../../core/app_event.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../model/search_engine.dart';
import '../bloc/notifications_bloc.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    NotificationsBloc.instance.customScroll(controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: allTranslations.text("notifications"),
        withBack: false,

      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<NotificationsBloc, AppState>(
              builder: (context, state) {
                if (state is Loading) {
                  return ListAnimator(
                    data: List.generate(
                        8,
                        (index) => Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Styles.LIGHT_GREY_BORDER,
                              ))),
                              child: CustomShimmerContainer(
                                height: 80.h,
                                width: context.w,
                                radius: 0,
                              ),
                            )),
                  );
                }
                if (state is Done) {
                  return RefreshIndicator(
                    color: Styles.PRIMARY_COLOR,
                    onRefresh: () async {
                      NotificationsBloc.instance
                          .add(Click(arguments: SearchEngine()));
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: ListAnimator(
                              controller: controller, data: state.cards),
                        ),
                        CustomLoadingText(
                          loading: state.loading,
                        ),
                      ],
                    ),
                  );
                }
                if (state is Empty || State is Error) {
                  return RefreshIndicator(
                    color: Styles.PRIMARY_COLOR,
                    onRefresh: () async {
                      NotificationsBloc.instance
                          .add(Click(arguments: SearchEngine()));
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: ListAnimator(
                            customPadding:
                                EdgeInsets.symmetric(horizontal: 16.w),
                            data: [
                              SizedBox(
                                height: 50.h,
                              ),
                              EmptyContainer(
                                txt: state is Error
                                    ? allTranslations
                                        .text("something_went_wrong")
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  color: Styles.PRIMARY_COLOR,
                  onRefresh: () async {
                    NotificationsBloc.instance
                        .add(Click(arguments: SearchEngine()));
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: ListAnimator(
                          data: List.generate(
                            4,
                            (index) => NotificationCard(
                              notification: NotificationModel(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
