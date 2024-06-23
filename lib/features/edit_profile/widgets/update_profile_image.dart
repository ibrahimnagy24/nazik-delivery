import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_bloc.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../core/app_core.dart';
import '../../../helpers/image_picker_helper.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/text_styles.dart';
import '../bloc/edit_profile_bloc.dart';

class UpdateProfileImage extends StatelessWidget {
  const UpdateProfileImage({super.key, this.withEdit = true});
  final bool withEdit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, AppState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (withEdit) {
              ImagePickerHelper.showOption(
                  onGet: context.read<EditProfileBloc>().updateImage);
            }
          },
          child: Stack(
            children: [
              StreamBuilder<File?>(
                  stream: context.read<EditProfileBloc>().imageStream,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              snapshot.data!,
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                      child: Container(
                                          height: 90,
                                          width: 90,
                                          color: Colors.grey,
                                          child: const Center(
                                              child: Icon(Icons.replay,
                                                  color: Colors.green)))),
                            ),
                          )
                        : UserBloc.instance.user?.profilePhoto != null
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
                                      text: context
                                          .read<EditProfileBloc>()
                                          .name
                                          .text
                                          .trim(),
                                      limitTo: 2),
                                  style: AppTextStyles.w700.copyWith(
                                      color: Styles.WHITE_COLOR, fontSize: 35),
                                ),
                              );
                  }),
              if (withEdit)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Styles.PRIMARY_COLOR,
                          ),
                          color: Styles.WHITE_COLOR,
                          borderRadius: BorderRadius.circular(100)),
                      child: customImageIconSVG(
                          imageName: "camera", color: Styles.PRIMARY_COLOR)),
                ),
            ],
          ),
        );
      },
    );
  }
}
