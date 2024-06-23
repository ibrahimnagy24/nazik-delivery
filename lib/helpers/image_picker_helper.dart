import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
  static showOption({ValueChanged<File>? onGet}) {
    showDialog(
      context: CustomNavigator.navigatorState.currentContext!,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Center(child: Text('Select Image Source')),
          actions: [
            CupertinoDialogAction(
              child: const Text('Gallery'),
              onPressed: () => openGallery(onGet: onGet),
            ),
            CupertinoDialogAction(
              child: const Text('Camera'),
              onPressed: () => openCamera(onGet: onGet),
            ),
          ],
        );
      },
    );
  }

  static openGallery({ValueChanged<File>? onGet}) async {
    CustomNavigator.pop();
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    onGet!(File(image!.path));
  }

  static openCamera({ValueChanged<File>? onGet}) async {
    CustomNavigator.pop();
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    onGet!(File(image!.path));
  }
}
