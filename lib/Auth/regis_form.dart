import 'package:flutter/material.dart';
import 'package:task_tamer/Auth/form_text.dart';
import 'package:task_tamer/Auth/sign_in_form.dart';
import 'package:task_tamer/Auth/supa_auth_class.dart';
import 'package:task_tamer/Auth/validators_class.dart';
import 'package:task_tamer/home_page.dart';

class RegisForm extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController mailControl = TextEditingController();
  final TextEditingController passControl = TextEditingController();
  final TextEditingController checkPassControl = TextEditingController();
  final String emailHint = 'Email';
  final String passHint = 'Password';
  final String passControlHint = 'Confirm password';

  RegisForm({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> textFields = [
      FormText(
        control: mailControl,
        hint: emailHint,
        validator: ValidatorsClass().emailValidator,
        esContra: false,
      ),
      FormText(
        control: passControl,
        hint: passHint,
        validator: ValidatorsClass().passValidator,
        esContra: true,
      ),
      FormText(
        control: checkPassControl,
        hint: passControlHint,
        validator: ValidatorsClass().passValidator,
        esContra: true,
      ),
    ];
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children:
                <Widget>[
                  Text(
                    'Create an account',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ] +
                textFields +
                [
                  FilledButton(
                    onPressed: () async {
                      if (!_key.currentState!.validate()) {
                        return;
                      } else {
                        if (passControl.text != checkPassControl.text) {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              content: Text('Passwords dont match'),
                              actions: [
                                FilledButton(
                                  onPressed: () => ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentMaterialBanner(),
                                  child: Text('Ok'),
                                ),
                              ],
                            ),
                          );
                          return;
                        }
                        await SupaAuthClass().registrarUsuario(
                          mailControl.text,
                          passControl.text,
                        );
                        if (!context.mounted) {
                          return;
                        }
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignInForm()),
                        ),
                        child: Text('Sign in'),
                      ),
                    ],
                  ),
                ],
          ),
        ),
      ),
    );
  }
}
