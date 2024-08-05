import 'package:flutter/material.dart';

import '../../my_refunds/model/refunds_model.dart';
import '../../my_refunds/widgets/order/update_order_refund_actions.dart';
import 'assign_refund_button.dart';

class RefundDetailsActions extends StatelessWidget {
  const RefundDetailsActions({super.key, required this.model});
  final RefundModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (model?.status == RefundStatus.in_turkiye)
        //   AssignRefundItemButton(model: model!),
        if (model.status == RefundStatus.awaiting_pickup)
          UpdateOrderRefundActions(
            model: model,
            fromMyRefunds: false,
          ),
      ],
    );
  }
}
