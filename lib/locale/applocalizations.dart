import 'package:flutter/material.dart';
import 'package:maven_class/locale/base_language.dart';
import 'package:maven_class/locale/language_ar.dart';
import 'package:maven_class/locale/language_de.dart';
import 'package:maven_class/locale/language_en.dart';
import 'package:maven_class/locale/language_fr.dart';
import 'package:maven_class/locale/language_hi.dart';

// import 'package:nb_utils/nb_utils.dart';


abstract class AppLocalizations extends LocalizationsDelegate<Languages> {
  const AppLocalizations();

  @override
  Future<Languages> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'hi':
        return LanguageHi();
      case 'ar':
        return LanguageAr();
      case 'de':
        return LanguageDe();
      case 'fr':
        return LanguageFr();
      default:
        return LanguageEn();
    }
  }

  @override
  // bool isSupported(Locale locale) => LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
