import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobxtestingdemo/extensions/if_debugging.dart';
import 'package:mobxtestingdemo/state/app_state.dart';
import 'package:provider/provider.dart';

class RegisterView extends HookWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: 'abc@gmail.com'.ifDebugging);
    final passwordController = useTextEditingController(text: 'abc@gmail'.ifDebugging);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardAppearance: Brightness.dark,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email here...',
              ),
            ),

            TextField(
              controller: passwordController,
              keyboardAppearance: Brightness.dark,
              decoration: const InputDecoration(
                hintText: 'Enter your password here...',
              ),
              obscureText: true,
              obscuringCharacter: '*',
            ),
            TextButton(
              onPressed: (){
                final email = emailController.text;
                final password = passwordController.text;
                context.read<AppState>().register(email: email, password: password);
              },
              child: const Text(
                'Register',
              ),
            ),
            TextButton(
              onPressed: (){
                context.read<AppState>().goTo(
                    AppScreen.login,
                );
              },
              child: const Text(
                'Already registered? Login here!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
