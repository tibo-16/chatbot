import 'package:flutter/material.dart';

class Message {
  String message;
  DateTime time;
  bool isUser;
  bool online;
  bool isNext;
  bool showAvatar;
  String username;

  Message(
      {@required this.message,
      @required this.isUser,
      @required this.isNext,
      @required this.showAvatar,
      this.time,
      this.online,
      this.username})
      : assert(message != null),
        assert(isUser != null),
        assert(isNext != null),
        assert(showAvatar != null);
}
