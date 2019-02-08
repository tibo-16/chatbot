import 'package:chatbot/chat_screen/models/buttons.dart';
import 'package:flutter/material.dart';

class ButtonsBubble extends StatefulWidget {
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

  @override
  State<StatefulWidget> createState() => _ButtonsBubbleState();
}

class _ButtonsBubbleState extends State<ButtonsBubble> {
  List<Widget> _buildButtons(BuildContext context) {
    List<Widget> buttonWidgets = [];

    int length = widget.buttons.texts.length;
    for (int i = 0; i < length; i++) {
      Padding padding = Padding(
          padding: (i < length - 1)
              ? const EdgeInsets.only(bottom: 5.0)
              : const EdgeInsets.all(0),
          child: FlatButton(
            color: Colors.grey[350],
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              widget.buttons.texts[i],
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () => widget.buttons.function(widget.buttons.texts[i]),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ));
      buttonWidgets.add(padding);
    }

    return buttonWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.80),
      margin: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildButtons(context),
      ),
    );
  }
}
