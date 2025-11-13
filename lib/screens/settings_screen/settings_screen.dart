import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serpapi_price_tool_sample/constants/config.dart';
import 'package:serpapi_price_tool_sample/models/language_setting.dart';
import 'package:serpapi_price_tool_sample/providers/api_provider.dart';
import 'package:serpapi_price_tool_sample/providers/language_provider.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  final TextEditingController _apiController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _apiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final apiProvider = Provider.of<ApiProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 25,),

            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.primary,
                        size: 30,
                      )
                  ),

                  const SizedBox(width: 35,),

                  Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return Text(
                        MultiLanguageStrings.setting[languageProvider.languageSetting.language]?? 'Settings',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontFamily: AppTypography.notoFontKind(),
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }
                  ),
                ],
              )
            ),

            LayoutBuilder(
              builder: (context, constrains) {
                return Container(
                  width: constrains.maxWidth * 0.65,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SerpApi api key:',
                        style: AppTypography.big(
                          context,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400
                        ),
                      ),

                      const SizedBox(height: 10,),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFF0F0F0)
                              ),
                              child: TextField(
                                controller: _apiController,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  hintText: apiProvider.api,
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
                          ),

                          const SizedBox(width: 50,),

                          SizedBox(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await apiProvider.setApiKey(_apiController.text);
                                    print(apiProvider.api);
                                    if(apiProvider.api != null && mounted) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Colors.transparent,
                                          content: Container(
                                              height: 300,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(width: 2, color: AppColors.secondary)
                                              ),
                                              child: Center(
                                                child: Text(
                                                  MultiLanguageStrings.apiKeySaved[context.read<LanguageProvider>().languageSetting.language]!,
                                                  style: AppTypography.big(context, color: AppColors.primary),
                                                ),
                                              )
                                          ),
                                        )
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 35,
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Center(
                                        child: Consumer<LanguageProvider>(builder: (context, languageProvider, child) {
                                          return Text(
                                            MultiLanguageStrings.save[languageProvider.languageSetting.language]?? 'Save',
                                            style: AppTypography.medium(
                                                context,
                                                color: Colors.white
                                            ),
                                          );
                                        })
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10,),

                                GestureDetector(
                                  onTap: () async {
                                    await apiProvider.deleteApiKey();
                                    _apiController.text = '';
                                    if(apiProvider.api == null && mounted) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Colors.transparent,
                                          content: Container(
                                            height: 300,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15),
                                              border: Border.all(width: 2, color: AppColors.secondary)
                                            ),
                                            child: Center(
                                              child: Text(
                                                MultiLanguageStrings.apiKeyDeleted[context.read<LanguageProvider>().languageSetting.language]!,
                                                style: AppTypography.big(context, color: AppColors.primary),
                                              ),
                                            )
                                          ),
                                        )
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 35,
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 2,
                                            color: AppColors.primary
                                        )
                                    ),
                                    child: Center(
                                        child: Consumer<LanguageProvider>(builder: (context, languageProvider, child) {
                                          return Text(
                                            MultiLanguageStrings.delete[languageProvider.languageSetting.language]?? 'Delete',
                                            style: AppTypography.medium(
                                                context,
                                                color: AppColors.primary
                                            ),
                                          );
                                        })
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}