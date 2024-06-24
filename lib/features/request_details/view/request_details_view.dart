import 'package:flutter/material.dart';
import 'package:flutter_base/components/animated_widget.dart';
import 'package:flutter_base/components/custom_app_bar.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/request_details_bloc.dart';

class RequestDetailsView extends StatelessWidget {
  const RequestDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: allTranslations.text("request_details"),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => RequestDetailsBloc(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Expanded(child: BlocBuilder<RequestDetailsBloc, AppState>(
                  builder: (context, state) {
                    return ListAnimator(
                      data: [],
                    );
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
