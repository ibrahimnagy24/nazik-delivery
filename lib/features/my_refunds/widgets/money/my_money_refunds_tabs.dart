import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_event.dart';
import '../../../../core/app_state.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../../../model/search_engine.dart';
import '../../../../widgets/filter_option.dart';
import '../../bloc/my_money_refunds_bloc.dart';
import '../../model/refunds_model.dart';

class MyMoneyRefundsTabs extends StatefulWidget {
  const MyMoneyRefundsTabs({super.key});

  @override
  State<MyMoneyRefundsTabs> createState() => _MyMoneyRefundsTabsState();
}

class _MyMoneyRefundsTabsState extends State<MyMoneyRefundsTabs> {
  final List<GlobalKey> _globalKeys = [];

  static animatedRowScroll(BuildContext context) {
    Scrollable.ensureVisible(context,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        alignment: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyMoneyRefundsBloc, AppState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: StreamBuilder<RefundStatus>(
              stream: MyMoneyRefundsBloc.instance.selectStatusStream,
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 12.h),
                      ...List.generate(
                        MyMoneyRefundsBloc.instance.moneyStatus.length,
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
                                      MyMoneyRefundsBloc.instance
                                          .updateSelectStatus(MyMoneyRefundsBloc
                                              .instance.moneyStatus[index]);
                                      MyMoneyRefundsBloc.instance.add(
                                          Click(arguments: SearchEngine()));
                                    }
                                  },
                                  child: FilterOption(
                                    title: allTranslations.text(
                                        MyMoneyRefundsBloc
                                            .instance.moneyStatus[index].name),
                                    isSelect: MyMoneyRefundsBloc
                                            .instance.moneyStatus[index] ==
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
