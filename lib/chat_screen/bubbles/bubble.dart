import 'package:chatbot/chat_screen/bubbles/buttons_bubble.dart';
import 'package:chatbot/chat_screen/bubbles/message_bubble.dart';
import 'package:chatbot/chat_screen/bubbles/picture_bubble.dart';
import 'package:chatbot/chat_screen/models/content.dart';
import 'package:chatbot/chat_screen/models/message.dart';
import 'package:chatbot/chat_screen/models/picture.dart';
import 'package:chatbot/constants.dart';
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  Bubble({Key key, @required this.content, @required this.animation})
      : assert(content != null),
        assert(animation != null),
        super(key: key);

  final Content content;
  final Animation<double> animation;

  Color get bg {
    return content.isUser ? Constants.BUBBLE_COLOR : Colors.white;
  }

  Color get textColor {
    return content.isUser ? Colors.white : Colors.black;
  }

  CrossAxisAlignment get bubbleAlign {
    return content.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  }

  MainAxisAlignment get rowAlign {
    return content.isUser ? MainAxisAlignment.end : MainAxisAlignment.start;
  }

  EdgeInsets get timeMargin {
    return content.isUser
        ? const EdgeInsets.only(top: 2.0, right: 3.0)
        : const EdgeInsets.only(top: 2.0, left: 3.0);
  }

  BorderRadius get radius {
    return content.isUser
        ? BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topRight: content.isNext ? Radius.circular(10.0) : Radius.zero)
        : BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topLeft: content.isNext ? Radius.circular(10.0) : Radius.zero);
  }

  List<BoxShadow> get shadow {
    return [
      BoxShadow(
          blurRadius: .5,
          spreadRadius: 1.0,
          color: Colors.black.withOpacity(.12))
    ];
  }

  Alignment get animationAlign {
    return content.isUser ? Alignment.topRight : Alignment.topLeft;
  }

  String get paddedTime {
    if (content.time == null) return "";

    return '${content.time.hour.toString().padLeft(2, '0')}:${content.time.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildChild() {
    if (content is Message) {
      return MessageBubble(
        message: content,
        animation: animation,
        shadow: shadow,
        bg: bg,
        radius: radius,
        textColor: textColor,
      );
    } else if (content is Picture) {
      return PictureBubble(
        picture: content,
        animation: animation,
        shadow: shadow,
        bg: bg,
        radius: radius,
        textColor: textColor,
      );
    } else {
      return ButtonsBubble(
        buttons: content,
        animation: animation,
        shadow: shadow,
        bg: bg,
        radius: radius,
        textColor: textColor,
      );
    }
  }

  Widget _buildBubbleColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: bubbleAlign,
      children: <Widget>[
        Visibility(
          visible: !content.isNext,
          child: Column(
            crossAxisAlignment: bubbleAlign,
            children: <Widget>[
              Container(
                margin: content.isUser
                    ? const EdgeInsets.only(left: 3.0, bottom: 3.0)
                    : const EdgeInsets.only(right: 3.0, bottom: 3.0),
                child: Text(
                  content.isUser ? Constants.USERNAME : Constants.CHATBOT_NAME,
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
        _buildChild(),
        Visibility(
          visible: content.time != null,
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
      children: <Widget>[_buildBubbleColumn(context)],
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
