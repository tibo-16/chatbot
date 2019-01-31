import 'package:chatbot/models/content.dart';
import 'package:flutter/material.dart';

class Buttons implements Content {
  List<String> texts;
  List<Function> functions;
  bool isUser;
  bool isNext;

  DateTime time;

  Buttons(
      {@required this.texts,
      @required this.functions,
      @required this.isUser,
      @required this.isNext,
      this.time})
      : assert(texts != null || texts.length != 0),
        assert(functions != null || functions.length != 0),
        assert(texts.length == functions.length),
        assert(isUser != null),
        assert(isNext != null);
}
