import 'package:flutter/material.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_event.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../../../model/search_engine.dart';
import '../../../../widgets/filter_option.dart';
import '../../bloc/home_purchases_requests_bloc.dart';

class HomePurchaseTabs extends StatelessWidget {
  const HomePurchaseTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePurchasesRequestsBloc, AppState>(
      builder: (context, state) {
        return StreamBuilder<int>(
            stream: HomePurchasesRequestsBloc.instance.selectIndexStream,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Row(
                  children: [
                    ...List.generate(
                      HomePurchasesRequestsBloc.instance.tabs.length,
                      (index) {
                        return Expanded(
                          child: InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (state is! Loading) {
                                HomePurchasesRequestsBloc.instance
                                    .updateSelectIndex(index);
                                HomePurchasesRequestsBloc.instance
                                    .add(Click(arguments: SearchEngine()));
                              }
                            },
                            child: FilterOption(
                              title: allTranslations.text(
                                  HomePurchasesRequestsBloc
                                      .instance.tabs[index]),
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
