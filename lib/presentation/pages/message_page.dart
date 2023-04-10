import '../business_logic/message_notify.dart';
import 'package:flutter/material.dart';

import '../res/dimen/dimens.dart';

class MessagePage extends StatelessWidget {
  final MessageNotify message;
  final Widget Function(BuildContext context) action;

  const MessagePage({
    Key? key,
    required this.message,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_queue_outlined,
            color: message.messageType.color,
            size: dimXXL,
          ),
          const SizedBox(
            height: spaceMD,
          ),
          Text(
            message.title,
            style: TextStyle(
              color: message.messageType.color,
              fontSize: fontXXL,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: spaceMD,
          ),
          Text(
            message.content,
            style: const TextStyle(
              fontSize: fontLG,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: spaceMD,
          ),
          action(context),
        ],
      ),
    );
  }
}
