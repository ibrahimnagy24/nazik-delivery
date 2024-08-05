import 'package:flutter/material.dart';
import 'package:flutter_base/components/animated_widget.dart';
import 'package:flutter_base/components/empty_container.dart';
import 'package:flutter_base/components/shimmer/custom_shimmer.dart';
import 'package:flutter_base/features/my_refunds/bloc/my_order_refunds_bloc.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/custom_loading_text.dart';
import '../../../../core/app_event.dart';
import '../../../../core/app_state.dart';
import '../../../../helpers/styles.dart';
import '../../../../model/search_engine.dart';

class MyOrderRefundsBody extends StatefulWidget {
  const MyOrderRefundsBody({super.key});

  @override
  State<MyOrderRefundsBody> createState() => _MyOrderRefundsBodyState();
}

class _MyOrderRefundsBodyState extends State<MyOrderRefundsBody> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    MyOrderRefundsBloc.instance.customScroll(controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MyOrderRefundsBloc, AppState>(
        builder: (context, state) {
          if (state is Loading) {
            return ListAnimator(
              customPadding: EdgeInsets.symmetric(horizontal: 16.w),
              data: List.generate(
                  10,
                  (index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: CustomShimmerContainer(
                          height: 100.h,
                          width: context.w,
                        ),
                      )),
            );
          }
          if (state is Done) {
            return RefreshIndicator(
              color: Styles.PRIMARY_COLOR,
              onRefresh: () async {
                MyOrderRefundsBloc.instance.add(Click(arguments: SearchEngine()));
              },
              child: Column(
                children: [
                  Expanded(
                    child:
                        ListAnimator(controller: controller, data: state.cards),
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
                MyOrderRefundsBloc.instance.add(Click(arguments: SearchEngine()));
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListAnimator(
                      customPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      data: [
                        SizedBox(height: 80.h),
                        EmptyContainer(
                          txt: state is Error
                              ? allTranslations.text("something_went_wrong")
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
