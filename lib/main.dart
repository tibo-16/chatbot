import 'package:chatbot/bubble.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: BubbleScreen());
  }
}

class BubbleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            verticalDirection: VerticalDirection.up,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Bubble(
                message: 'Danke, Bro 💪🏻',
                time: DateTime.now(),
                online: true,
                isMe: true,
                isNext: false,
              ),
              Bubble(
                message: 'Cooler Text, Bro!',
                time: DateTime.now(),
                online: true,
                isMe: false,
                isNext: false,
              ),
              Bubble(
                message:
                    'Dies soll ein ziemlich langer Text sein um zu überprüfen, wie sich die Bubble verhält.\nUnd weiter gehts mit so einem langen Text hahahaha.',
                time: DateTime.now(),
                online: true,
                isMe: true,
                isNext: true,
              ),
              Bubble(
                message: 'I\'ve told you so dude!',
                online: true,
                isMe: true,
                isNext: false,
              ),
              Bubble(
                message: 'Nice one, Flutter is awesome',
                time: DateTime.now(),
                online: true,
                isMe: false,
                isNext: false,
              ),
              Bubble(
                message: 'Whatsapp like bubble talk',
                time: DateTime.now(),
                online: true,
                isMe: true,
                isNext: true,
              ),
              Bubble(
                message: 'Hi there 🖐🏻, this is a message',
                online: true,
                isMe: true,
                isNext: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
