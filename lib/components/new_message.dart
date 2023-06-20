import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String _message = '';

  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      final msg = await ChatService().save(_message, user);
      print('mensagem enviada ${msg?.id}');
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (message) => setState(() {
              _message = message;
            }),
            onSubmitted: (msg) {
              if (msg.trim().isNotEmpty) {
                _sendMessage();
              }
            },
            decoration: const InputDecoration(labelText: 'Enviar mensagem...'),
          ),
        ),
        IconButton(
          onPressed: _message.trim().isEmpty ? null : _sendMessage,
          icon: const Icon(Icons.send),
        )
      ],
    );
  }
}
