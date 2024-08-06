import 'package:flutter/material.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/features/home/bloc/home_refunds_requests_bloc.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_event.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../../../model/search_engine.dart';
import '../../../../widgets/filter_option.dart';

class HomeRefundsTabs extends StatelessWidget {
  const HomeRefundsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeRefundsRequestsBloc, AppState>(
      builder: (context, state) {
        return StreamBuilder<int>(
            stream: HomeRefundsRequestsBloc.instance.selectIndexStream,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Row(
                  children: [
                    ...List.generate(
                      HomeRefundsRequestsBloc.instance.tabs.length,
                      (index) {
                        return Expanded(
                          child: InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (state is! Loading) {
                                HomeRefundsRequestsBloc.instance
                                    .updateSelectIndex(index);
                                HomeRefundsRequestsBloc.instance
                                    .add(Click(arguments: SearchEngine()));
                              }
                            },
                            child: FilterOption(
                              title: allTranslations.text(
                                  HomeRefundsRequestsBloc.instance.tabs[index]),
                              isSelect: index == snapshot.data,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}
