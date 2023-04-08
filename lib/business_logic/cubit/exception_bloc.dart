import '../../business_logic/message_notify.dart';

class ExceptionBloc implements Exception {
  MessageNotify message;
  ExceptionBloc({required this.message});
}