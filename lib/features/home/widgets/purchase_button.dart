import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_btn.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_event.dart';
import '../bloc/purchase_bloc.dart';

class PurchaseButton extends StatelessWidget {
  const PurchaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: StreamBuilder<List<int>?>(
          stream: PurchaseBloc.instance.itemsStream,
          builder: (context, snapshot) {
            return BlocBuilder<PurchaseBloc, AppState>(
              builder: (context, state) {
                return CustomBtn(
                  onPressed: () => PurchaseBloc.instance.add(Click()),
                  text: allTranslations.text("purchase"),
                  active: snapshot.data != null && snapshot.data!.isNotEmpty,
                  loading: state is Loading,
                );
              },
            );
          }),
    );
  }
}
