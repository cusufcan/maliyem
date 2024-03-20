import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/page/base/base_view.dart';
import 'package:gelir_gider_takibi/page/onboarding/onboarding_base_view.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:provider/provider.dart';

import '../../constant/index.dart';

part 'splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends _SplashViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(BaseString.icPath),
      ),
    );
  }
}
