import 'models/models.dart';

abstract class ISharedSettingsRepository {
  Future<bool> savePreferences(SharedSetting prefs);

  SharedSetting get settings;

  void dispose();
}
