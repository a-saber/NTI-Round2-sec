import 'package:get/get.dart';
import 'package:nti_r2/core/cache/cache_keys.dart';
import 'package:nti_r2/core/translation/translation_keys.dart';

import '../cache/cache_data.dart';
import '../cache/cache_helper.dart';
import 'ar.dart';
import 'en.dart';

enum AppLanguages { en, ar }

class TranslationHelper implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    CacheKeys.keyAR: ar,
    CacheKeys.keyEN: en,
  };

  static Future setLanguage() async
  {
    CacheData.lang = CacheHelper.getData(key: CacheKeys.langKey);

    if (CacheData.lang == null)
    {
      await CacheHelper.saveData(
          key: CacheKeys.langKey, value: CacheKeys.keyEN);
      await Get.updateLocale(TranslationKeys.localeEN);
      CacheData.lang = CacheKeys.keyEN;
    }
  }

  static changeLanguage(AppLanguages language)async
  {
    switch(language)
    {
      case AppLanguages.en:
        {
          await CacheHelper.saveData(
              key: CacheKeys.langKey, value: CacheKeys.keyEN);
          await Get.updateLocale(TranslationKeys.localeEN);
          CacheData.lang = CacheKeys.keyEN;
          break;
        }
      case AppLanguages.ar:
        {
          await CacheHelper.saveData(
              key: CacheKeys.langKey, value: CacheKeys.keyAR);
          await Get.updateLocale(TranslationKeys.localeAR);
          CacheData.lang = CacheKeys.keyAR;
          break;
        }
    }

  }
}