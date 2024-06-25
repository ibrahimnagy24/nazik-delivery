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
import '../../../model/items_model.dart';
import '../../my_requests/bloc/update_request_status_bloc.dart';
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
          create: (context) => RequestDetailsBloc(),
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
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: "${allTranslations.text("order_id")}: ",
                              style: AppTextStyles.w600
                                  .copyWith(fontSize: 14, color: Styles.HEADER),
                              children: [
                                TextSpan(
                                  text: "#10",
                                  style: AppTextStyles.w400.copyWith(
                                    fontSize: 14,
                                    color: Styles.SUB_HEADER,
                                  ),
                                )
                              ],
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
                      return ListAnimator(
                        data: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: "${allTranslations.text("order_id")}: ",
                              style: AppTextStyles.w600
                                  .copyWith(fontSize: 14, color: Styles.HEADER),
                              children: [
                                TextSpan(
                                  text: "#10",
                                  style: AppTextStyles.w400.copyWith(
                                    fontSize: 14,
                                    color: Styles.SUB_HEADER,
                                  ),
                                )
                              ],
                            ),
                          ),

                          ///Address
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: "${allTranslations.text("address")}: ",
                                style: AppTextStyles.w600.copyWith(
                                    fontSize: 14, color: Styles.HEADER),
                                children: [
                                  TextSpan(
                                    text: "Egypt",
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
                          RequestItems(
                            items: [
                              ItemModel(
                                  id: 1,
                                  color: "red",
                                  name: "T-shirt",
                                  price: "240",
                                  link: "www.zara.com",
                                  quantity: "3",
                                  size: "L"),
                              ItemModel(
                                  id: 2,
                                  color: "red",
                                  name: "T-shirt",
                                  price: "240",
                                  link: "www.zara.com",
                                  quantity: "3",
                                  size: "L"),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: BlocProvider(
                    create: (context) => UpdateRequestStatusBloc(),
                    child: BlocBuilder<UpdateRequestStatusBloc, AppState>(
                      builder: (context, state) {
                        return CustomBtn(
                          text: allTranslations.text("deliver"),
                          onPressed: () => context
                              .read<UpdateRequestStatusBloc>()
                              .add(Click(arguments: {"id": id, "status": 1})),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
