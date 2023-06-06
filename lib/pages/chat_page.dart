import 'package:chat/components/messages.dart';
import 'package:chat/components/new_message.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cod3r Chat'),
          actions: [
            DropdownButton(
              padding: const EdgeInsets.only(top: 10),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.secondary,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: const Row(
                      children: [
                        Icon(Icons.exit_to_app, color: Colors.blueGrey),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sair',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ],
        ),
        body: const SafeArea(
          child: Column(
            children: [
              Expanded(child: Messages()),
              NewMessages(),
            ],
          ),
        ));
  }
}
