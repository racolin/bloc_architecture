import '../../presentation/dialogs/message_notify_type.dart';

class MessageNotify {
  // final NotifyType notifyType;
  final MessageType messageType;
  final String title;
  final String content;

  MessageNotify({
    // required this.notifyType,
    required this.messageType,
    required this.title,
    required this.content,
  });
}
