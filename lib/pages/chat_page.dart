import 'package:chat/components/messages.dart';
import 'package:chat/components/new_message.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:chat/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cod3r Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
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
          ),
          Stack(children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const NotificationPage(),
                ));
              },
              icon: const Icon(
                Icons.notifications,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                backgroundColor: Colors.red.shade800,
                maxRadius: 10,
                child: Text(
                  '${Provider.of<ChatNotificationService>(context).itemsCount}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
          ])
        ],
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
