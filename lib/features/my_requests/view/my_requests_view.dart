import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_app_bar.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import '../../../bloc/user_bloc.dart';
import '../../../core/app_event.dart';
import '../../../model/search_engine.dart';
import '../bloc/my_requests_bloc.dart';
import '../widgets/requests_body.dart';
import '../widgets/requests_tabs.dart';

class MyRequestsView extends StatefulWidget {
  const MyRequestsView({super.key});

  @override
  State<MyRequestsView> createState() => _MyRequestsViewState();
}

class _MyRequestsViewState extends State<MyRequestsView> {
  @override
  void initState() {
    UserBloc.instance.add(Click());
    MyRequestsBloc.instance.add(Click(arguments: SearchEngine()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: allTranslations.text("requests"),
        withBack: false,
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
