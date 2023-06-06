import 'dart:io';

import 'package:chat/core/models/chat_messages.dart';
import 'package:flutter/material.dart';

class MessagesBubble extends StatelessWidget {
  static const _defaultImage = 'assets/images/avatar.png';
  final ChatMessage message;
  final bool belongsToCurrentUser;
  const MessagesBubble(
      {Key? key, required this.message, required this.belongsToCurrentUser})
      : super(key: key);

  Widget _showUSerImage(String imageURL) {
    ImageProvider? provider;

    final uri = Uri.parse(imageURL);

    if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      //imagem que está no storage
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
        backgroundColor: Colors.pinkAccent, backgroundImage: provider);
  }

  BorderRadiusGeometry _borderRules() {
    return BorderRadius.only(
        topLeft: const Radius.circular(12),
        topRight: const Radius.circular(12),
        bottomLeft: belongsToCurrentUser
            ? const Radius.circular(12)
            : const Radius.circular(0),
        bottomRight: belongsToCurrentUser
            ? const Radius.circular(0)
            : const Radius.circular(12));
  }

  Color _colorTextRules() {
    return belongsToCurrentUser ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              width: 180,
              decoration: BoxDecoration(
                color: belongsToCurrentUser
                    ? Colors.grey.shade300
                    : Theme.of(context).colorScheme.primary,
                borderRadius: _borderRules(),
              ),
              child: Column(
                crossAxisAlignment: belongsToCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: _colorTextRules()),
                  ),
                  Text(
                    message.text,
                    style: TextStyle(color: _colorTextRules()),
                    textAlign:
                        belongsToCurrentUser ? TextAlign.right : TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: 0,
            left: belongsToCurrentUser ? 200 : null,
            right: belongsToCurrentUser ? null : 200,
            child: _showUSerImage(message.userImageURL)),
      ],
    );
  }
}
