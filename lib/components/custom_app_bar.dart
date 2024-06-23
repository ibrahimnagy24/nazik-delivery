import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../components/custom_arrow_back.dart';
import '../core/app_state.dart';
import '../helpers/media_query_helper.dart';
import '../helpers/styles.dart';
import '../helpers/text_styles.dart';
import '../navigation/custom_navigation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.onBack,
    this.title,
    this.titleWidget,
    this.action,
    this.withBack = true,
    this.arrowBack,
    this.withDivider = true,
    this.height,
    this.backGroundBackColor,
  });
  final Function()? onBack;
  final String? title;
  final Widget? titleWidget, action;
  final bool withBack;
  final Widget? arrowBack;
  final bool withDivider;
  final double? height;
  final Color? backGroundBackColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, AppState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: withDivider
                          ? Styles.LIGHT_GREY_BORDER
                          : Colors.transparent))),
          margin: EdgeInsets.only(
            top: MediaQueryHelper.topPadding + 12.h,
          ),
          padding: EdgeInsets.only(
            bottom: 12.h,
            left: 16.w,
            right: 16.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (withBack)
                InkWell(
                  onTap: () {
                    if (onBack != null) {
                      onBack!();
                    } else {
                      CustomNavigator.pop();
                    }
                  },
                  child: arrowBack ??
                      const ArrowBack(
                        color: Styles.PRIMARY_COLOR,
                      ),
                ),
              if (withBack) const SizedBox(width: 16),
              Expanded(
                child: titleWidget ??
                    Text(
                      title ?? "",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 20,
                        color: Styles.HEADER,
                      ),
                    ),
              ),
              if (withBack) const SizedBox(width: 16),
              (action != null)
                  ? action!
                  : const SizedBox(
                      width: 24,
                      height: 24,
                    )
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize =>
      Size(CustomNavigator.navigatorState.currentContext!.w, height ?? 75);
}
