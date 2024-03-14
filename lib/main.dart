import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/page/splash/splash_view.dart';
import 'package:gelir_gider_takibi/service/provider/user_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.light(),
        home: const SplashView(),
      ),
    );
  }
}
