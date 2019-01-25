import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  Bubble(
      {this.message,
      this.time,
      this.isMe,
      this.online,
      this.isNext,
      this.showAvatar})
      : assert(message != "" && message != null),
        assert(isMe != null),
        assert(online != null),
        assert(isNext != null),
        assert(showAvatar != null);

  final String message;
  final DateTime time;
  final bool isMe, online, isNext, showAvatar;

  Color get bg {
    return isMe ? Color.fromRGBO(25, 150, 254, 1.0) : Colors.white;
  }

  Color get textColor {
    return isMe ? Colors.white : Colors.black;
  }

  CrossAxisAlignment get bubbleAlign {
    return isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  }

  MainAxisAlignment get rowAlign {
    return isMe ? MainAxisAlignment.end : MainAxisAlignment.start;
  }

  EdgeInsets get timeMargin {
    return isMe
        ? const EdgeInsets.only(top: 2.0, right: 3.0)
        : const EdgeInsets.only(top: 2.0, left: 3.0);
  }

  BorderRadius get radius {
    return isMe
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
  }

  List<BoxShadow> get shadow {
    return [
      BoxShadow(
          blurRadius: .5,
          spreadRadius: 1.0,
          color: Colors.black.withOpacity(.12))
    ];
  }

  String get paddedTime {
    if (time == null) return "";

    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Widget buildAvatar() {
    return Container(
      margin: isMe
          ? const EdgeInsets.only(left: 3.0, bottom: 3.0)
          : const EdgeInsets.only(right: 3.0, bottom: 3.0),
      constraints: BoxConstraints(minWidth: 50.0, maxWidth: 50.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
            decoration: BoxDecoration(
                boxShadow: shadow,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                image: DecorationImage(
                    image: AssetImage('images/avatar.png'),
                    fit: BoxFit.scaleDown))),
      ),
    );
  }

  Widget buildBubbleColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: bubbleAlign,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          margin: const EdgeInsets.all(2.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: shadow,
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
              mainAxisAlignment: rowAlign,
              children: <Widget>[
                Text(
                  paddedTime,
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 11,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(width: 3.0),
                Icon(
                  Icons.brightness_1,
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

  @override
  Widget build(BuildContext context) {
    if (showAvatar && !isNext) {
      return Column(
        crossAxisAlignment: bubbleAlign,
        children: <Widget>[buildAvatar(), buildBubbleColumn(context)],
      );
    } else {
      return buildBubbleColumn(context);
    }
  }
}
