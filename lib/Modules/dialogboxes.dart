import 'package:flutter/material.dart';

class ShowDialogBox{
  //dialog box
  static warningdialogbox(context,String message){
    return showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                child: const Text("ON"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
