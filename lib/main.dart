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

class Bubble extends StatelessWidget {
  Bubble({this.message, this.time, this.delivered, this.isMe});

  final String message, time;
  final delivered, isMe;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.greenAccent.shade100 : Colors.white;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final icon = delivered ? Icons.done_all : Icons.done;
    final radius = isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0))
        : BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: Text(message),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(time,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                        )),
                    SizedBox(width: 3.0),
                    Icon(
                      icon,
                      size: 12.0,
                      color: Colors.black38,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Bubble(
                message: 'Hi there 🖐🏻, this is a message',
                time: '12:00',
                delivered: true,
                isMe: true,
              ),
              Bubble(
                message: 'Whatsapp like bubble talk',
                time: '12:01',
                delivered: true,
                isMe: true,
              ),
              Bubble(
                message: 'Nice one, Flutter is awesome',
                time: '12:00',
                delivered: true,
                isMe: false,
              ),
              Bubble(
                message: 'I\'ve told you so dude!',
                time: '12:00',
                delivered: true,
                isMe: true,
              ),
              Bubble(
                message:
                    'Dies soll ein ziemlich langer Text sein um zu überprüfen, wie sich die Bubble verhält.\nUnd weiter gehts mit so einem langen Text hahahaha.',
                time: '12:00',
                delivered: false,
                isMe: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
