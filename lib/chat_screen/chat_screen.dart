import 'package:chatbot/chat_screen/bubbles/bubble.dart';
import 'package:chatbot/chat_screen/dummy_content.dart';
import 'package:chatbot/chat_screen/models/content.dart';
import 'package:chatbot/chat_screen/models/list_model.dart';
import 'package:chatbot/chat_screen/models/message.dart';
import 'package:chatbot/chat_screen/models/user.dart';
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
  List<Content> dummyContent = [];

  @override
  void initState() {
    super.initState();

    dummyContent = Dummy.initialize(_textMessageSubmitted);

    _list = ListModel<Content>(
      listKey: _listKey,
      initialItems: _initialContent,
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      _list.insert(
          0,
          Message(
            text:
                'Hallo ${Constants.USERNAME},\nIch bin ${Constants.CHATBOT_NAME} 🙂',
            isUser: false,
            isNext: false,
            time: DateTime.now()
          ));
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      _list.first.time = null;
      _list.insert(
          0,
          Message(
            text:
                'Von mir bekommst du die aktuellsten Nachrichten und Informationen über den Aktienkurs.',
            isUser: false,
            isNext: true,
            time: DateTime.now()
          ));
    });

    Future.delayed(const Duration(milliseconds: 3000), () {
      _list.first.time = null;
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

    setState(() {
      _list.insert(0, userMessage);
    });

    _submitBotMessages();
  }

  _submitBotMessages() {
    // Get Chatbot Dummy Messages
    List<Content> botMessages = [];
    int counter = 0;

    for (int i = 0; i < dummyContent.length; i++) {
      if (dummyContent[i] is User) {
        break;
      }
      botMessages.add(dummyContent[i]);
      counter++;
    }

    botMessages.first.time = DateTime.now();

    for (int i = 0; i <= counter; i++) {
      dummyContent.removeAt(0);
    }

    for (int i = 0; i < botMessages.length; i++) {
      int minimum = 1000 + i * 1000;

      Future.delayed(Duration(milliseconds: minimum), () {
        setState(() {
          _list.first.time = null;
          botMessages[i].time = DateTime.now();
          _list.insert(0, botMessages[i]);
        });
      });
    }
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
            Image.asset(
              'images/avatar.png',
              height: 40,
              width: 40,
            ),
            Container(
              width: 5,
            ),
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
