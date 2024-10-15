import 'dart:ui';
import '../lang/es_ve.dart';
import 'package:get/get.dart';

class Localization extends Translations {
  static const locale = Locale('es', 'ES');

  static const fallbackLocale = Locale('es', 'VE');

  List langs = [
    {"title": 'Español', 'value': 0},
  ];

  final locales = [
    const Locale('es', 'VE'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'es_VE': esVE,
      };

  void changeLocale(int lang) => Get.updateLocale(locales[lang]);
}
