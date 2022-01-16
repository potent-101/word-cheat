
import 'package:flutter/material.dart';
import 'package:word_cheat/routes/home_page.dart';

class RouteGenerator {

  static const homePage = '/';


  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case homePage :
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );

      default:
        throw const FormatException("Route not found");
    }
  }

}
class RouteException implements Exception {
  final String message;
  const RouteException( this.message);
}