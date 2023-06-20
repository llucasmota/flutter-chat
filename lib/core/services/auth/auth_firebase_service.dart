import 'package:chat/core/models/chat_user.dart';
import 'dart:io';
import 'dart:async';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebaseService implements AuthService {
  // static final Map<String, ChatUser> _users = {
  //   _defaultUser.email: _defaultUser
  // };

  static ChatUser? _currentUser;

  // static MultiStreamController<ChatUser?>? _controller;

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChages = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChages) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signup(
      String name, String email, String password, File? image) async {
    final auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (userCredential.user == null) return;

    // upload da foto
    final imageName = '${userCredential.user!.uid}.jpg';
    final imageUrl = await _uploadUserImage(image, imageName);

    // 2 atualizar atributos do usuário
    await userCredential.user?.updateDisplayName(name);
    await userCredential.user?.updatePhotoURL(imageUrl);

    // 3. passo opcional: salvar usuário no banco de dados
    await _saveChatUser(_toChatUser(userCredential.user!, imageUrl));
  }

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;
    final storage = FirebaseStorage.instance;

    /// .child('user-umages') -> cria uma pasta com esse nome no bucket
    final imageRef = storage.ref().child('user-images').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  static ChatUser _toChatUser(User user, [String? imageURL]) {
    return ChatUser(
      id: user.uid,
      email: user.email!,
      name: user.displayName ?? user.email!.split('@')[0],
      imageUrl: imageURL ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set(
        {'name': user.name, 'email': user.email, 'imageURL': user.imageUrl});
  }
}
