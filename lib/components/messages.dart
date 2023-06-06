import 'package:chat/components/messages_bubble.dart';
import 'package:chat/core/models/chat_messages.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_mock_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatMockService().messageStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Sem mensagens. Vamos conversar?'),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, index) {
              return MessagesBubble(
                  key: ValueKey(msgs[index].id),
                  message: msgs[index],
                  belongsToCurrentUser: currentUser?.id == msgs[index].userId);
            },
          );
        }
      },
    );
  }
}
