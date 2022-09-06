import 'package:flutter/material.dart' show BuildContext;
import 'package:mobxtestingdemo/auth/auth_error.dart';
import 'package:mobxtestingdemo/dialog/generic_dialog.dart';

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}){
  return showGenericDialog<void>(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionBuilder: () =>{
      'OK' : true,
    },
  );
}