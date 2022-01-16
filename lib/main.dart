import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle, rootBundle;
import 'package:provider/provider.dart';
import 'package:word_cheat/models/word_generator.dart';
import 'package:word_cheat/route.dart';
import 'package:word_cheat/theme.dart';

import 'models/connections/enums/connection_enum.dart';
import 'models/connections/service/connectivity_service.dart';
import 'models/text.dart';

void main(){
  SystemChrome.setSystemUIOverlayStyle(
       const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light
      )
  );
  runApp(WordCheat());


  }

final GlobalKey<ScaffoldMessengerState> snackbarKey =
GlobalKey<ScaffoldMessengerState>();

class WordCheat extends StatelessWidget {
   WordCheat();

   WordGen wordGen = WordGen();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
             ChangeNotifierProvider<WordGen>(create: (_) => WordGen()),
    StreamProvider<ConnectivityStatus>.value(
        value: ConnectivityService().connectionStatusController.stream,
        initialData:  ConnectivityStatus.offline)
    ],
    child : MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        colorScheme: colorScheme(),
      ),
      onGenerateTitle: (context) => "RandomApp",
      initialRoute: RouteGenerator.homePage,
      onGenerateRoute: RouteGenerator.generateRoute,

      debugShowCheckedModeBanner: false,

    ));
  }
}

