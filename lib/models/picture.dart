import 'package:chatbot/models/content.dart';
import 'package:flutter/material.dart';

class Picture implements Content {
  String file;
  bool isUser;
  bool isNext;

  DateTime time;
  String message;

  Picture(
      {@required this.file,
      @required this.isUser,
      @required this.isNext,
      this.time,
      this.message})
      : assert(file != null),
        assert(isUser != null),
        assert(isNext != null);
}
