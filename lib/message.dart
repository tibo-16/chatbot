import 'package:flutter/material.dart';

class Message {
  String text;
  bool isUser;
  bool isNext;

  DateTime time;

  Message(
      {@required this.text,
      @required this.isUser,
      @required this.isNext,
      this.time})
      : assert(text != null),
        assert(isUser != null),
        assert(isNext != null);
}
