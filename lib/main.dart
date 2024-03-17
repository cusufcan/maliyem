import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/page/splash/splash_view.dart';
import 'package:gelir_gider_takibi/service/provider/accounts_dialog_model.dart';
import 'package:gelir_gider_takibi/service/provider/accounts_sheet_model.dart';
import 'package:gelir_gider_takibi/service/provider/base_model.dart';
import 'package:gelir_gider_takibi/service/provider/fab_model.dart';
import 'package:gelir_gider_takibi/service/provider/home_dialog_model.dart';
import 'package:gelir_gider_takibi/service/provider/home_sheet_model.dart';
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
        ChangeNotifierProvider(
          create: (context) => FabModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BaseModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeDialogModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeSheetModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccountsSheetModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccountsDialogModel(),
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
