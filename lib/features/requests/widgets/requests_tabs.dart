import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_base/widgets/tab_widget.dart';

import '../../../helpers/translation/all_translation.dart';
import '../../../model/items_model.dart';
import '../bloc/requests_bloc.dart';

class RequestsTabs extends StatelessWidget {
  const RequestsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: StreamBuilder<ItemStatus>(
          stream: RequestsBloc.instance.selectStatusStream,
          builder: (context, snapshot) {
            return Row(
              children: List.generate(
                  ItemStatus.values.length,
                  (index) => Expanded(
                        child: TabWidget(
                          data: allTranslations
                              .text(ItemStatus.values[index].name),
                          isSelected:
                              ItemStatus.values[index] == snapshot.data,
                          onClick: () => RequestsBloc.instance
                              .updateSelectStatus(ItemStatus.values[index]),
                          expand: true,
                        ),
                      )),
            );
          }),
    );
  }
}
