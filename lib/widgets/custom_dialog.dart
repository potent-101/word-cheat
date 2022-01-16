import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:word_cheat/models/word_generator.dart';

class CustomDialog extends StatefulWidget{
  const CustomDialog({Key? key}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool _validate = false;
  late TextEditingController myController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wordgen = context.watch<WordGen>();
    return Form(
      key: formKey,
      child: SimpleDialog(
        title: const Text(
          'Enter Characters',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xffFF6263),
          ),
        ),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20,24,20,24),
                child: Theme(
                  data: ThemeData(
                    primaryColor: const Color(0xffFF6263),

                  ),
                  child: TextFormField(
                    controller: myController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }else if(RegExp(r'![a-z A-Z]{3,10}').hasMatch(value)){
                        return 'enter valid characters';
                      }
                      return null;
                    },
                    inputFormatters: [
                      CaseFormatting(),
                      FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z]+")),
                    ],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xee424d87),
                    ),
                    decoration: const InputDecoration(
                      // isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xee424d87),
                            width: 2,
                          )
                      ),
                    ),


                  ),
                ),
              ),
              ButtonTheme(
                child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(240,40),
                      primary: const Color(0xffFF6263),
                    ),
                    onPressed: (){
                      if (formKey.currentState!.validate()) {


                        Future.delayed(const Duration(milliseconds: 500), () {

                         wordgen.changeWord(myController.text);
                          Navigator.pop(context);


                        });

                        setState(() {

                          _validate = true;

                        });
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        //
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('Processing Data')),
                        // );
                      }




                    }, child: !_validate ? const Text('generate',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ) : const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CaseFormatting extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text,
        selection: newValue.selection
    );
  }
}