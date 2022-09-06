import 'package:flutter/material.dart';
import 'package:mobxtestingdemo/dialog/delet_account_dialog.dart';
import 'package:mobxtestingdemo/dialog/logout_dialog.dart';
import 'package:mobxtestingdemo/state/app_state.dart';
import 'package:provider/provider.dart';

enum MenuAction { logout, deleteAccount }

class MainPopupMenuButton extends StatelessWidget {
  const MainPopupMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
        onSelected: (value) async {
          switch(value){
            case MenuAction.logout:
              final shouldLogout = await showLogoutDialog(context);
              if (shouldLogout) {
                context.read<AppState>().logOut();
              }
              break;
            case MenuAction.deleteAccount:
              final shouldDeleteAccount = await showDeleteAccountDialog(context);
              if (shouldDeleteAccount) {
                context.read<AppState>().deleteAccount();
              }
              break;
          }
        },
        itemBuilder: (context){
          return [
            const PopupMenuItem<MenuAction>(
              value: MenuAction.logout,
              child: Text('Log out',),
            ),
            const PopupMenuItem<MenuAction>(
              value: MenuAction.deleteAccount,
              child: Text('Delete Account'),
            ),
      ];
    });
  }
}
