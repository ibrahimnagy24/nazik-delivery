import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_btn.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/features/my_refunds/bloc/my_money_refunds_bloc.dart';
import 'package:flutter_base/features/my_refunds/bloc/update_refund_status_bloc.dart';
import 'package:flutter_base/features/my_refunds/model/refunds_model.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_event.dart';

class UpdateMoneyRefundActions extends StatelessWidget {
  const UpdateMoneyRefundActions(
      {super.key, required this.id, required this.status});
  final int id;
  final RefundStatus status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Expanded(
              child: BlocProvider(
            create: (context) => UpdateRefundStatusBloc(),
            child: BlocBuilder<UpdateRefundStatusBloc, AppState>(
              builder: (context, state) {
                return CustomBtn(
                  text: allTranslations.text(MyMoneyRefundsBloc
                      .instance
                      .moneyStatus[
                          (MyMoneyRefundsBloc.instance.getStatusIndex(status) +
                              1)]
                      .name),
                  height: 40,
                  loading: state is Loading,
                  onPressed: () => context
                      .read<UpdateRefundStatusBloc>()
                      .add(Click(arguments: {
                        "id": id,
                        "status": MyMoneyRefundsBloc
                            .instance
                            .moneyStatus[(MyMoneyRefundsBloc.instance
                                    .getStatusIndex(status) +
                                1)]
                            .name,
                        "onSuccess": () => MyMoneyRefundsBloc.instance
                            .add(Update(arguments: id))
                      })),
                );
              },
            ),
          )),
          if (status == RefundStatus.awaiting_money_picked)
            SizedBox(width: 12.w),
          if (status == RefundStatus.awaiting_money_picked)
            Expanded(
                child: BlocProvider(
              create: (context) => UpdateRefundStatusBloc(),
              child: BlocBuilder<UpdateRefundStatusBloc, AppState>(
                builder: (context, state) {
                  return CustomBtn(
                    text: allTranslations.text("delete"),
                    height: 40,
                    loading: state is Loading,
                    color: Styles.IN_ACTIVE.withOpacity(0.1),
                    textColor: Styles.IN_ACTIVE,
                    onPressed: () => context
                        .read<UpdateRefundStatusBloc>()
                        .add(Click(arguments: {
                          "id": id,
                          "status": RefundStatus.awaiting_money.name,
                          "onSuccess": () => MyMoneyRefundsBloc.instance
                              .add(Update(arguments: id))
                        })),
                  );
                },
              ),
            )),
        ],
      ),
    );
  }
}
