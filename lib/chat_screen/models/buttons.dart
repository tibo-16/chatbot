import 'package:chatbot/chat_screen/models/content.dart';
import 'package:flutter/material.dart';

class Buttons implements Content {
  List<String> texts;
  Function function;
  bool isUser;
  bool isNext;

  DateTime time;

  Buttons(
      {@required this.texts,
      @required this.function,
      @required this.isUser,
      @required this.isNext,
      this.time})
      : assert(texts != null || texts.length != 0),
        assert(function != null),
        assert(isUser != null),
        assert(isNext != null);
}
