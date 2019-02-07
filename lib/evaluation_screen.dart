import 'package:chatbot/constants.dart';
import 'package:flutter/material.dart';

class EvaluationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  List<bool> highlightedStars = [false, false, false, false, false];
  bool upSelected = false;
  bool downSelected = false;

  _showStart() {
    Navigator.pop(context);
  }

  _highlightStars(int index) {
    List<bool> newHighlights = [false, false, false, false, false];

    for (int i = 0; i <= index; i++) {
      newHighlights[i] = true;
    }

    setState(() {
      highlightedStars = newHighlights;
    });
  }

  _selectThumb(bool up) {
    if (up) {
      setState(() {
        upSelected = true;
        downSelected = false;
      });
    } else {
      setState(() {
        upSelected = false;
        downSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Danke!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 30,
              ),
              Text(
                'Wie hat dir der Chat mit Simbo gefallen?',
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                        highlightedStars[0] ? Icons.star : Icons.star_border),
                    onPressed: () => _highlightStars(0),
                    iconSize: 36,
                    color: Constants.DARK_BLUE,
                  ),
                  IconButton(
                    icon: Icon(
                        highlightedStars[1] ? Icons.star : Icons.star_border),
                    onPressed: () => _highlightStars(1),
                    iconSize: 36,
                    color: Constants.DARK_BLUE,
                  ),
                  IconButton(
                    icon: Icon(
                        highlightedStars[2] ? Icons.star : Icons.star_border),
                    onPressed: () => _highlightStars(2),
                    iconSize: 36,
                    color: Constants.DARK_BLUE,
                  ),
                  IconButton(
                    icon: Icon(
                        highlightedStars[3] ? Icons.star : Icons.star_border),
                    onPressed: () => _highlightStars(3),
                    iconSize: 36,
                    color: Constants.DARK_BLUE,
                  ),
                  IconButton(
                    icon: Icon(
                        highlightedStars[4] ? Icons.star : Icons.star_border),
                    onPressed: () => _highlightStars(4),
                    iconSize: 36,
                    color: Constants.DARK_BLUE,
                  ),
                ],
              ),
              Container(
                height: 30,
              ),
              Text(
                'Konnte Simbo alle deine Frage beantworten?',
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () => _selectThumb(true),
                    iconSize: 36,
                    color: upSelected ? Constants.DARK_BLUE : Colors.white,
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_down),
                    onPressed: () => _selectThumb(false),
                    iconSize: 36,
                    color: downSelected ? Constants.DARK_BLUE : Colors.white,
                  ),
                ],
              ),
              Container(
                height: 40,
              ),
              OutlineButton(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: _showStart,
                shape: CircleBorder(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
