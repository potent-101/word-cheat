import 'package:flutter/material.dart';
import 'package:word_cheat/models/request_word.dart';
import 'package:word_cheat/widgets/meaning_listview.dart';

String _word = '';

class WordMeaning extends StatefulWidget{
   WordMeaning(String word ,{Key? key}) : super(key: key){
     _word = word;
   }

  @override
  State<WordMeaning> createState() => _WordMeaningState();
}

class _WordMeaningState extends State<WordMeaning> {
  @override
  Widget build(BuildContext context) {
    return  SimpleDialog(
      title: Text('meaning of $_word',
          style: const TextStyle(
          fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xee424d87),
      ),
      ),
      children: [
        FutureBuilder<List<String>>(
          future: RequestWord(word: _word).execute(), // async work
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Loading....',
                    style: TextStyle(
                    fontSize: 16,
                    color: Color(0xee424d87),
                    fontWeight: FontWeight.bold
                ),
                ),
              );
              default:
                if (snapshot.hasError) {
                  return Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.error,
                          color: Color(0xffFF6263),
                          size: 50,
                        ),
                      ),
                      Text('error',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xee424d87),
                          fontWeight: FontWeight.bold
                      ),
                      ),
                    ],
                  );
                } else {
                  //print(snapshot.data.toString);
                  return snapshot.data!.isNotEmpty ?
                  MeaningList(snapshot.data!):
                  const Text('no meaning for this word');
                }
            }
          },
        ),

      ],
    );
  }
}