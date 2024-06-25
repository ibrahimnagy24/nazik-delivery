import 'package:flutter/material.dart';
import 'package:flutter_base/components/animated_widget.dart';
import 'package:flutter_base/components/empty_container.dart';
import 'package:flutter_base/components/shimmer/custom_shimmer.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/model/items_model.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/custom_loading_text.dart';
import '../../../core/app_event.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../model/search_engine.dart';
import '../bloc/home_requests_bloc.dart';
import '../../../widgets/request_card.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    HomeRequestsBloc.instance.customScroll(controller);

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
      child: BlocBuilder<HomeRequestsBloc, AppState>(
        builder: (context, state) {
          if (state is Loading) {
            return ListAnimator(
              customPadding: EdgeInsets.symmetric(horizontal: 16.w),
              data: List.generate(
                  10,
                  (index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: CustomShimmerContainer(
                          height: 120.h,
                          width: context.w,
                        ),
                      )),
            );
          }
          if (state is Done) {
            return RefreshIndicator(
              color: Styles.PRIMARY_COLOR,
              onRefresh: () async {
                HomeRequestsBloc.instance.add(Click(arguments: SearchEngine()));
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
                HomeRequestsBloc.instance.add(Click(arguments: SearchEngine()));
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListAnimator(
                      customPadding: EdgeInsets.symmetric(horizontal: 16.w),
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
              ),
            );
          }
          return RefreshIndicator(
            color: Styles.PRIMARY_COLOR,
            onRefresh: () async {
              HomeRequestsBloc.instance.add(Click(arguments: SearchEngine()));
            },
            child: Column(
              children: [
                Expanded(
                  child: ListAnimator(
                    data: List.generate(
                      4,
                      (index) => RequestCard(
                        model: RequestModel(
                          id: index,
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
