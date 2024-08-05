import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_btn.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/features/refund_details/bloc/refund_details_bloc.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_event.dart';
import '../../my_refunds/model/refunds_model.dart';
import '../bloc/assign_refund_bloc.dart';

class AssignRefundItemButton extends StatelessWidget {
  const AssignRefundItemButton({super.key, required this.model});

  final RefundModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignRefundItemBloc(),
      child: BlocBuilder<AssignRefundItemBloc, AppState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: CustomBtn(
              onPressed: () =>
                  context.read<AssignRefundItemBloc>().add(Click(arguments: {
                        "id": model.id,
                        "onSuccess": () {
                          // model.status = RefundStatus.claimed_return;
                          context
                              .read<RefundDetailsBloc>()
                              .add(Update(arguments: model));
                        }
                      })),
              text: allTranslations.text("refund").replaceAll("ال", ""),
              loading: state is Loading,
            ),
          );
        },
      ),
    );
  }
}
