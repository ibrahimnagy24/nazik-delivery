import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_app_bar.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/features/refund_details/bloc/refund_details_bloc.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/animated_widget.dart';
import '../../../components/empty_container.dart';
import '../../../core/app_event.dart';
import '../../../helpers/styles.dart';
import '../../my_refunds/model/refunds_model.dart';
import '../widgets/refund_details_actions.dart';
import '../widgets/refund_details_body.dart';

class RefundDetailsView extends StatelessWidget {
  const RefundDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: allTranslations.text("refund_details"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocProvider(
            create: (context) => RefundDetailsBloc()..add(Click(arguments: id)),
            child: BlocBuilder<RefundDetailsBloc, AppState>(
              builder: (context, state) {
                if (state is Done) {
                  RefundModel model = state.model as RefundModel;
                  return Column(
                    children: [
                      RefundDetailsBody(model: model),
                      RefundDetailsActions(model: model),
                    ],
                  );
                }
                if (state is Loading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Styles.PRIMARY_COLOR,
                  ));
                }
                if (state is Empty || State is Error) {
                  return RefreshIndicator(
                    color: Styles.PRIMARY_COLOR,
                    onRefresh: () async {
                      context
                          .read<RefundDetailsBloc>()
                          .add(Click(arguments: id));
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: ListAnimator(
                            data: [
                              SizedBox(height: 80.h),
                              EmptyContainer(
                                txt: state is Error
                                    ? allTranslations
                                        .text("something_went_wrong")
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
