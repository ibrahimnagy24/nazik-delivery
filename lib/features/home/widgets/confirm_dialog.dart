import 'package:flutter/material.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/custom_btn.dart';
import '../../../core/app_event.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/text_styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../bloc/purchase_bloc.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key, required this.message, required this.id});
  final String message;
  final List<int> id;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.WHITE_COLOR,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 100,
            color: Styles.IN_ACTIVE,
          ),

          ///Title
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              allTranslations.text("are_you_sure_you_want_to_continue"),
              style: AppTextStyles.w600
                  .copyWith(fontSize: 16, color: Styles.HEADER),
            ),
          ),

          ///Title
          Text(
            allTranslations.text("some_items_not_available"),
            style:
                AppTextStyles.w400.copyWith(fontSize: 14, color: Styles.HEADER),
          ),

          ///message
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              message,
              style: AppTextStyles.w400
                  .copyWith(fontSize: 14, color: Styles.SUBTITLE),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: BlocBuilder<PurchaseBloc, AppState>(
                  builder: (context, state) {
                    return CustomBtn(
                      onPressed: () => PurchaseBloc.instance.add(Click()),
                      text: allTranslations.text("confirm"),
                      loading: state is Loading,
                    );
                  },
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: CustomBtn(
                  text: allTranslations.text("cancel"),
                  onPressed: () => CustomNavigator.pop(),
                  textColor: Styles.PRIMARY_COLOR,
                  borderColor: Styles.PRIMARY_COLOR,
                  color: Styles.WHITE_COLOR,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
