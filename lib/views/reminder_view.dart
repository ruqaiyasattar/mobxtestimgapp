import 'package:flutter/material.dart';
import 'package:mobxtestingdemo/dialog/show_textfield_dialog.dart';
import 'package:mobxtestingdemo/state/app_state.dart';
import 'package:mobxtestingdemo/views/main_popup_menu_button.dart';
import 'package:mobxtestingdemo/views/reminders_list_view.dart';
import 'package:provider/provider.dart';

class RemindersView extends StatelessWidget {
  const RemindersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reminders',
        ),
        actions: [
          IconButton(
            onPressed: ()async{
              final reminderText = await showTextFeildDialog(
                  context: context,
                  title: 'what do you want me to remind you about?',
                  hintText: 'Enter your remindetext here..r',
                  optionsBuilder: () => {
                    TextFieldDialogButtonType.cancle : 'cancle',
                    TextFieldDialogButtonType.confirm : 'Save',
                  }
              );
              if (reminderText == null) {
                return ;
              }
              context.read<AppState>().createReminder(
                reminderText,
              );
            },
            icon:const Icon(
              Icons.add,
            ),
          ),
          const MainPopupMenuButton(),
        ],
      ),
      body: const RemindersListView(),
    );
  }
}


