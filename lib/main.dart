import 'package:chatbot/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chatbot',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: ChatScreen());
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final TextEditingController _textEditingController =
      new TextEditingController();
  bool _isComposingMessage = false;

  List<Message> _messages = [
    Message(
      message: 'Wie kann ich dir helfen?',
      showAvatar: true,
      time: DateTime.now(),
      isUser: false,
      online: true,
      isNext: true,
    ),
    Message(
      message: 'Hi! Mein Name ist Bot.',
      showAvatar: true,
      isUser: false,
      online: true,
      isNext: false,
    )
  ];

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isComposingMessage
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: new Container(
            child: new Row(
              children: <Widget>[
                new Flexible(
                  child: new TextField(
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    controller: _textEditingController,
                    onChanged: (String messageText) {
                      setState(() {
                        _isComposingMessage = messageText.length > 0;
                      });
                    },
                    decoration: new InputDecoration.collapsed(
                        hintText: "Was möchtest du Bot fragen?"),
                  ),
                ),
                new Container(
                  child: getDefaultSendButton(),
                ),
              ],
            ),
          ),
        ));
  }

  _textMessageSubmitted(String text) {
    _textEditingController.clear();
    FocusScope.of(context).requestFocus(new FocusNode());

    setState(() {
      _isComposingMessage = false;

      _messages.add(Message(
          message: text,
          time: DateTime.now(),
          isUser: true,
          online: true,
          isNext: false,
          showAvatar: false,
          username: 'Tobi'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedList(
                    key: _listKey,
                    reverse: true,
                    initialItemCount: _messages.length,
                    itemBuilder: (BuildContext context, int index,
                        Animation<double> animation) {
                      return _messages[index];
                    },
                  ),
                ),
              ),
              Divider(
                height: 1.0,
                color: Colors.black26,
              ),
              Container(
                child: _buildTextComposer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
