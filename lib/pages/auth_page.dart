import 'dart:async';

import 'package:chat/components/auth_form.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    print(formData.email);

    try {
      setState(() => isLoading = true);
      if (formData.isLogin) {
        await AuthMockService().login(formData.email, formData.password);
      } else {
        await AuthMockService().signup(
            formData.name, formData.email, formData.password, formData.image);
      }
    } catch (error) {
      // Tratar erro
    } finally {
      Timer(const Duration(seconds: 3), () {
        setState(() {
          isLoading = false;
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (isLoading)
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: const Center(child: CircularProgressIndicator()),
            )
        ],
      ),
    );
  }
}
