import 'package:chatbot/chat_screen/chat_screen.dart';
import 'package:chatbot/constants.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  _showChat() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            maintainState: false,
            fullscreenDialog: false,
            builder: (context) => ChatScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height * 0.25;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, Constants.SIEMENS_COLOR],
              begin: Alignment.topLeft,
              end: Alignment.centerRight),
        ),
        child: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/avatar.png',
                height: size,
                width: size,
              ),
              Text(
                Constants.CHATBOT_NAME,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
              Text(
                'Nachrichten und Aktienkurse',
                style: TextStyle(
                    color: Colors.white70, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: Text('Chat starten'),
                onPressed: _showChat,
                textColor: Colors.white,
                color: Constants.DARK_BLUE,
              )
            ],
          ),
        ),
      ),
    );
  }
}
