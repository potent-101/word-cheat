
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_cheat/models/connections/enums/connection_enum.dart';
import 'package:word_cheat/models/word_generator.dart';
import 'package:word_cheat/widgets/custom_dialog.dart';
import 'package:word_cheat/widgets/word_listview.dart';

import '../main.dart';

class HomePage extends StatefulWidget{


  HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final tabs = const [
    'Three',
    'Four',
    'Five',
    'Six'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    final wordgen = context.watch<WordGen>();
    final lolow = wordgen.currentLolow;


    final lists = lolow.isEmpty ? List.generate(4, (index) =>
        WordListView(const [])) : <WordListView>[
      WordListView(lolow[0]),
      WordListView(lolow[1]),
      WordListView(lolow[2]),
      WordListView(lolow[3])
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(

        appBar: AppBar(
          elevation: 1,
          titleTextStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xffFF6263)
          ),
          backgroundColor: Colors.white,
          title: const Text("word cheat"),
        actions:  [
           Padding(
             padding: const EdgeInsets.only(right:16.0),
             child: IconButton(
               onPressed: (){
                 // show the dialog
                 showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return const CustomDialog();
                   },
                 );

               },
               icon: const Icon(Icons.search),
             ),
           ),



        ],
        automaticallyImplyLeading: false,
        bottom:PreferredSize(
           preferredSize: const Size.fromHeight(48),
            child: Theme(
              data: ThemeData(
              highlightColor: Colors.transparent,
               splashColor: Colors.transparent,
    ),
               child: TabBar(
                 indicatorSize: TabBarIndicatorSize.tab,
                 indicatorPadding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                  indicator: BoxDecoration(
                   borderRadius: BorderRadius.circular(50),
                   color: const Color(0xffFF6263)
          ),
                labelColor: Colors.white,
                 unselectedLabelColor: const Color(0xffFF6263),
                labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              fontSize: 18
          ),
                   indicatorColor: Colors.white,
          // isScrollable: true,
          tabs: [
                  for (final tab in tabs) Tab(text: tab),
          ],
        ),

        )
        )
        ),
        body:  Consumer(
          builder:(context,provider,listviews){
            return TabBarView(
              children:[
                ...lists
              ] ,
            );
          }
        )

      ),
    );
  }
}