import 'package:flutter/material.dart';
import 'package:flutter_base/components/animated_widget.dart';
import 'package:flutter_base/components/custom_app_bar.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/custom_btn.dart';
import '../../../components/empty_container.dart';
import '../../../core/app_event.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/text_styles.dart';
import '../../../model/requests_model.dart';
import '../bloc/assign_request_bloc.dart';
import '../bloc/request_details_bloc.dart';
import '../widgets/request_items.dart';

class RequestDetailsView extends StatelessWidget {
  const RequestDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: allTranslations.text("request_details"),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => RequestDetailsBloc()..add(Click(arguments: id)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 12.h),
                Expanded(child: BlocBuilder<RequestDetailsBloc, AppState>(
                  builder: (context, state) {
                    if (state is Done) {
                      RequestModel model = state.model as RequestModel;
                      return ListAnimator(
                        data: [
                          Text(
                            "#${model.orderNumber}",
                            style: AppTextStyles.w600.copyWith(
                              fontSize: 14,
                              color: Styles.HEADER,
                            ),
                          ),

                          ///Address
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: "${allTranslations.text("address")}: ",
                                style: AppTextStyles.w600.copyWith(
                                    fontSize: 14, color: Styles.HEADER),
                                children: [
                                  TextSpan(
                                    text: "www.zara.com",
                                    style: AppTextStyles.w400.copyWith(
                                      fontSize: 14,
                                      color: Styles.SUB_HEADER,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          ///Items
                          RequestItems(items: model.items ?? []),
                        ],
                      );
                    }
                    if (state is Loading) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Styles.PRIMARY_COLOR,
                      ));
                    }
                    if (state is Empty || State is Error) {
                      return RefreshIndicator(
                        color: Styles.PRIMARY_COLOR,
                        onRefresh: () async {
                          context
                              .read<RequestDetailsBloc>()
                              .add(Click(arguments: id));
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: ListAnimator(
                                data: [
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
                    } else {
                      return const SizedBox();
                    }
                  },
                )),
                BlocBuilder<RequestDetailsBloc, AppState>(
                  builder: (context, state) {
                    if (state is Done) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: BlocProvider(
                          create: (context) => AssignRequestBloc(),
                          child: BlocBuilder<AssignRequestBloc, AppState>(
                            builder: (context, state) {
                              return CustomBtn(
                                text: allTranslations.text("assign_request"),
                                loading: state is Loading,
                                onPressed: () => context
                                    .read<AssignRequestBloc>()
                                    .add(Click(arguments: id)),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
