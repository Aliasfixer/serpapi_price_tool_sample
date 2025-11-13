import '../models/language_setting.dart';

class MultiLanguageStrings {

  static Map<Language, String> start = {
    Language.en: 'start',
    Language.zh: '开始'
  };

  static Map<Language, String> chooseLanguage = {
    Language.en: 'Language',
    Language.zh: '语言'
  };

  static Map<Language, String> apiHint = {
    Language.en: 'Please enter your Api Key',
    Language.zh: '请输入你的Api Key'
  };

  static Map<Language, String> productHint = {
    Language.en: 'Please enter the name of the product',
    Language.zh: '请输入你要搜索的商品'
  };

  static Map<Language, String> search = {
    Language.en: 'Search',
    Language.zh: '搜索'
  };

  static Map<Language, String> average = {
    Language.en: 'the average price is',
    Language.zh: '平均价格为'
  };

  static Map<Language, String> mode = {
    Language.en: 'the most common price is',
    Language.zh: '最常见的价格是'
  };

  static Map<Language, String> min = {
    Language.en: 'the lowest price is',
    Language.zh: '最低的价格是'
  };

  static Map<Language, String> setting = {
    Language.en: 'Settings',
    Language.zh: '设置'
  };

  static Map<Language, String> save = {
    Language.en: 'Save',
    Language.zh: '保存'
  };

  static Map<Language, String> delete = {
    Language.en: 'Delete',
    Language.zh: '删除'
  };

  static Map<Language, String> priceDistribution = {
    Language.en: 'Price Distribution',
    Language.zh: '价格分布'
  };

  static Map<Language, String> productName = {
    Language.en: 'Product title: ',
    Language.zh: '商品名: '
  };

  static Map<Language, String> apiAlert = {
    Language.en: 'Please enter your SerpApi api key in settings, you can get your api key in ',
    Language.zh: '请在设置界面输入SerpApi的api key, 你可以在后面链接中获取api key: '
  };

  static Map<Language, String> sourceName = {
    Language.en: 'Source from: ',
    Language.zh: '商家: '
  };

  static Map<Language, String> analyzePhase1 = {
    Language.en: 'In Google shopping, we extracted 20 products, and here is mathematical analyzing:\nthe average price is ',
    Language.zh: '在Google shop中，提取前20个商品后分析结果如下：\n平均价格为：'
  };

  static Map<Language, String> analyzePhase2 = {
    Language.en: 'the most common price is ',
    Language.zh: '价格众数为：'
  };

  static Map<Language, String> analyzePhase3 = {
    Language.en: 'the max/min prices are ',
    Language.zh: '最大最小价格为：'
  };

  static Map<Language, String> analyzePhase4 = {
    Language.en: 'the standard deviation is ',
    Language.zh: '标准差为：'
  };

  static Map<Language, String> ai = {
    Language.en: 'AI analysis',
    Language.zh: 'AI 分析'
  };

  static Map<Language, String> price = {
    Language.en: '\'s price is \$',
    Language.zh: '的价格是 \$'
  };

  static Map<Language, String> apiKeySaved = {
    Language.en: 'api key has been successfully saved',
    Language.zh: 'api key保存成功'
  };

  static Map<Language, String> apiKeyDeleted = {
    Language.en: 'api key has been successfully deleted',
    Language.zh: 'api key删除成功'
  };

}