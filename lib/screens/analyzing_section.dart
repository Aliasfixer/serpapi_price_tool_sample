import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serpapi_price_tool_sample/providers/product_provider.dart';
import 'package:serpapi_price_tool_sample/screens/widgets/ai_analyze_section.dart';
import 'package:serpapi_price_tool_sample/screens/widgets/charts.dart';
import 'package:serpapi_price_tool_sample/screens/widgets/charts2.dart';
import 'package:serpapi_price_tool_sample/screens/widgets/product_card.dart';

import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import '../constants/multi_language_strings.dart';
import '../models/language_setting.dart';
import '../providers/language_provider.dart';

class AnalyzingSection extends StatefulWidget {
  final String productName;

  const AnalyzingSection({
    super.key,
    required this.productName
  });

  @override
  State<AnalyzingSection> createState() => _AnalyzingSection();
}

class _AnalyzingSection extends State<AnalyzingSection> {
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);
    String analyze = '${MultiLanguageStrings.analyzePhase1[languageProvider.languageSetting.language]}${productProvider.ave.toStringAsFixed(2)}\n'
        '${MultiLanguageStrings.analyzePhase2[languageProvider.languageSetting.language]}${productProvider.mode.toStringAsFixed(2)}\n'
        '${MultiLanguageStrings.analyzePhase3[languageProvider.languageSetting.language]}${productProvider.productList[productProvider.productList.length - 1].price.toStringAsFixed(2)}  ${productProvider.productList[0].price.toStringAsFixed(2)}\n'
        '${MultiLanguageStrings.analyzePhase4[languageProvider.languageSetting.language]}${productProvider.standardDeviation.toStringAsFixed(2)}.\n';

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        children: [

          SizedBox(
            height: 200,
            width: double.infinity,
            child: AdaptiveScrollbar(
              controller: _scrollController,
              position: ScrollbarPosition.bottom,
              width: 10,
              sliderActiveColor: Colors.white,
              sliderDefaultColor: Colors.white,
              underColor: AppColors.halfTransparent,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                      return Row(
                        spacing: 15,
                        children: List.generate(
                          productProvider.productList.length,
                            (index) {
                              return ProductCard(
                                product: productProvider.productList[index]
                              );
                            }
                        ),
                      );
                    }
                )
              ),
            ),
          ),

          Container(
            height: 500,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 75),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return Text(
                        '${widget.productName} ${MultiLanguageStrings.analyzeTitle[languageProvider.languageSetting.language]!}',
                        style: AppTypography.grand(
                            context,
                            color: AppColors.primary
                        ),
                      );
                    }
                  ),

                  PriceBarChart(
                    productName: widget.productName,
                  ),
                ],
              ),
          ),

          Row(
            children: [
              Flexible(
                  flex: 2,
                  child: Container(
                    height: 300,
                    padding: const EdgeInsets.only(left: 75),
                    width: double.infinity,
                    child: const Center(
                      child: PricePieChart(),
                    ),
                  )
              ),

              Flexible(
                flex: 3,
                child: Container(
                  height: 300,
                  padding: const EdgeInsets.fromLTRB(15, 0, 75, 0),
                  alignment: Alignment.center,
                  child: Text(
                    analyze,
                    textAlign: TextAlign.center,
                    style: AppTypography.medium(context, color: AppColors.primary, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 3,
                    child: SizedBox(
                      width: double.infinity,
                      child: AiAnalyzeSection(message: analyze),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}