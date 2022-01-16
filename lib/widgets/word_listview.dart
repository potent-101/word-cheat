import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:word_cheat/models/connections/enums/connection_enum.dart';
import 'package:word_cheat/models/word_generator.dart';
import 'package:provider/provider.dart';
import 'package:word_cheat/widgets/word_meaning_dialog.dart';

import '../main.dart';

class WordListView extends StatelessWidget{
  List<String> low = [];



   WordListView(List<String> lows, {Key? key}) : super(key: key) {
     low = lows;

   }



  @override
  Widget build(BuildContext context) {

    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    return low.isEmpty ? const Center(
      child: Text('No Generated Words',
      style: TextStyle(
        fontSize: 18,
        color: Color(0xee424d87),
        fontWeight: FontWeight.bold,
      ),
      ),
    ) : Container(
      color: Colors.white,
      child: Expanded(
        child: CupertinoScrollbar(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 8),
            itemCount: low.length,
              itemBuilder:(BuildContext context,int index){
                return GestureDetector(

                  onTap: ()async{

                    const snackBar = SnackBar(
                      duration: Duration(milliseconds: 300),
                      backgroundColor: Color(0xff26262b),
                      behavior: SnackBarBehavior.floating,
                      content: Text('not connected'),

                    );

                    if (connectionStatus == ConnectivityStatus.offline) {

                      snackbarKey.currentState?.showSnackBar(snackBar);


                    }else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return WordMeaning(low[index]);
                        },
                      );



                    }

                  },

                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(low[index],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xee424d87),
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      decoration: BoxDecoration(
                        border:Border.all(color: const Color(0x33000000)),
                      ),
                    ),
                  ),
                );
                 }
              ),
        ),
      ),
    );

  }
}