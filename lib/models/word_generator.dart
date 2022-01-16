import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:word_cheat/models/text.dart';

class WordGen with ChangeNotifier{
   String _word = "sunrise";
   List<List<String>> _lolow = [];


  WordGen();

  void changeWord(String newWord){
    _word = newWord;
    _lolow = _wordGenerator(_word);
    notifyListeners();
  }

   List<List<String>> get currentLolow => _lolow;



  List<List<String>> _wordGenerator(String word) {
    List<List<String>> wordLists = [];

    List<String> three = [];
    List<String> four = [];
    List<String> five = [];
    List<String> six = [];

    word.toLowerCase();

    final lettersCountMap = _getWordMap(word);

    const ls = LineSplitter();
    ls.convert(dictionaryString()).forEach((element) {
      final currentWordMap =  _getWordMap(element);
      var canMakeWord = true;

      for(final character in currentWordMap!.keys){
        final currentWordCharCount = currentWordMap[character];
        final lettersCharCount = lettersCountMap!.containsKey(character) ?
        lettersCountMap[character] : 0;

        if(currentWordCharCount! > lettersCharCount!){
          canMakeWord = false;
          break;
        }
      }

      if(canMakeWord){
        switch(element.length){
          case 3:
            three.add(element);
            break;
          case 4:
            four.add(element);
            break;
          case 5:
            five.add(element);
            break;
          case 6:
            six.add(element);
            break;
        }
      }
    });


    return wordLists = [three,four,five,six];

  }

  Map<String,int>? _getWordMap(String word) {
    final lettersCountMap = <String,int>{};

    for(int i = 0; i<=word.length-1; i++ ){
      var currentChar = word[i];

      var count = lettersCountMap.containsKey(currentChar) ?
      lettersCountMap[currentChar] : 0;

      lettersCountMap[currentChar] = count! + 1;


    }
    return lettersCountMap;
  }
}

