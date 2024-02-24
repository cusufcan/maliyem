import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/page/splash/splash_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.light(),
      home: const SplashView(),
    );
  }
}
