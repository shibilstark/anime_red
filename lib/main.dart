import 'package:flutter/material.dart';

import 'config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BuildConfig.instantiate(
    environment: EvnType.dev,
    appName: "AnimeRed",
    baseUrl: "http://localhost:3000/",
    requestTimeOut: const Duration(seconds: 15),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
