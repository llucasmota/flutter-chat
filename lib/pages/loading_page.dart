import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 20),
          Text(
            'Carregando',
            style: TextStyle(
                color: Theme.of(context).textTheme.headlineSmall?.color,
                fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize),
          ),
        ],
      )),
    );
  }
}
