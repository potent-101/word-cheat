import 'package:flutter/material.dart';

class MeaningList extends StatelessWidget{
  List<String> meanings = [];

  MeaningList(List<String> mean,{Key? key}) : super(key: key){
    meanings = mean;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: meanings.length,
          itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text(meanings[index]),
            leading: Text('${index + 1}',
            style: const TextStyle(
              fontSize: 16,
                color: Color(0xee424d87),
              fontWeight: FontWeight.bold
            ),
            ),
          );
          }
      ),
    );
  }

}