import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list_observable.dart';
import 'package:shop/pages/pages.dart';
import 'package:shop/utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductListObservable>(
      create: (_) => ProductListObservable(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: ProductOverviewPage(),
        routes: {AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage()},

        // ==== THEMAS
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
          fontFamily: 'Lato',

          //* ================= textTheme ======================
          //todo par é variavel com textscale, todo impar é fixo
          textTheme: TextTheme(
            button: TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
                color: Colors.white),
            caption: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            subtitle1: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            subtitle2: TextStyle(
                fontSize: 14.0 * MediaQuery.textScaleFactorOf(context),
                fontStyle: FontStyle.italic),
            bodyText2: TextStyle(
                fontSize: 14.0 * MediaQuery.textScaleFactorOf(context),
                fontFamily: 'OpenSans'),
            bodyText1: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(
                fontSize: 10.0 * MediaQuery.textScaleFactorOf(context),
                fontStyle: FontStyle.normal),
            headline3: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            headline4: TextStyle(
                fontSize: 12.0 * MediaQuery.textScaleFactorOf(context),
                fontStyle: FontStyle.italic),
            headline5: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            headline6: TextStyle(
                fontSize: 14.0 * MediaQuery.textScaleFactorOf(context),
                fontStyle: FontStyle.italic),
            overline: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          ),
          //fontSize: 18 * MediaQuery.textScaleFactorOf(context)
          //mudando de tema dark/light : https://www.youtube.com/watch?v=SEXlV2t8Kn4
          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          // Define the default brightness and colors.

          //* ================= colorTheme Gerais ======================
          primaryColor: Colors.purple,
          //accentColor: Colors.red,
          secondaryHeaderColor: Colors.deepOrange,
          errorColor: Colors.redAccent,

          //* ================= colorTheme Especificas ======================

          buttonBarTheme: ButtonBarThemeData(),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            primary: Colors.red,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            textStyle: Theme.of(context).textTheme.headline6,
          )),

          //* ================== Brilho Theme =====================
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
