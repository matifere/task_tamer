import 'package:flutter/material.dart';
import 'package:task_tamer/Auth/regis_form.dart';
import 'package:task_tamer/Auth/sign_in_form.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text('Task Tamer', style: Theme.of(context).textTheme.displayLarge),
            FilledButton(
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SignInForm())),
              child: Text('Sign In'),
            ),
            TextButton(
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => RegisForm())),
              child: Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
