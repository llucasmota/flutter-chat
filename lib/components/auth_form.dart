import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                label: Text('Nome'),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text('E-mail'),
              ),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Senha'),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Entrar')),
            TextButton(onPressed: () {}, child: Text('Criar uma nova conta?'))
          ],
        )),
      ),
    );
  }
}
