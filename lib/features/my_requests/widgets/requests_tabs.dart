import 'package:flutter/material.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_event.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../model/requests_model.dart';
import '../../../model/search_engine.dart';
import '../../../widgets/filter_option.dart';
import '../bloc/my_requests_bloc.dart';

class RequestsTabs extends StatefulWidget {
  const RequestsTabs({super.key});

  @override
  State<RequestsTabs> createState() => _RequestsTabsState();
}

class _RequestsTabsState extends State<RequestsTabs> {
  final List<GlobalKey> _globalKeys = [];

  static animatedRowScroll(BuildContext context) {
    Scrollable.ensureVisible(context,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        alignment: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: BlocBuilder<MyRequestsBloc, AppState>(
        builder: (context, state) {
          return StreamBuilder<RequestStatus>(
              stream: MyRequestsBloc.instance.selectStatusStream,
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 12.h),
                      ...List.generate(
                        MyRequestsBloc.instance.tabs.length,
                        (index) {
                          _globalKeys.add(GlobalKey(debugLabel: "$index"));
                          Future.delayed(const Duration(seconds: 1), () {
                            animatedRowScroll(_globalKeys[
                                        MyRequestsBloc.instance.tabs[index] ==
                                                snapshot.data
                                            ? index
                                            : 0]
                                    .currentContext ??
                                context);
                          });
                          return InkWell(
                            key: _globalKeys[index],
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (state is! Loading) {
                                MyRequestsBloc.instance.updateSelectStatus(
                                    MyRequestsBloc.instance.tabs[index]);
                                MyRequestsBloc.instance
                                    .add(Click(arguments: SearchEngine()));
                              }
                            },
                            child: FilterOption(
                              title: allTranslations.text(
                                  MyRequestsBloc.instance.tabs[index].name),
                              isSelect: MyRequestsBloc.instance.tabs[index] ==
                                  snapshot.data,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
