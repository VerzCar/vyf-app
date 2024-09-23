import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './models/models.dart';
import 'i_shared_settings_repository.dart';

class SharedSettingsRepository implements ISharedSettingsRepository {
  /// Private constructor
  SharedSettingsRepository._({
    required SharedPreferences sharedPrefs,
  }) {
    _sharedPrefs = sharedPrefs;
  }

  static Future<SharedSettingsRepository> create() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    var repo = SharedSettingsRepository._(
      sharedPrefs: sharedPrefs,
    );

    return repo;
  }

  final Logger log = Logger();
  late SharedPreferences _sharedPrefs;
  static const String _preferencesKey = 'vyf_shared_prefs';

  @override
  Future<bool> savePreferences(SharedSetting prefs) async {
    final convertedPrefs = jsonEncode(prefs.toJson());

    return _sharedPrefs.setString(_preferencesKey, convertedPrefs);
  }

  @override
  SharedSetting get settings => _settings;

  // TODO call this method on user change or global clearing
  @override
  void dispose() async {
    await _sharedPrefs.clear();
  }

  SharedSetting get _settings {
    try {
      final settingsJson = _sharedPrefs.getString(_preferencesKey);

      if (settingsJson != null) {
        return SharedSetting.fromJson(jsonDecode(settingsJson));
      }
    } catch (e) {
      log.t('_settings', error: e);
    }

    return const SharedSetting(
      initialUseOfApp: true,
    );
  }
}
