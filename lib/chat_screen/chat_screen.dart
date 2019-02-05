import 'dart:math';

import 'package:chatbot/chat_screen/bubbles/bubble.dart';
import 'package:chatbot/chat_screen/models/buttons.dart';
import 'package:chatbot/chat_screen/models/content.dart';
import 'package:chatbot/chat_screen/models/list_model.dart';
import 'package:chatbot/chat_screen/models/message.dart';
import 'package:chatbot/chat_screen/models/picture.dart';
import 'package:chatbot/chat_screen/text_composer.dart';
import 'package:chatbot/constants.dart';
import 'package:chatbot/evaluation_screen.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<Content> _list;

  List<Content> _initialContent = [];

  @override
  void initState() {
    super.initState();

    _list = ListModel<Content>(
      listKey: _listKey,
      initialItems: _initialContent,
    );

    Future.delayed(const Duration(microseconds: 750), () {
      _list.insert(
          0,
          Message(
            text: 'Hi! Ich bin ${Constants.CHATBOT_NAME}.',
            isUser: false,
            isNext: false,
          ));
      _list.insert(
          0,
          Message(
            text: 'Wie kann ich dir behilflich sein?',
            time: DateTime.now(),
            isUser: false,
            isNext: true,
          ));
    });
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

    Picture botPicture = Picture(
        file: 'images/avatar.png',
        message: 'Beispiel Text',
        isUser: false,
        isNext: false);

    Message botMessage = Message(
        text: 'Welche Nachrichten möchtest du sehen?',
        isUser: false,
        isNext: true);

    List<String> texts = ['Neuste Nachrichten', 'Top Nachrichten'];
    List<Function> functions = [() => print('one'), () => print('two')];

    Buttons botButtons = Buttons(
        texts: texts,
        functions: functions,
        isUser: false,
        isNext: true,
        time: DateTime.now());

    Random random = new Random(1);
    int randomDuration = 250 + random.nextInt(1000 - 250);

    setState(() {
      _list.insert(0, userMessage);

      Future.delayed(Duration(milliseconds: randomDuration), () {
        _list.insert(0, botPicture);
        _list.insert(0, botMessage);
        _list.insert(0, botButtons);
      });
    });
  }

  _showEvaluation() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            maintainState: false,
            fullscreenDialog: true,
            builder: (context) => EvaluationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        automaticallyImplyLeading: false,
        backgroundColorStart: Theme.of(context).primaryColor,
        backgroundColorEnd: Constants.SIEMENS_COLOR,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/avatar.png'),
            Text(
              Constants.CHATBOT_NAME,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: _showEvaluation,
          )
        ],
      ),
      backgroundColor: Colors.blueGrey.shade50,
      body: SafeArea(
        top: true,
        bottom: true,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          behavior: HitTestBehavior.opaque,
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
