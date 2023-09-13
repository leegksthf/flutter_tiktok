// 해당 레포지터리는 데이터 유지와 데이터 읽는 것만 책임짐.
import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository {
  static const String _autoPlay = 'autoplay';
  static const String _muted = 'muted';
  static const String _isDarkMode = 'darkmode';

  final SharedPreferences _preferences;

  PlaybackConfigRepository(this._preferences);

  Future<void> setAutoPlay(bool value) async {
    _preferences.setBool(_autoPlay, value);
  }

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setDarkMode(bool value) async {
    _preferences.setBool(_isDarkMode, value);
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoPlay() {
    return _preferences.getBool(_autoPlay) ?? false;
  }

  bool isDarkMode() {
    return _preferences.getBool(_isDarkMode) ?? false;
  }
}
