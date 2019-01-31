import 'package:chatbot/message.dart';
import 'package:chatbot/message_list_model.dart';
import 'package:chatbot/message_bubble.dart';
import 'package:chatbot/text_composer.dart';
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

  List<Message> _initialMessages = [
    Message(
      text: 'Wie kann ich dir helfen?',
      time: DateTime.now(),
      isUser: false,
      isNext: true,
    ),
    Message(
      text: 'Hi! Mein Name ist Bot.',
      isUser: false,
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

  _textMessageSubmitted(String text) {
    Message message = Message(
      text: text,
      time: DateTime.now(),
      isUser: true,
      isNext: false,
    );
    Message lastMessage = _list.first;

    if (lastMessage.isUser) {
      lastMessage.time = null;
      message.isNext = true;
    }

    setState(() {
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
              TextComposer(
                submitText: _textMessageSubmitted,
              )
            ],
          ),
        ),
      ),
    );
  }
}
