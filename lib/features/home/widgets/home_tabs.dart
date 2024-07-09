import 'package:flutter/material.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_base/widgets/tab_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_event.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../model/search_engine.dart';
import '../bloc/home_requests_bloc.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeRequestsBloc, AppState>(
      builder: (context, state) {
        return StreamBuilder<int>(
            stream: HomeRequestsBloc.instance.selectIndexStream,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  children: List.generate(
                      2,
                      (index) => Expanded(
                            child: TabWidget(
                              data: allTranslations
                                  .text(HomeRequestsBloc.instance.tabs[index]),
                              isSelected: (snapshot.data ?? 0) == index,
                              onClick: () {
                                if (state is! Loading) {
                                  HomeRequestsBloc.instance
                                      .updateSelectIndex(index);
                                  HomeRequestsBloc.instance
                                      .add(Click(arguments: SearchEngine()));
                                }
                              },
                              expand: true,
                            ),
                          )),
                ),
              );
            });
      },
    );
  }
}
