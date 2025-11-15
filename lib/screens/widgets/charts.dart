
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serpapi_price_tool_sample/constants/config.dart';
import 'package:serpapi_price_tool_sample/providers/language_provider.dart';
import 'package:serpapi_price_tool_sample/providers/product_provider.dart';

class PriceBarChart extends StatefulWidget {
  final String productName;

  @override
  const PriceBarChart({
    super.key,
    required this.productName
  });

  final Color barBackgroundColor = Colors.white;
  final Color barColor = AppColors.primary;
  final Color touchedBarColor = AppColors.darker;

  @override
  State<StatefulWidget> createState() => _PriceBarChart();
}

class _PriceBarChart extends State<PriceBarChart> {
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context, listen: true);

    return Column(
      children: [
        AspectRatio(
          aspectRatio: (MediaQuery.of(context).size.width - 150) / 350,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      widget.productName,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: BarChart(
                          mainBarData(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Text(
          MultiLanguageStrings.priceDistribution[languageProvider.languageSetting.language]?? 'Price Distribution',
          style: AppTypography.medium(
            context,
            color: AppColors.primary,
            fontWeight: FontWeight.w400
          ),
        )
      ],
    );
  }


  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color? barColor,
        double width = 10,
        List<int> showTooltips = const [],
      }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }


  List<BarChartGroupData> showingGroups() {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return List.generate(
      productProvider.productList.length,
        (index) => makeGroupData(
          index,
          productProvider.productList[index].price,
            isTouched: (index == touchedIndex)
        )
    );
  }

  ///柱体
  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => AppColors.halfTransparent.withAlpha(120),
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -25,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String sourceName = context.read<ProductProvider>().productList[group.x].source;
            String productName = context.read<ProductProvider>().productList[group.x].title;
            return BarTooltipItem(
              '${MultiLanguageStrings.productName[context.read<LanguageProvider>().languageSetting.language]}\n'
                  '$productName\n\n'
                  '${MultiLanguageStrings.sourceName[context.read<LanguageProvider>().languageSetting.language]}\n'
                  '$sourceName\n\n',
              const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ((rod.toY - 1).toStringAsFixed(2)).toString(),
                  style: const TextStyle(
                    color: AppColors.darker,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  ///下方标识
  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontFamily: 'NotoSansSC',
      color: AppColors.primary,
      fontWeight: FontWeight.w300,
      fontSize: 10,
    );
    String text = context.watch<ProductProvider>().productList[value.toInt()].source.substring(0, 3);

    return SideTitleWidget(
      meta: meta,
      space: 15,
      child: Text(text, style: style),
    );
  }
}