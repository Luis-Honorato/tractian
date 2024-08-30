import 'package:flutter/material.dart';
import 'package:tractian/node/presentation/pages/home_page.dart';
import 'package:tractian/theme/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tractian',
      theme: TractianTheme.theme,
      home: const HomePage(),
    );
  }
}
