import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_base/widgets/tab_widget.dart';

import '../../../helpers/translation/all_translation.dart';
import '../../../model/items_model.dart';
import '../bloc/my_requests_bloc.dart';

class RequestsTabs extends StatelessWidget {
  const RequestsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: StreamBuilder<RequestStatus>(
          stream: MyRequestsBloc.instance.selectStatusStream,
          builder: (context, snapshot) {
            return Row(
              children: List.generate(
                  RequestStatus.values.length,
                  (index) => Expanded(
                        child: TabWidget(
                          data: allTranslations
                              .text(RequestStatus.values[index].name),
                          isSelected:
                              RequestStatus.values[index] == snapshot.data,
                          onClick: () => MyRequestsBloc.instance
                              .updateSelectStatus(RequestStatus.values[index]),
                          expand: true,
                        ),
                      )),
            );
          }),
    );
  }
}
