import 'package:flutter/material.dart';
import 'package:flutter_base/features/my_refunds/bloc/my_order_refunds_bloc.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_event.dart';
import '../../../../core/app_state.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../../../model/search_engine.dart';
import '../../../../widgets/filter_option.dart';
import '../../model/refunds_model.dart';

class MyOrderRefundsTabs extends StatefulWidget {
  const MyOrderRefundsTabs({super.key});

  @override
  State<MyOrderRefundsTabs> createState() => _MyOrderRefundsTabsState();
}

class _MyOrderRefundsTabsState extends State<MyOrderRefundsTabs> {
  final List<GlobalKey> _globalKeys = [];

  static animatedRowScroll(BuildContext context) {
    Scrollable.ensureVisible(context,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        alignment: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOrderRefundsBloc, AppState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: StreamBuilder<RefundStatus>(
              stream: MyOrderRefundsBloc.instance.selectStatusStream,
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 12.h),
                      ...List.generate(
                        MyOrderRefundsBloc.instance.orderStatus.length,
                        (index) {
                          _globalKeys.add(GlobalKey(debugLabel: "$index"));
                          Future.delayed(const Duration(seconds: 1), () {
                            animatedRowScroll(
                                _globalKeys[snapshot.data?.index ?? 0]
                                        .currentContext ??
                                    context);
                          });
                          return (index == 0)
                              ? const SizedBox()
                              : InkWell(
                                  key: _globalKeys[index],
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    if (state is! Loading) {
                                      animatedRowScroll(
                                          _globalKeys[index].currentContext!);
                                      MyOrderRefundsBloc.instance
                                          .updateSelectStatus(MyOrderRefundsBloc
                                              .instance.orderStatus[index]);
                                      MyOrderRefundsBloc.instance.add(
                                          Click(arguments: SearchEngine()));
                                    }
                                  },
                                  child: FilterOption(
                                    title: allTranslations.text(
                                        MyOrderRefundsBloc
                                            .instance.orderStatus[index].name),
                                    isSelect: MyOrderRefundsBloc
                                            .instance.orderStatus[index] ==
                                        snapshot.data,
                                  ),
                                );
                        },
                      )
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
