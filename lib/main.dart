import 'package:flutter/material.dart';
import 'package:registrofinanceiro/general.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      //? Para demonstrar que eu sei mexer com themeData eu vou criar um
      //? ThemeCentral para ExpesesApp, um tema central para form do tipo darkness
      //? e passar pontualmente um estilo para texfild do tipo AzeretMono
      theme: ThemeData(
        //* ================= appBarTheme ======================
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),

        //* ================= font Family ===================
        fontFamily: 'Quicksand',

        //* ================= textTheme ======================
        textTheme: const TextTheme(
          button: TextStyle(
              fontSize: 14.0, fontStyle: FontStyle.italic, color: Colors.blue),
          caption: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          subtitle1: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          subtitle2: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'OpenSans'),
          bodyText1: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          headline3: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          headline4: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          headline5: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          headline6: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          overline: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
        ),
        //mudando de tema dark/light : https://www.youtube.com/watch?v=SEXlV2t8Kn4
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        // Define the default brightness and colors.

        //* ================= colorTheme ======================

        buttonBarTheme: ButtonBarThemeData(),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          textStyle: Theme.of(context).textTheme.headline6,
        )),

        primaryColor: Colors.red,
        //accentColor: Colors.red,

        //* ================== Brilho Theme =====================
        brightness: Brightness.light,
      ),
    );
  }
}
