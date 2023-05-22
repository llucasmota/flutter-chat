import 'package:chat/pages/auth_or_app_page.dart';
import 'package:chat/pages/auth_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.blue),
          textTheme: const TextTheme(
              headlineSmall: TextStyle(color: Colors.white, fontSize: 18))),
      home: AuthOrAppPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
