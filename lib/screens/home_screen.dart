import 'package:decimal/decimal.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serpapi_price_tool_sample/constants/view_status/product_list_status.dart';
import 'package:serpapi_price_tool_sample/providers/api_provider.dart';
import 'package:serpapi_price_tool_sample/providers/product_provider.dart';
import 'package:serpapi_price_tool_sample/screens/home_screen/product_repository.dart';
import 'package:serpapi_price_tool_sample/screens/settings_screen/settings_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/config.dart';
import '../models/language_setting.dart';
import '../providers/language_provider.dart';
import 'analyzing_section.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  final ProductRepository productRepository = ProductRepository();
  final TextEditingController _contextController = TextEditingController();
  List<LanguageSetting> languageList = [
    LanguageSetting(Language.en),
    LanguageSetting(Language.zh)
  ];

  LanguageSetting? selectedLanguage;
  String? productName;

  bool _isButtonEnabled = false;

  late Decimal priceAverage;
  late Decimal priceMode;
  late Decimal minPrice;
  List<Decimal> priceList = [];

  @override
  void initState() {
    super.initState();
    loadLanguageSetting();
    _contextController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _contextController.removeListener(_onTextChanged);
    _contextController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = (
        _contextController.text.isNotEmpty
      );
    });
  }

  Future<void> loadLanguageSetting() async {
    LanguageSetting languageSetting = context.read<LanguageProvider>().languageSetting;
    setState(() {
      selectedLanguage = languageSetting;
    });
  }

  Future<void> selectLanguageSetting(LanguageSetting languageSetting) async {
    await context.read<LanguageProvider>().setLanguage(languageSetting);
    setState(() {
      selectedLanguage = languageSetting;
    });
  }

  Future<void> openLink() async {
    final uri = Uri.parse('https://serpapi.com');
    print('Trying to open: $uri');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch https://serpapi.com';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ApiProvider apiProvider = Provider.of<ApiProvider>(context, listen: false);

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///左侧空白部分
                ///占据屏幕宽度1/3
                ///预留空位(高阶搜索选项等)
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: 20,
                  )
                ),

                ///中间搜索栏位
                ///输入框体输入搜索商品内容，并添加按钮执行ProductProvider中fetch方法获取商品列表详细信息
                ///框体上方为主logo
                ///框体下方应该展示地图信息
                Flexible(
                  flex: 3,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: LayoutBuilder(
                      builder: (context, constrains) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: constrains.maxWidth * 0.625,
                              child: Center(
                                child: Text(
                                  '\$erprice',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontFamily: AppTypography.josefinFontKind(),
                                    color: AppColors.primary,
                                    fontSize: 40
                                  )
                                ),
                              ),
                            ),

                            const SizedBox(height: 10,),

                            ///搜索栏
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 50,
                                width: constrains.maxWidth * 0.625,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    ///高度为50，宽度为constrain.maxWidth的50%，考虑是否需要保持框体宽度
                                    SizedBox(
                                      height: 50,
                                      width: constrains.maxWidth * 0.625 - 100,
                                      child: TextField(
                                        controller: _contextController,
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          hintText: MultiLanguageStrings.productHint[selectedLanguage!.language],
                                          border: InputBorder.none,
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 15
                                          ),
                                          hintStyle: AppTypography.small(
                                              context,
                                              color: AppColors.textGrey
                                          ),
                                        ),
                                        style: AppTypography.small(
                                            context,
                                            color: AppColors.textBlack
                                        ),
                                      ),
                                    ),

                                    ///搜索按钮，宽度为100，高度与搜索框高度相同，中间字体根据多语言设置自适应
                                    ///触发机制为当_isButtonEnabled时，使用ProductProvider中的fetch方法为Provider获取商品详细列表
                                    Consumer<ProductProvider>(
                                      builder: (context, productProvider, child) {
                                        return GestureDetector(
                                          onTap: () {
                                            if(_isButtonEnabled && apiProvider.api != null) {
                                              productProvider.fetchProductList(_contextController, apiProvider.api!);
                                              setState(() {
                                                productName = _contextController.text;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 100,
                                            color: (_isButtonEnabled)? AppColors.primary :AppColors.textPaleGrey,
                                            child: Center(
                                              child: Text(
                                                MultiLanguageStrings.search[selectedLanguage!.language]!,
                                                style: AppTypography.big(
                                                  context,
                                                  color: (_isButtonEnabled)? Colors.white :AppColors.textGrey,
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    )

                                  ],
                                ),

                              ),
                            ),

                            Consumer<ApiProvider>(
                              builder: (context, apiProvider, child) {
                                return
                                  (apiProvider.api == null || apiProvider.api!.length < 30)?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.dangerous,
                                        color: Colors.red,
                                        size: 15,
                                      ),

                                      const SizedBox(width: 3,),

                                      Text(
                                        MultiLanguageStrings.apiAlert[selectedLanguage!.language]!,
                                        style: AppTypography.small(context, color: Colors.red, fontWeight: FontWeight.w400),
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          openLink();
                                        },
                                        child: Text(
                                          'https://serpapi.com/',
                                            style: AppTypography.small(context, color: Colors.blue, fontWeight: FontWeight.w400)
                                        ),
                                      )
                                    ],
                                  )
                                :const SizedBox();
                              }
                            )

                          ],
                        );
                      }
                    )
                  )
                ),

                ///右侧多语言功能选项与设置按钮
                ///多语言触发使用LanguageProvider进行管理
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.list,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                        
                                const SizedBox(
                                  width: 4,
                                ),
                        
                                Expanded(
                                  child: Text(
                                    MultiLanguageStrings.chooseLanguage[selectedLanguage!.language]!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                        
                            items: languageList.map((language) => DropdownMenuItem<LanguageSetting>(
                              value: language,
                              child: Text(
                                Language.languageToDisplayString(language.language),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )).toList(),
                        
                            value: selectedLanguage,
                        
                            onChanged: (value) {
                              selectLanguageSetting(value!);
                            },
                        
                            buttonStyleData: ButtonStyleData(
                              height: 30,
                              width: 90,
                              padding: const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.primary,
                                ),
                                color: Colors.white,
                              ),
                              elevation: 0,
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: AppColors.primary,
                              iconDisabledColor: Colors.grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: WidgetStateProperty.all(6),
                                thumbVisibility: WidgetStateProperty.all(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          )
                        ),
                        
                        IconButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsScreen()
                              )
                            );
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: AppColors.primary,
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            ///搜索栏下方
            ///包含分析报告、读取界面等主要功能
            Expanded(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    switch(productProvider.status.type) {
                      case ProductListStatusType.uninitialized:
                        return const SizedBox();
                      case ProductListStatusType.failure:
                        return Center(
                          child: Text(
                            productProvider.status.message!
                          ),
                        );
                      case ProductListStatusType.loading:
                        return const Center(
                          child: CircularProgressIndicator(color: AppColors.primary,),
                        );
                      case ProductListStatusType.success:
                        return AnalyzingSection(
                          productName: productName!,
                        );
                    }
                  }
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}