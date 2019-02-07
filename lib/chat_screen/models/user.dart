import 'package:chatbot/chat_screen/models/content.dart';

class User implements Content {
  @override
  bool isNext;

  @override
  bool isUser;

  @override
  DateTime time;
}
