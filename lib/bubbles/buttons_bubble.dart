import 'package:chatbot/models/buttons.dart';
import 'package:flutter/material.dart';

class ButtonsBubble extends StatelessWidget {
  ButtonsBubble(
      {Key key,
      @required this.buttons,
      @required this.animation,
      @required this.shadow,
      @required this.bg,
      @required this.radius,
      @required this.textColor})
      : assert(buttons != null),
        assert(animation != null),
        assert(shadow != null),
        assert(bg != null),
        assert(radius != null),
        assert(textColor != null),
        super(key: key);

  final Buttons buttons;
  final Animation<double> animation;
  final List<BoxShadow> shadow;
  final Color bg, textColor;
  final BorderRadius radius;

  List<Widget> _buildButtons(BuildContext context) {
    List<Widget> buttonWidgets = [];

    for (int i = 0; i < buttons.texts.length; i++) {
      FlatButton widget = FlatButton(
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Text(buttons.texts[i]),
        onPressed: buttons.functions[i],
      );
      buttonWidgets.add(widget);
    }

    return buttonWidgets;
  }

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
      child: Column(
        children: _buildButtons(context),
      ),
    );
  }
}
