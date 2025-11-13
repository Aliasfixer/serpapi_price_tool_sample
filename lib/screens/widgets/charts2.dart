import 'package:provider/provider.dart';
import 'package:serpapi_price_tool_sample/providers/language_provider.dart';
import 'package:serpapi_price_tool_sample/providers/product_provider.dart';

import '../../constants/config.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PricePieChart extends StatefulWidget {
  const PricePieChart({super.key});

  @override
  State<StatefulWidget> createState() => _PricePieChart();
}

class _PricePieChart extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: AppColors.pieChart1,
                text: '${productProvider.productList[0].price.toStringAsFixed(2)} - ${(productProvider.productList[0].price + productProvider.quarterPriceRange).toStringAsFixed(2)}',
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.pieChart2,
                text: '${(productProvider.productList[0].price + productProvider.quarterPriceRange).toStringAsFixed(2)} - ${(productProvider.productList[0].price + productProvider.quarterPriceRange * 2).toStringAsFixed(2)}',
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.pieChart3,
                text: '${(productProvider.productList[0].price + productProvider.quarterPriceRange * 2).toStringAsFixed(2)} - ${(productProvider.productList[0].price + productProvider.quarterPriceRange * 3).toStringAsFixed(2)}',
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.pieChart4,
                text: '${(productProvider.productList[0].price + productProvider.quarterPriceRange * 3).toStringAsFixed(2)} - ${(productProvider.productList[productProvider.productList.length - 1].price).toStringAsFixed(2)}',
                isSquare: true,
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return switch (i) {
        0 => PieChartSectionData(
          color: AppColors.pieChart1,
          value: productProvider.splitList[0].length / productProvider.productList.length,
          title: '${(productProvider.splitList[0].length / productProvider.productList.length * 100).toStringAsFixed(2)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        ),
        1 => PieChartSectionData(
          color: AppColors.pieChart2,
          value: productProvider.splitList[1].length / productProvider.productList.length,
          title: '${(productProvider.splitList[1].length / productProvider.productList.length * 100).toStringAsFixed(2)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        ),
        2 => PieChartSectionData(
          color: AppColors.pieChart3,
          value: productProvider.splitList[2].length / productProvider.productList.length,
          title: '${(productProvider.splitList[2].length / productProvider.productList.length * 100).toStringAsFixed(2)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        ),
        3 => PieChartSectionData(
          color: AppColors.pieChart4,
          value: productProvider.splitList[3].length / productProvider.productList.length,
          title: '${(productProvider.splitList[3].length / productProvider.productList.length * 100).toStringAsFixed(2)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        ),
        _ => throw StateError('Invalid'),
      };
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}