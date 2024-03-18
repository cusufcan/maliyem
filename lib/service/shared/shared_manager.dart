import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  late final SharedPreferences manager;

  Future<void> init() async {
    manager = await SharedPreferences.getInstance();
    // await manager.clear();
  }

  Future<void> setString(SharedEnum key, String value) async {
    await manager.setString(key.name, value);
  }

  String? getString(SharedEnum key) {
    return manager.getString(key.name);
  }

  bool hasData(SharedEnum key) {
    return manager.containsKey(key.name);
  }
}
