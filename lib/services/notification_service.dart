import 'package:flutter/material.dart';
import 'package:foodyeah/common/Messages.dart';

class NotificationService {
  void showSnackbar(BuildContext context, String message, String type,
      SnackBarAction? action) {
    Color background = Colors.white;
    if (type == "error") {
      background = Colors.red;
    }
    if (type == "success") {
      background = Colors.green.shade800;
    }

    if (message == Messages().successAddCart) {}

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: background,
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      action: action,
    ));
  }
}
