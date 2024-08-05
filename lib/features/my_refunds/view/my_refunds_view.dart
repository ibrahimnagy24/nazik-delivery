import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_app_bar.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/utility/extensions.dart';

import '../../../core/app_event.dart';
import '../../../core/app_state.dart';
import '../../../model/search_engine.dart';
import '../../../widgets/tab_widget.dart';
import '../bloc/my_money_refunds_bloc.dart';
import '../bloc/my_order_refunds_bloc.dart';
import '../widgets/money/my_money_refunds_body.dart';
import '../widgets/money/my_money_refunds_tabs.dart';
import '../widgets/order/my_order_refunds_body.dart';
import '../widgets/order/my_order_refunds_tabs.dart';

class MyRefundsView extends StatefulWidget {
  const MyRefundsView({super.key});

  @override
  State<MyRefundsView> createState() => _MyRefundsViewState();
}

class _MyRefundsViewState extends State<MyRefundsView> {
  @override
  void initState() {
    if (MyMoneyRefundsBloc.instance.state is! Done) {
      MyMoneyRefundsBloc.instance.add(Click(arguments: SearchEngine()));
    }
    if (MyOrderRefundsBloc.instance.state is! Done) {
      MyOrderRefundsBloc.instance.add(Click(arguments: SearchEngine()));
    }
    super.initState();
  }

  List<String> tabs = [
    allTranslations.text("order_refund"),
    allTranslations.text("money_refund"),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: allTranslations.text("my_refunds"),
        withBack: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: List.generate(
                    tabs.length,
                    (index) => Expanded(
                          child: TabWidget(
                            data: tabs[index],
                            isSelected: currentIndex == index,
                            onClick: () => setState(() => currentIndex = index),
                            expand: true,
                          ),
                        )),
              ),
            ),
            Expanded(
                child: currentIndex == 0
                    ? const Column(
                        children: [
                          MyOrderRefundsTabs(),
                          MyOrderRefundsBody(),
                        ],
                      )
                    : const Column(
                        children: [
                          MyMoneyRefundsTabs(),
                          MyMoneyRefundsBody(),
                        ],
                      ))
          ],
        ),
      ),
    );
  }
}
