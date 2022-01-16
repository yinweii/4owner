import 'package:flutter/widgets.dart';
import 'package:multiple_localization/multiple_localization.dart';
import 'l10n.dart';

class L10nDelegate extends LocalizationsDelegate<L10n> {
  const L10nDelegate();

  InitializeMessages? get initializeMessages => null;

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains('${locale.languageCode}'
        '${locale.countryCode != null ? ('_${locale.countryCode}') : ''}');
  }

  @override
  Future<L10n> load(Locale locale) {
    return MultipleLocalizations.load(
        initializeMessages!, locale, (l) => L10n(),
        setDefaultLocale: true);
  }

  @override
  bool shouldReload(L10nDelegate old) => false;
}
