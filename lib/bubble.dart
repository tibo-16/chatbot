import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  Bubble({this.message, this.time, this.isMe, this.online, this.isNext})
      : assert(message != "" && message != null),
        assert(isMe != null),
        assert(online != null),
        assert(isNext != null);

  final String message;
  final DateTime time;
  final bool isMe, online, isNext;

  String get paddedTime {
    if (time == null) return "";

    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Color.fromRGBO(28, 150, 254, 1.0) : Colors.white;
    final textColor = isMe ? Colors.white : Colors.black;
    final bubbleAlign =
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topRight: isNext ? Radius.circular(10.0) : Radius.zero)
        : BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topLeft: isNext ? Radius.circular(10.0) : Radius.zero);

    final icon = Icons.brightness_1;
    final timeAlign = isMe ? MainAxisAlignment.end : MainAxisAlignment.start;
    final timeMargin = isMe
        ? const EdgeInsets.only(top: 2.0, right: 3.0)
        : const EdgeInsets.only(top: 2.0, left: 3.0);

    return Column(
      crossAxisAlignment: bubbleAlign,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          margin: const EdgeInsets.all(2.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Text(
            message,
            style: TextStyle(color: textColor),
          ),
        ),
        Visibility(
          visible: time != null,
          child: Container(
            margin: timeMargin,
            child: Row(
              mainAxisAlignment: timeAlign,
              children: <Widget>[
                Text(
                  paddedTime,
                  style: TextStyle(color: Colors.black38, fontSize: 11, fontStyle: FontStyle.italic),
                ),
                SizedBox(width: 3.0),
                Icon(
                  icon,
                  color: online ? Colors.green.shade300 : Colors.red.shade400,
                  size: 8,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
