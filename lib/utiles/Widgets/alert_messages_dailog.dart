import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertMessagesDialog {
  static errorMessageDialog(String message) {
    Get.defaultDialog(
        title: 'Alert',
        content: Center(
          child: Column(
            children: [
              Text(message),
            ],
          ),
        ),
      actions: [
        ElevatedButton(onPressed: (){
          Get.back();
        }, child: const Icon(Icons.verified_outlined))
      ]

    );
  }
}
