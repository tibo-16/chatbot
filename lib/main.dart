import 'dart:math';

import 'package:chatbot/bubbles/bubble.dart';
import 'package:chatbot/models/buttons.dart';
import 'package:chatbot/models/content.dart';
import 'package:chatbot/models/message.dart';
import 'package:chatbot/models/list_model.dart';
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
  ListModel<Content> _list;

  List<Content> _initialContent = [
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

    _list = ListModel<Content>(
      listKey: _listKey,
      initialItems: _initialContent,
    );
  }

  _textMessageSubmitted(String text) {
    Message userMessage = Message(
      text: text,
      time: DateTime.now(),
      isUser: true,
      isNext: false,
    );

    Content lastContent = _list.first;

    if (lastContent.isUser) {
      lastContent.time = null;
      userMessage.isNext = true;
    }

    // Message botMessage = Message(
    //     text: 'Das ist aber toll!',
    //     time: DateTime.now(),
    //     isUser: false,
    //     isNext: false);

    // Picture botPicture = Picture(
    //     file: 'images/avatar.png',
    //     message: 'Ich fühl mich SUPI :)',
    //     isUser: false,
    //     isNext: false,
    //     time: DateTime.now());

    List<String> texts = ['Erster Button', 'Zweiter Button'];
    List<Function> functions = [() => print('one'), () => print('two')];

    Buttons botButtons = Buttons(
        texts: texts,
        functions: functions,
        isUser: false,
        isNext: false,
        time: DateTime.now());

    Random random = new Random(1);
    int randomDuration = 250 + random.nextInt(1000 - 250);

    setState(() {
      _list.insert(0, userMessage);

      Future.delayed(Duration(milliseconds: randomDuration),
          () => _list.insert(0, botButtons));
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
                      return Bubble(
                        content: _list[index],
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
