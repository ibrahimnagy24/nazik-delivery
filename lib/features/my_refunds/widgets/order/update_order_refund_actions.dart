import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_btn.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/features/my_refunds/bloc/my_order_refunds_bloc.dart';
import 'package:flutter_base/features/my_refunds/bloc/update_refund_status_bloc.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_event.dart';
import '../../../refund_details/bloc/refund_details_bloc.dart';
import '../../model/refunds_model.dart';

class UpdateOrderRefundActions extends StatelessWidget {
  const UpdateOrderRefundActions({
    super.key,
    this.fromMyRefunds = true,
    required this.model,
  });

  final bool fromMyRefunds;
  final RefundModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: fromMyRefunds
          ? EdgeInsets.symmetric(vertical: 10.h)
          : EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(
              child: BlocProvider(
            create: (context) => UpdateRefundStatusBloc(),
            child: BlocBuilder<UpdateRefundStatusBloc, AppState>(
              builder: (context, state) {
                return CustomBtn(
                  text: allTranslations.text(MyOrderRefundsBloc
                      .instance
                      .orderStatus[(MyOrderRefundsBloc.instance
                              .getStatusIndex(model.status!) +
                          1)]
                      .name),
                  height: fromMyRefunds ? 40 : 55,
                  loading: state is Loading,
                  onPressed: () => context
                      .read<UpdateRefundStatusBloc>()
                      .add(Click(arguments: {
                        "id": model.id,
                        "status": MyOrderRefundsBloc
                            .instance
                            .orderStatus[(MyOrderRefundsBloc.instance
                                    .getStatusIndex(model.status!) +
                                1)]
                            .name,
                        "onSuccess": () {
                          if (fromMyRefunds) {
                            MyOrderRefundsBloc.instance
                                .add(Update(arguments: model.id));
                          } else {
                            model.status = MyOrderRefundsBloc.instance
                                .orderStatus[(MyOrderRefundsBloc.instance
                                    .getStatusIndex(model.status!) +
                                1)];
                            context
                                .read<RefundDetailsBloc>()
                                .add(Update(arguments: model));
                          }
                        }
                      })),
                );
              },
            ),
          )),
          if (model.status == RefundStatus.awaiting_pickup ||
              model.status == RefundStatus.awaiting_money_picked)
            SizedBox(width: 12.w),
          if (model.status == RefundStatus.awaiting_pickup ||
              model.status == RefundStatus.awaiting_money_picked)
            Expanded(
                child: BlocProvider(
              create: (context) => UpdateRefundStatusBloc(),
              child: BlocBuilder<UpdateRefundStatusBloc, AppState>(
                builder: (context, state) {
                  return CustomBtn(
                    text: allTranslations.text("delete"),
                    height: fromMyRefunds ? 40 : 55,
                    loading: state is Loading,
                    color: Styles.IN_ACTIVE.withOpacity(0.1),
                    textColor: Styles.IN_ACTIVE,
                    onPressed: () => context
                        .read<UpdateRefundStatusBloc>()
                        .add(Click(arguments: {
                          "id": model.id,
                          "status": RefundStatus.approved.name,
                          "onSuccess": () {
                            model.status = RefundStatus.approved;
                            fromMyRefunds
                                ? MyOrderRefundsBloc.instance
                                    .add(Update(arguments: model.id))
                                : context
                                    .read<RefundDetailsBloc>()
                                    .add(Update(arguments: model));
                          }
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
