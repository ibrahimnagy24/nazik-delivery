import 'package:flutter_base/components/custom_network_image.dart';
import 'package:flutter_base/helpers/text_styles.dart';
import 'package:flutter_base/utility/extensions.dart';

import '../../../components/custom_images.dart';
import '../../../core/app_event.dart';
import '../../../helpers/styles.dart';
import '../bloc/notifications_bloc.dart';
import '../model/notifications_model.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard(
      {super.key, this.notification, this.withTopBorder = false});
  final NotificationModel? notification;
  final bool withTopBorder;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.notification?.isRead == false) {
          NotificationsBloc.instance
              .add(Update(arguments: widget.notification?.id));
          setState(() => widget.notification?.isRead = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: widget.withTopBorder
                  ? Styles.LIGHT_GREY_BORDER
                  : Colors.transparent,
            ),
            bottom: const BorderSide(
              color: Styles.LIGHT_GREY_BORDER,
            ),
          ),
          color: (widget.notification?.isRead != true)
              ? Styles.PRIMARY_COLOR.withOpacity(0.02)
              : Styles.WHITE_COLOR,
        ),
        child: Row(
          children: [
            ///Image
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: (widget.notification?.isRead != true),
                  child: Container(
                      height: 10.h,
                      width: 10.h,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Styles.PRIMARY_COLOR),
                      child: const SizedBox()),
                ),
                SizedBox(
                  width: 6.w,
                ),
                widget.notification?.image != null
                    ? CustomNetworkImage.containerNewWorkImage(
                        image: widget.notification?.image ?? "",
                        width: 50,
                        height: 50,
                        radius: 12)
                    : customContainerIconSVG(
                        imageName: "notification",
                        size: 50,
                      ),
              ],
            ),

            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.notification?.title ?? "title",
                    maxLines: 2,
                    style: AppTextStyles.w500
                        .copyWith(fontSize: 14, color: Styles.HEADER),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      widget.notification?.body ?? "body",
                      maxLines: 2,
                      style: AppTextStyles.w400
                          .copyWith(fontSize: 12, color: Styles.DETAILS),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        (widget.notification?.createdAt ?? DateTime.now())
                            .format("d/MMM/yyyy h:m a"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.w400
                            .copyWith(fontSize: 10, color: Styles.DETAILS),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
