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

  _submitText() {
    widget.submitText(_textEditingController.text);
    _textEditingController.clear();
    setState(() {
      _isComposingMessage = false;
    });
  }

  _submitVoice() {}

  Widget _buildRightButton() {
    return Container(
      constraints: BoxConstraints(maxHeight: 36.0, maxWidth: 36.0),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        color: Theme.of(context).accentColor,
        child: Icon(
          _isComposingMessage ? Icons.arrow_upward : Icons.mic,
          color: Colors.white,
        ),
        shape: CircleBorder(),
        onPressed: _isComposingMessage ? _submitText : _submitVoice,
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
                textInputAction: TextInputAction.newline,
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
