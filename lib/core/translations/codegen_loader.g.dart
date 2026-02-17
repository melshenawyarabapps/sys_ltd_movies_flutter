// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _en = {
  "networkError": "Network error occurred",
  "unexpectedError": "An unexpected error occurred",
  "sendTimeOutPleaseTryAgainLater": "Send timeout. Please try again later",
  "receiveTimeOutPleaseTryAgainLater": "Receive timeout. Please try again later",
  "connectionErrorPleaseTryAgainLater": "Connection error. Please try again later",
  "requestHasBeenCancelledPleaseTryAgainLater": "Request cancelled. Please try again later",
  "oppsAnUnexpectedErrorOccurredPleaseTryAgainLater": "Oops! An unexpected error occurred. Please try again later",
  "popularMovies": "Popular Movies",
  "noMoviesFound": "No movies found.",
  "retry": "Retry",
  "back": "Back",
  "loadingError": "Failed to load image.",
  "online": "Online",
  "offline": "Offline"
};
static const Map<String,dynamic> _ar = {
  "networkError": "الرجاء التحقق من اتصالك بالشبكة ومحاولة مرة أخرى",
  "unexpectedError": "خطأ غير متوقع",
  "sendTimeOutPleaseTryAgainLater": "يرجى إعادة المحاولة لاحقًا.",
  "receiveTimeOutPleaseTryAgainLater": "يرجى المحاولة مرة أخرى فى وقت لاحق.",
  "connectionErrorPleaseTryAgainLater": "خطأ فى الاتصال، يرجى المحاولة مرة أخرى لاحقًا.",
  "requestHasBeenCancelledPleaseTryAgainLater": "تم إلغاء الطلب، يرجى المحاولة مرة أخرى لاحقًا.",
  "oppsAnUnexpectedErrorOccurredPleaseTryAgainLater": "عفوًا، حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى لاحقًا",
  "popularMovies": "الأفلام الشائعة",
  "noMoviesFound": "لم يتم العثور على أفلام.",
  "retry": "إعادة المحاولة",
  "back": "رجوع",
  "loadingError": "فشل تحميل الصورة.",
  "online": "متصل",
  "offline": "غير متصل"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": _en, "ar": _ar};
}
