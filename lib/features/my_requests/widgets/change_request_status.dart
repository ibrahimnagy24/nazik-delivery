import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_btn.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/model/items_model.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_event.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../bloc/update_request_status_bloc.dart';

class ChangeRequestStatus extends StatelessWidget {
  const ChangeRequestStatus(
      {super.key, required this.id, required this.status});
  final RequestStatus? status;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Expanded(
            child: BlocProvider(
              create: (context) => UpdateRequestStatusBloc(),
              child: BlocBuilder<UpdateRequestStatusBloc, AppState>(
                builder: (context, state) {
                  print("===> ${(status)}");
                  print("===> ${(status?.index ?? 0) + 1}");
                  return CustomBtn(
                    height: 35,
                    radius: 100,
                    fontSize: 13,
                    text: allTranslations.text(
                        RequestStatus.values[(status?.index ?? 0) + 1].name),
                    color: Styles.requestStatus(
                            RequestStatus.values[(status?.index ?? 0) + 1])
                        .withOpacity(0.08),
                    textColor: Styles.requestStatus(
                        RequestStatus.values[(status?.index ?? 0) + 1]),
                    onPressed: () => context
                        .read<UpdateRequestStatusBloc>()
                        .add(Click(arguments: {
                          "id": id,
                          "status": RequestStatus
                              .values[(status?.index ?? 0) + 1].index
                        })),
                  );
                },
              ),
            ),
          ),
          if (RequestStatus.inProgress == status) SizedBox(width: 8.w),
          if (RequestStatus.inProgress == status)
            Expanded(
              child: BlocProvider(
                create: (context) => UpdateRequestStatusBloc(),
                child: BlocBuilder<UpdateRequestStatusBloc, AppState>(
                  builder: (context, state) {
                    return CustomBtn(
                      height: 35,
                      radius: 100,
                      fontSize: 13,
                      text: allTranslations.text("cancel"),
                      color: Styles.IN_ACTIVE.withOpacity(0.1),
                      textColor: Styles.IN_ACTIVE,
                      onPressed: () => context
                          .read<UpdateRequestStatusBloc>()
                          .add(Click(arguments: {"id": id, "status": 6})),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
