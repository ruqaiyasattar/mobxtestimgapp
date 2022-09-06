import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobxtestingdemo/dialog/show_auth_error.dart';
import 'package:mobxtestingdemo/loading/loading_screen.dart';
import 'package:mobxtestingdemo/state/app_state.dart';
import 'package:mobxtestingdemo/views/login_view.dart';
import 'package:mobxtestingdemo/views/registers_view.dart';
import 'package:mobxtestingdemo/views/reminder_view.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    Provider(
        create: (_) => AppState()..initialize(),
        child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: ReactionBuilder(
        builder: (context){
          return autorun((_) {
            //handle loading screen
            final isLoading = context.read<AppState>().isLoading;
            if (isLoading) {
              LoadingScreen.instance().show(
                  context: context,
                  text: 'Loading...',
              );
            }  else {
              LoadingScreen.instance().hide();
            }

            final authError = context.read<AppState>().authError;
            if (authError != null) {
              showAuthError(
                  authError: authError,
                  context: context,
              );
            }
          });
        },
        child: Observer(
          name: 'CurrentScreen',
          builder: (context){
            switch(context.read<AppState>().currentScreen){
              case AppScreen.login:
                return const LoginView();
              case AppScreen.register:
                return const RegisterView();
              case AppScreen.reminders:
                return const RemindersView();
            }
          },
        ),
      ),
    );
  }
}