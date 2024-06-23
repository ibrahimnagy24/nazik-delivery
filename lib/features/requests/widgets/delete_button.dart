import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_btn.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_event.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../bloc/delete_item_bloc.dart';

class DeleteItemButton extends StatelessWidget {
  const DeleteItemButton({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteItemBloc(),
      child: BlocBuilder<DeleteItemBloc, AppState>(
        builder: (context, state) {
          return CustomBtn(
            height: 30,
            radius: 100,
            fontSize: 13,
            text: allTranslations.text("delete"),
            color: Styles.IN_ACTIVE.withOpacity(0.1),
            textColor: Styles.IN_ACTIVE,
            onPressed: () =>
                context.read<DeleteItemBloc>().add(Click(arguments: id)),
          );
        },
      ),
    );
  }
}
