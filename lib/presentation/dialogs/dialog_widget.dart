import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../business_logic/message_notify.dart';
import '../../presentation/dialogs/message_notify_type.dart';
import '../../presentation/res/dimen/dimens.dart';

class DialogWidget extends StatelessWidget {
  final MessageNotify messageNotify;
  final List<CupertinoDialogAction> actions;

  const DialogWidget({
    Key? key,
    required this.messageNotify,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        messageNotify.title,
        style: TextStyle(
          color: messageNotify.messageType.color,
          fontSize: fontLG,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        messageNotify.content,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: fontMD,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: actions,
    );
  }
}
