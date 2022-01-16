import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:owner_app/l10n/language_constants.dart';

class LocalChange with ChangeNotifier {
  Locale? _local;
  Locale? get local => _local;

  String? _localString;
  String? get localString => _localString;

  Future<void> setLocale(String languageCode) async {
    _local = await saveLocale(languageCode);
  }

  Future<void> initialLocal() async {
    _localString = await loadLocale();
  }
}
