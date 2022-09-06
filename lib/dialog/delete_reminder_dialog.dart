import 'package:flutter/material.dart' show BuildContext;
import 'package:mobxtestingdemo/dialog/generic_dialog.dart';

Future<bool> showDeleteReminderDialog(BuildContext context){
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete Reminder',
    content: 'Are you sure you want to delete this reminder? You cannot undo this operation!',
    optionBuilder: () =>{
      'Cancle' : false,
      'Delete' :true,
    },
  ).then((value) => value ?? false,
  );
}