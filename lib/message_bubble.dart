import 'package:chatbot/constants.dart';
import 'package:chatbot/message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({Key key, @required this.message, @required this.animation})
      : assert(message != null),
        assert(animation != null),
        super(key: key);

  final Message message;
  final Animation<double> animation;

  Color get bg {
    return message.isUser ? Color.fromRGBO(25, 150, 254, 1.0) : Colors.white;
  }

  Color get textColor {
    return message.isUser ? Colors.white : Colors.black;
  }

  CrossAxisAlignment get bubbleAlign {
    return message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  }

  MainAxisAlignment get rowAlign {
    return message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start;
  }

  EdgeInsets get timeMargin {
    return message.isUser
        ? const EdgeInsets.only(top: 2.0, right: 3.0)
        : const EdgeInsets.only(top: 2.0, left: 3.0);
  }

  BorderRadius get radius {
    return message.isUser
        ? BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topRight: message.isNext ? Radius.circular(10.0) : Radius.zero)
        : BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topLeft: message.isNext ? Radius.circular(10.0) : Radius.zero);
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
    if (message.time == null) return "";

    return '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}';
  }

  Alignment get animationAlign {
    return message.isUser ? Alignment.topRight : Alignment.topLeft;
  }

  Widget buildBubbleColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: bubbleAlign,
      children: <Widget>[
        Visibility(
          visible: !message.isNext,
          child: Column(
            crossAxisAlignment: bubbleAlign,
            children: <Widget>[
              Container(
                margin: message.isUser
                    ? const EdgeInsets.only(left: 3.0, bottom: 3.0)
                    : const EdgeInsets.only(right: 3.0, bottom: 3.0),
                child: Text(
                  message.isUser ? Constants.USERNAME : Constants.CHATBOT_NAME,
                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.80),
          margin: const EdgeInsets.all(2.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: shadow,
            color: bg,
            borderRadius: radius,
          ),
          child: Text(
            message.text,
            style: TextStyle(color: textColor),
          ),
        ),
        Visibility(
          visible: message.time != null,
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
                  color: Colors.green.shade300,
                  size: 8,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMessageWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[buildBubbleColumn(context)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      alignment: animationAlign,
      scale: animation,
      child: FadeTransition(
          opacity: animation, child: _buildMessageWidget(context)),
    );
  }
}
