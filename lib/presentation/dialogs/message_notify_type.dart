import 'package:flutter/material.dart';

enum MessageType {
  error(Colors.red),
  failure(Colors.orange),
  success(Colors.green),
  info(Colors.blue),
  none(Colors.grey);

  const MessageType(this.color);

  final Color color;
}

enum NotifyType { dialog, snackBar }
