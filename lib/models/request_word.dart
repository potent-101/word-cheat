
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:word_cheat/models/http_request.dart';

class RequestWord implements HTTPRequest<String>{

  String  word = '';

  RequestWord({required this.word});

  @override
  Future<List<String>> execute() async{
    List<String> results = [];
    const authoriy = 'api.dictionaryapi.dev';
    final path = '/api/v2/entries/en/$word';
    final response = await http.get(Uri.https(authoriy,path));
   var returnWord = '';

   if(response.statusCode == 200){

     RegExp exp = RegExp(r'"definition"\:"([^"]*)');
     String str = response.body;

     if(str.contains(exp)){
       Iterable<RegExpMatch> matches = exp.allMatches(str);

       for (var element in matches) {
         String? item = element.group(1);
         results.add(item!);
       }

     }else{
       results = [];
     }


   }else{

     throw(Exception('something went wrong'));

   }


   return results;
    }

}