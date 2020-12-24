import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/view/button.dart';

class SpyfallDialog {
  static void showInfoDialog({String text, String title}) {
    Get.defaultDialog(
      backgroundColor: Colors.grey[850],
      middleTextStyle: TextStyle(
        color: Colors.grey[100],
      ),
      titleStyle: TextStyle(
        color: Colors.orange,
      ),
      confirm: SpyfallRoundedRectangleButton(
        text: 'OK',
        onPressed: () => Get.back(),
        fontSize: 14.0,
      ),
      title: title,
      middleText: text,
    );
  }

  static void showPickTimeDialog(
      {Function(Duration) onReceiveInput, Duration initialTimerDuration}) {
    Duration dur = initialTimerDuration;
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey[850],
        content: CupertinoTheme(
          data: CupertinoThemeData(
            brightness: Brightness.dark,
          ),
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.ms,
            onTimerDurationChanged: (d) {
              dur = d;
            },
            initialTimerDuration: dur,
          ),
        ),
        actions: [
          SpyfallRoundedRectangleButton(
            text: 'CANCEL',
            fontSize: 12.0,
            onPressed: () => Get.back(),
          ),
          SpyfallRoundedRectangleButton(
            text: 'DONE',
            fontSize: 12.0,
            onPressed: () {
              Get.back();
              if (onReceiveInput != null) onReceiveInput(dur);
            },
          ),
        ],
      ),
    );
  }

  static void showInputDialog(
      {String labelText, String hintText, Function(String) onReceiveInput}) {
    TextEditingController controller = TextEditingController();
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey[850],
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: controller,
                style: TextStyle(
                  color: Colors.grey[100],
                ),
                autofocus: true,
                decoration: InputDecoration(
                  labelText: labelText,
                  hintText: hintText,
                  labelStyle: TextStyle(
                    color: Colors.orange,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            )
          ],
        ),
        actions: [
          SpyfallRoundedRectangleButton(
            text: 'CANCEL',
            fontSize: 12.0,
            onPressed: () => Get.back(),
          ),
          SpyfallRoundedRectangleButton(
            text: 'DONE',
            fontSize: 12.0,
            onPressed: () {
              Get.back();
              if (onReceiveInput != null) onReceiveInput(controller.text);
            },
          ),
        ],
      ),
    );
  }

  /// Make sure to pop the dialog on pressing button
  static void showAreYouSureDialog({String text, Function onConfirm}) {
    Get.defaultDialog(
      backgroundColor: Colors.grey[850],
      middleTextStyle: TextStyle(
        color: Colors.grey[100],
      ),
      titleStyle: TextStyle(
        color: Colors.orange,
      ),
      confirm: SpyfallRoundedRectangleButton(
        text: 'OK',
        onPressed: onConfirm,
        fontSize: 14.0,
      ),
      cancel: SpyfallRoundedRectangleButton(
        text: 'CANCEL',
        onPressed: () => Get.back(),
        fontSize: 14.0,
      ),
      title: 'Confirm',
      middleText: text,
    );
  }
}
