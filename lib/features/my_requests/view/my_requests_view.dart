import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_app_bar.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import '../widgets/requests_body.dart';
import '../widgets/requests_tabs.dart';

class MyRequestsView extends StatelessWidget {
  const MyRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: allTranslations.text("requests"),
      ),
      body: const Column(
        children: [
          RequestsTabs(),
          RequestsBody(),
        ],
      ),
    );
  }
}
