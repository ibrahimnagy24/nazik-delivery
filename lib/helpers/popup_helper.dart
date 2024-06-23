import 'package:flutter/material.dart';

abstract class PopUpHelper {
  static showTopSheet({
    required BuildContext? context,
    required Widget? child,
  }) {
    return showGeneralDialog(
      context: context!,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: child,
            ),
          ],
        );
      },
      transitionBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return SlideTransition(
          position: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ).drive(
            Tween<Offset>(
              begin: const Offset(0, -1.0),
              end: Offset.zero,
            ),
          ),
          child: child,
        );
      },
    );
  }

  static showBottomSheet(
      {required BuildContext? context, required Widget? child}) {
    return showModalBottomSheet(
      context: context!,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (_) {
        return child!;
      },
    );
  }
}
