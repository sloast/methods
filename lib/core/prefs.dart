import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<Prefs> create() async {
    return Prefs(await .create(cacheOptions: .new()));
  }

  const Prefs(this.prefs);

  final SharedPreferencesWithCache prefs;

  bool get manualFinish => prefs.getBool('manualFinish') ?? false;
  set manualFinish(bool value) => prefs.setBool('manualFinish', value);

  bool get hideTreble => prefs.getBool('hideTreble') ?? false;
  set hideTreble(bool value) => prefs.setBool('hideTreble', value);
}
