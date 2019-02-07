import 'package:chatbot/chat_screen/models/buttons.dart';
import 'package:chatbot/chat_screen/models/content.dart';
import 'package:chatbot/chat_screen/models/message.dart';
import 'package:chatbot/chat_screen/models/picture.dart';
import 'package:chatbot/chat_screen/models/user.dart';
import 'package:chatbot/constants.dart';

class Dummy {
  static List<Content> initialize(Function function) {
    return [
      Message(
          text:
              'Es ist in letzter Zeit viel passiert.\nWelche Nachrichten möchtest du sehen?',
          isNext: false,
          isUser: false),
      Buttons(texts: [
        'Aktuellste Nachrichten',
        'Beliebteste Nachrichten',
        'Nachrichten aus meinem Fachbereich'
      ], function: function, isNext: true, isUser: false),
      User(),
      Message(
          text: 'Alles klar 👍🏻\nHier ist eine der neusten Nachrichten:',
          isNext: false,
          isUser: false),
      Picture(
          file: 'images/siemens.jpg',
          message:
              '"Siemens Healthineers mit Zuversicht auf der ersten Hauptversammlung"',
          isNext: true,
          isUser: false),
      Buttons(
          texts: ['Gib mir mehr Informationen', 'Nächste Nachricht'],
          function: function,
          isNext: true,
          isUser: false),
      User(),
      Message(text: 'Mach ich gerne!', isNext: false, isUser: false),
      Message(
          text:
              'Über die Schaltfläche unten kannst du die Nachricht in deinem Browser öffnen.',
          isNext: true,
          isUser: false),
      Buttons(
          texts: ['Im Browser öffnen', 'Nächste Nachricht'],
          function: function,
          isNext: true,
          isUser: false),
      User(),
      Message(
          text: 'Leider verstehe ich deine Nachricht nicht 🙁',
          isNext: false,
          isUser: false),
      Message(
          text:
              'Ich kann dir jedoch gerne die aktuellsten Nachrichten oder Aktieninformationen zeigen 🙂',
          isNext: true,
          isUser: false),
      Message(
          text: 'Über welches Thema möchtest du mehr erfahren?',
          isNext: true,
          isUser: false),
      Buttons(
          texts: ['Nachrichten', 'Aktien'],
          function: function,
          isNext: true,
          isUser: false),
      User(),
      Message(text: 'Ok super 🙂', isNext: false, isUser: false),
      Message(
          text:
              'Willst du den aktuellen Aktienkurs oder den Verlauf der Aktie sehen?',
          isNext: true,
          isUser: false),
      Buttons(
          texts: ['Aktuellen Kurs', 'Verlauf der Aktie'],
          function: function,
          isNext: true,
          isUser: false),
      User(),
      Message(
          text:
              'Die Aktie von Siemens Healthineers liegt akutell bei ${Constants.AKTIEN_WERT}!',
          isNext: false,
          isUser: false),
      Buttons(
          texts: ['Zeig mir den Aktienverlauf', 'Anderes Thema'],
          function: function,
          isNext: true,
          isUser: false),
      User(),
      Message(
          text:
              'Ich kann dir den Verlauf der Aktie in verschiedenen Zeiträumen anzeigen.',
          isNext: false,
          isUser: false),
      Message(
          text: 'Welcher Zeitraum interessiert dich am meisten?',
          isNext: true,
          isUser: false),
      Buttons(
          texts: ['Letzten Monat', 'Letzten 6 Monate', 'Letztes Jahr'],
          function: function,
          isNext: true,
          isUser: false),
      User(),
      Message(text: 'In Ordnung!', isNext: false, isUser: false),
      Picture(
          file: 'images/kurs.png',
          message:
              'Dies ist der Verlauf der Siemens Healthineers Aktie in den letzten 6 Monate',
          isNext: true,
          isUser: false),
      Message(
          text: 'Kann ich dir sonst noch weiterhelfen? 🙂',
          isNext: true,
          isUser: false),
      User(),
      Message(text: 'Freut mich zu hören 😊', isNext: false, isUser: false),
      Message(text: 'Bis zum nächsten mal!', isNext: true, isUser: false),
      User(),
    ];
  }
}
