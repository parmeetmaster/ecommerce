import 'package:model_architecture/constantPackage/language/words.dart';
import 'package:model_architecture/constantPackage/language/languageEn.dart';
import 'package:model_architecture/constantPackage/language/languageHn.dart';
import 'package:model_architecture/utils/app_logger.dart';
import 'package:model_architecture/utils/preference.dart';

enum languageEnum {english,hindi} //todo add supported languages here
const languageCacheKey="language";

// todo set primary language using lanuage selection screen
setPrimaryLanguage(var languageString) async{
 await Preference.load();
  switch(languageString){
    case languageEnum.english: Preference.setString(languageCacheKey, languageEnum.english.toString());
    break;
    case languageEnum.hindi: Preference.setString(languageCacheKey, languageEnum.hindi.toString());
    break;
    default:
  }
}

getPrimaryLanguage() async{
 await Preference.load();
   String cacheLanguage=Preference.getString(languageCacheKey);
   if(cacheLanguage==languageEnum.english.toString()){
     return LanguageEn();
   }else  if(cacheLanguage==languageEnum.hindi.toString()){
     return LanguageHn();
   }else{
    // AppLogger.print("Language is not set");
     return LanguageEn(); //todo set default language here
   }

}

 isPrimaryLanguageset() async{
 await Preference.load();
  if(Preference.getString(languageCacheKey)==null){
    return false;
  }else{
    return true;
  }
}



