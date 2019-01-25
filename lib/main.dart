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
                message: 'NLP WTF! 🔥',
                time: DateTime.now(),
                online: true,
                isUser: false,
                isNext: true,
                showAvatar: true,
              ),
              Bubble(
                message: 'Ich habe viel von Tay gelernt! 🤭',
                online: true,
                isUser: false,
                isNext: false,
                showAvatar: true,
              ),
              Bubble(
                message:
                    'Du bist aber nicht sehr nett...',
                time: DateTime.now(),
                online: true,
                isUser: true,
                isNext: false,
                showAvatar: false,
                username: 'Tobias Emrich',
              ),
              Bubble(
                message: 'Deine Mutter stinkt sogar auf Fotos! 😂',
                time: DateTime.now(),
                online: true,
                isUser: false,
                isNext: false,
                showAvatar: true,
              ),
              Bubble(
                message: 'Erzähl mir einen Witz.',
                time: DateTime.now(),
                online: true,
                isUser: true,
                isNext: false,
                showAvatar: false,
                username: 'Tobias Emrich',
              ),
              Bubble(
                message: 'Wie kann ich dir behilflich sein?',
                time: DateTime.now(),
                online: true,
                isUser: false,
                isNext: true,
                showAvatar: true,
              ),
              Bubble(
                message: 'Hi 🖐🏻, ich bin Robert.',
                online: true,
                isUser: false,
                isNext: false,
                showAvatar: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
