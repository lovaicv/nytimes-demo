import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSimpleDialog(String message) {
  if (Get.isDialogOpen ?? false) Get.back();
  Get.dialog(
    GetPlatform.isIOS
        ? CupertinoAlertDialog(
            content: simpleDialogContent(message),
            actions: [simpleDialogActions()],
          )
        : AlertDialog(
            content: simpleDialogContent(message),
            actions: [simpleDialogActions()],
          ),
  );
}

simpleDialogContent(String message) {
  return Text(message);
}

simpleDialogActions() {
  return TextButton(onPressed: () => Get.back(), child: const Text('OK'));
}
