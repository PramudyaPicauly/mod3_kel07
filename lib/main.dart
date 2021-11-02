import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mod3_kel07/screens/home.dart'; 
import 'package:mod3_kel07/screens/detail.dart'; 

void main() async {
  runApp(const AnimeApp());
} 

class AnimeApp extends StatelessWidget {
  const AnimeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime app',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}