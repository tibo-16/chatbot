import 'package:chatbot/chat_screen/models/message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {Key key,
      @required this.message,
      @required this.animation,
      @required this.shadow,
      @required this.bg,
      @required this.radius,
      @required this.textColor})
      : assert(message != null),
        assert(animation != null),
        assert(shadow != null),
        assert(bg != null),
        assert(radius != null),
        assert(textColor != null),
        super(key: key);

  final Message message;
  final Animation<double> animation;
  final List<BoxShadow> shadow;
  final Color bg, textColor;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.80),
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
    );
  }
}
