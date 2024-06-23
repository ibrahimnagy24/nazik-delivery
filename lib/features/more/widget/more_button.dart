import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../bloc/main_app_bloc.dart';
import '../../../components/custom_images.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/text_styles.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({
    required this.title,
    required this.icon,
    this.bing,
    this.isLoading = false,
    this.onTap,
    this.isLogout = false,
    this.color = Styles.PRIMARY_COLOR,
    super.key,
  });

  final String title, icon;
  final Function()? onTap;
  final bool isLoading;
  final bool? bing;
  final Color? color;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
            border: Border(
                bottom: BorderSide(
                    color: isLogout ? Colors.transparent : Styles.BORDER_COLOR,
                    width: isLogout ? 0 : 1))),
        child: Row(
          children: [
            RotatedBox(
              quarterTurns: mainAppBloc.lang.valueOrNull == "en"
                  ? 0
                  : isLogout
                      ? 2
                      : 0,
              child: customImageIconSVG(
                imageName: icon,
                width: 24,
                height: 24,
                color: color,
              ),
            ),
            SizedBox(width: 10.w),
            isLoading
                ? const SpinKitThreeBounce(
                    color: Styles.DARK_RED,
                    size: 25,
                  )
                : Text(
                    title,
                    style: AppTextStyles.w600.copyWith(
                      fontSize: 14,
                      color: Styles.HEADER,
                    ),
                  ),
            const Expanded(child: SizedBox()),
            Visibility(
              visible: !isLogout,
              child: const Icon(Icons.arrow_forward_ios,
                  color: Styles.HEADER, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
