import 'package:flutter/material.dart';

part 'settings_view_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends _SettingsViewModel {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text('sa'),
    );
  }
}
