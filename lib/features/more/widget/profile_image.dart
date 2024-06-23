import 'package:flutter/material.dart';

import '../../../bloc/user_bloc.dart';
import '../../../components/custom_network_image.dart';
import '../../../core/app_core.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/text_styles.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserBloc.instance.user?.profilePhoto != null
        ? CustomNetworkImage.circleNewWorkImage(
            color: Styles.PRIMARY_COLOR,
            image: UserBloc.instance.user?.profilePhoto,
            radius: 45)
        : Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Styles.PRIMARY_COLOR,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              AppCore.getInitials(
                  text: UserBloc.instance.user?.name ?? "Test", limitTo: 2),
              style: AppTextStyles.w700
                  .copyWith(color: Styles.WHITE_COLOR, fontSize: 35),
            ),
          );
  }
}
