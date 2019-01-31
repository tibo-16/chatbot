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

  Widget _buildSendButton() {
    return Container(
      constraints: BoxConstraints(maxHeight: 36.0, maxWidth: 36.0),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        color: Theme.of(context).accentColor,
        disabledColor: Theme.of(context).disabledColor,
        child: Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
        shape: CircleBorder(),
        onPressed: _isComposingMessage
            ? () => _textMessageSubmitted(_textEditingController.text)
            : null,
      ),
    );
  }

  Widget _buildTextComposer() {
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
          _buildSendButton(),
        ],
      ),
    );
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
                height: 2.0,
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
