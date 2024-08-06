import 'package:flutter/material.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../widgets/tab_widget.dart';
import '../widgets/purchase/home_purchase_body.dart';
import '../widgets/home_header.dart';
import '../widgets/purchase/home_purchase_tabs.dart';
import '../widgets/refunds/home_refunds_body.dart';
import '../widgets/refunds/home_refunds_tabs.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> titles = [
    allTranslations.text("deliver_purchases"),
    allTranslations.text('deliver_refunds')
  ];

  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),

          ///Tabs
          Row(
            children: List.generate(
                2,
                (index) => Expanded(
                      child: TabWidget(
                        data: titles[index],
                        isSelected: currentIndex == index,
                        onClick: () {
                          setState(() => currentIndex = index);
                        },
                        expand: true,
                      ),
                    )),
          ),
          // if (currentIndex == 1) SizedBox(height: 16.h),

          ///Body
          Expanded(
              child: (currentIndex == 0)
                  ? const Column(
                      children: [
                        HomePurchaseTabs(),
                        HomePurchaseBody(),
                      ],
                    )
                  : const Column(
                      children: [
                        HomeRefundsTabs(),
                        HomeRefundsBody(),
                      ],
                    )),
        ],
      ),
    );
  }
}
