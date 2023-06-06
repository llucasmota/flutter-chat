import 'dart:math';

import 'package:chat/core/models/chat_messages.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'dart:async';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    // ChatMessage(
    //     id: '1',
    //     text: 'Bom dia',
    //     createdAt: DateTime.now(),
    //     userId: '1',
    //     userName: 'John Doe',
    //     userImageURL: 'assets/images/avatar.png'),
    // ChatMessage(
    //     id: '2',
    //     text: 'Fala, parça',
    //     createdAt: DateTime.now(),
    //     userId: '2',
    //     userName: 'Atendente',
    //     userImageURL: 'assets/images/avatar.png'),
    // ChatMessage(
    //     id: '3',
    //     text: 'Em que posso ajudar???',
    //     createdAt: DateTime.now(),
    //     userId: '2',
    //     userName: 'Atendente',
    //     userImageURL: 'assets/images/avatar.png'),
    // ChatMessage(
    //     id: '4',
    //     text: 'Me dê dinheilo',
    //     createdAt: DateTime.now(),
    //     userId: '1',
    //     userName: 'John Doe',
    //     userImageURL: 'assets/images/avatar.png'),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });
  @override
  Stream<List<ChatMessage>> messageStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
        id: Random().nextDouble().toString(),
        text: text,
        createdAt: DateTime.now(),
        userId: user.id,
        userName: user.name,
        userImageURL: user.imageUrl);
    _msgs.add(newMessage);
    _controller?.add(_msgs.reversed.toList());

    return newMessage;
  }
}
