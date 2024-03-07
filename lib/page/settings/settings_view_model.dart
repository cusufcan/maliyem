part of 'settings_view.dart';

abstract class _SettingsViewModel extends State<SettingsView> {
  int x = 0;
  void increment() {
    setState(() {
      x++;
    });
  }
}
