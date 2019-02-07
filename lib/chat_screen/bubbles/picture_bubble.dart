import 'package:chatbot/chat_screen/models/picture.dart';
import 'package:flutter/material.dart';

class PictureBubble extends StatelessWidget {
  PictureBubble(
      {Key key,
      @required this.picture,
      @required this.animation,
      @required this.shadow,
      @required this.bg,
      @required this.radius,
      @required this.textColor})
      : assert(picture != null),
        assert(animation != null),
        assert(shadow != null),
        assert(bg != null),
        assert(radius != null),
        assert(textColor != null),
        super(key: key);

  final Picture picture;
  final Animation<double> animation;
  final List<BoxShadow> shadow;
  final Color bg, textColor;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
          maxHeight: MediaQuery.of(context).size.height * 0.3),
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: shadow,
        color: bg,
        borderRadius: radius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: AssetImage(picture.file), fit: BoxFit.cover),
              ),
            ),
          ),
          Visibility(
            visible: picture.message != null,
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                picture.message,
                style: TextStyle(color: textColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
