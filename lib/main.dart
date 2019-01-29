import 'package:chatbot/message.dart';
import 'package:chatbot/message_list_model.dart';
import 'package:chatbot/message_bubble.dart';
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
  MessageListModel<Message> _list;

  final TextEditingController _textEditingController =
      new TextEditingController();
  bool _isComposingMessage = false;

  List<Message> _initialMessages = [
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

  @override
  void initState() {
    super.initState();

    _list = MessageListModel<Message>(
      listKey: _listKey,
      initialItems: _initialMessages,
    );
  }

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

    Message message = Message(
      message: text,
      time: DateTime.now(),
      isUser: true,
      online: true,
      isNext: false,
      showAvatar: false,
      username: 'Tobi',
    );
    Message lastMessage = _list[0];

    if (lastMessage.isUser) {
      lastMessage.time = null;
      message.isNext = true;
      message.username = null;
    }

    setState(() {
      _isComposingMessage = false;

      _list.insert(0, message);
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
                    initialItemCount: _list.length,
                    itemBuilder: (BuildContext context, int index,
                        Animation<double> animation) {
                      return MessageBubble(
                        message: _list[index],
                        animation: animation,
                      );
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
