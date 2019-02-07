import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  final Function submitText;

  TextComposer({@required this.submitText}) : assert(submitText != null);

  @override
  State<StatefulWidget> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  bool _isComposingMessage = false;
  bool _isUsingVoice = false;

  _submitText() {
    widget.submitText(_textEditingController.text);
    setState(() {
      _textEditingController.clear();
      _isComposingMessage = false;
    });
  }

  _submitVoice() {
    // setState(() {
    //   _isUsingVoice = !_isUsingVoice;
    // });

    // if (_isUsingVoice) {
    //   // Write Fake Text
    //   _textEditingController.clear();
    //   List<String> fakeText =
    //       'Zeige mir den Aktienkurs der letzten drei Monate'.split(' ');
    //   Random random = new Random(1);

    //   for (int i = 1; i <= fakeText.length; i++) {
    //     int minimum = i * 400;
    //     int randomDuration = minimum + random.nextInt(200);

    //     Future.delayed(Duration(milliseconds: randomDuration), () {
    //       setState(() {
    //         _textEditingController.text += fakeText[i - 1] + ' ';
    //       });
    //     });
    //   }
    // }
  }

  Icon get icon {
    if (_isUsingVoice)
      return Icon(
        Icons.close,
        color: Colors.redAccent,
      );
    else if (_isComposingMessage)
      return Icon(
        Icons.arrow_upward,
        color: Colors.white,
      );
    else
      return Icon(
        Icons.mic,
        color: Colors.white,
      );
  }

  Widget _buildRightButton() {
    return Container(
      constraints: BoxConstraints(maxHeight: 36.0, maxWidth: 36.0),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        color:
            !_isUsingVoice ? Theme.of(context).accentColor : Colors.transparent,
        child: icon,
        shape: CircleBorder(),
        onPressed:
            !_isUsingVoice && _isComposingMessage ? _submitText : _submitVoice,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Flexible(
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: new TextField(
                cursorRadius: Radius.circular(10.0),
                style: TextStyle(color: Colors.black, fontSize: 14),
                maxLines: null,
                autocorrect: false,
                textCapitalization: TextCapitalization.sentences,
                controller: _textEditingController,
                onChanged: (String messageText) {
                  setState(() {
                    _isComposingMessage = messageText.length > 0;
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Was möchtest du fragen?',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          _buildRightButton(),
        ],
      ),
    );
  }
}
