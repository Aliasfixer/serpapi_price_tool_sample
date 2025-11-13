class LanguageSetting {
  final Language language;

  LanguageSetting(this.language);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LanguageSetting && language == other.language;

  @override
  int get hashCode => language.hashCode;
}

enum Language {
  en,
  zh;

  static Language fromString(String string) {
    switch (string) {
      case 'en':
        return Language.en;
      case 'zh':
        return Language.zh;
      default:
        return Language.en; // 默认语言
    }
  }

  static String languageToDisplayString(Language language) {
    switch (language) {
      case Language.en:
        return 'English';
      case Language.zh:
        return '中文';
      default:
        return 'English';
    }
  }

}

