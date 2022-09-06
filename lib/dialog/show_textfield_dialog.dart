import 'package:flutter/material.dart';

enum TextFieldDialogButtonType{ cancle, confirm }

typedef DialogOptionBuilder = Map<TextFieldDialogButtonType, String> Function();

late final controller = TextEditingController();

Future<String?> showTextFeildDialog({
  required BuildContext context,
  required String title,
  required String? hintText,
  required DialogOptionBuilder optionsBuilder,
  }){
  controller.clear();
  final options = optionsBuilder();
  return showDialog<String?>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(title),
          content: TextField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
            ),
          ),
          actions: options.entries.map((option) {
            return TextButton(
                onPressed: (){
                  switch(option.key){
                    case TextFieldDialogButtonType.cancle:
                      Navigator.of(context).pop();
                      break;
                    case TextFieldDialogButtonType.confirm:
                      Navigator.of(context).pop(controller.text);
                      break;}
                },
                child: Text(
                  option.value,
                ),
            );
          }).toList(),
        );
      });
}