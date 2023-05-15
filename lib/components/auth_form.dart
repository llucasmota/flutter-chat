import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    widget.onSubmit(_authFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                if (_authFormData.isSignup)
                  TextFormField(
                    key: const ValueKey('name'),
                    initialValue: _authFormData.name,
                    onChanged: (name) => _authFormData.name = name,
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                    ),
                    validator: (nameValue) {
                      final name = nameValue ?? '';
                      if (name.trim().length < 5) {
                        return 'Nome de ter no mínimo 5 caracteres';
                      }
                      return null;
                    },
                  ),
                TextFormField(
                  key: const ValueKey('email'),
                  initialValue: _authFormData.email,
                  onChanged: (email) => _authFormData.email = email,
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                  validator: (emailValue) {
                    final email = emailValue ?? '';
                    if (!email.contains('@')) {
                      return 'Email informado não é válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  initialValue: _authFormData.password,
                  onChanged: (password) => _authFormData.password = password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Senha'),
                  ),
                  validator: (passwordValue) {
                    final password = passwordValue ?? '';
                    if (password.trim().length < 6) {
                      return 'Senha inválida';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_authFormData.isLogin ? 'Entrar' : 'Cadastrar'),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _authFormData.toggleAuthMode();
                      });
                    },
                    child: Text(_authFormData.isLogin
                        ? 'Criar uma nova conta?'
                        : 'Já possui conta?'))
              ],
            )),
      ),
    );
  }
}
