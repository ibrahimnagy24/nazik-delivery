import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_btn.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/model/requests_model.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_event.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../bloc/unassign_request_bloc.dart';
import '../bloc/update_request_status_bloc.dart';

class ChangeRequestStatus extends StatelessWidget {
  const ChangeRequestStatus(
      {super.key,
      required this.id,
      required this.status,
      this.fromRequestDetails = false,
      this.isDeposit = false});
  final RequestStatus status;
  final int? id;
  final bool fromRequestDetails;
  final bool isDeposit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          if (RequestStatus.inProgress == status ||
              RequestStatus.outForDelivery == status)
            Expanded(
              child: BlocProvider(
                create: (context) => UpdateRequestStatusBloc(),
                child: BlocBuilder<UpdateRequestStatusBloc, AppState>(
                  builder: (context, state) {
                    return CustomBtn(
                      height: fromRequestDetails ? 45 : 35,
                      radius: 100,
                      fontSize: 13,
                      text: allTranslations
                          .text(RequestStatus.values[status.index + 1].name),
                      // color: Styles.requestStatus(
                      //         RequestStatus.values[status.index + 1])
                      //     .withOpacity(0.08),
                      // textColor: Styles.requestStatus(
                      //     RequestStatus.values[status.index + 1]),
                      onPressed: () => context
                          .read<UpdateRequestStatusBloc>()
                          .add(Click(arguments: {
                            "id": id,
                            "status": RequestStatus.values[status.index] ==
                                    RequestStatus.inProgress
                                ? "out_for_delivery"
                                : isDeposit
                                    ? "purchase_in_progress"
                                    : "completed"
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
                create: (context) => UnAssignRequestBloc(),
                child: BlocBuilder<UnAssignRequestBloc, AppState>(
                  builder: (context, state) {
                    return CustomBtn(
                      height: fromRequestDetails ? 45 : 35,
                      radius: 100,
                      fontSize: 13,
                      text: allTranslations.text("cancel"),
                      color: Styles.IN_ACTIVE.withOpacity(0.1),
                      textColor: Styles.IN_ACTIVE,
                      onPressed: () => context
                          .read<UnAssignRequestBloc>()
                          .add(Click(arguments: id)),
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
