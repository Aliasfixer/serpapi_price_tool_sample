import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serpapi_price_tool_sample/models/language_setting.dart';
import 'package:serpapi_price_tool_sample/providers/language_provider.dart';
import 'package:serpapi_price_tool_sample/providers/product_provider.dart';
import '../../constants/config.dart';
import '../../models/product_model.dart';
import '../../service/network/ai_network_manager.dart';

class AiAnalyzeSection extends StatefulWidget {
  final String message;

  const AiAnalyzeSection({
    super.key,
    required this.message
  });

  @override
  State<AiAnalyzeSection> createState() => _AiAnalyzeSection();
}

class _AiAnalyzeSection extends State<AiAnalyzeSection> {
  bool aiRequesting = false;
  bool aiMode = false;
  late var aiStream;
  String _analyzingMessage = '';


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    aiStream.dispose();
    super.dispose();
  }

  Future<void> fetchAiData(Language language) async {
    final AiNetworkManager net = AiNetworkManager.instance;
    String message = getPriceList(language);

    setState(() {
      aiRequesting = true;
      aiMode = true; // 用于显示框体
      _analyzingMessage = ''; // 清空之前的内容
      aiStream = net.sendStreamMessage(message, language); // 获取 Stream
    });
  }

  String getPriceList(Language language) {
    List<Product> productList = context.read<ProductProvider>().productList;
    String priceInfo = '';
    for(var p in productList) {
      String info = '${p.source}-${p.title}${MultiLanguageStrings.price[language]}${p.price.toStringAsFixed(2)}\n';
      priceInfo += info;
    }
    priceInfo += widget.message;
    print(priceInfo);
    return priceInfo;
  }

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Align(
            child: ElevatedButton(
                onPressed: () {
                  fetchAiData(languageProvider.languageSetting.language);
                  // getPriceList(languageProvider.languageSetting.language);
                },
                child: Text(
                  MultiLanguageStrings.ai[languageProvider.languageSetting.language]!,
                  style: AppTypography.medium(context, color: AppColors.primary, fontWeight: FontWeight.w500),
                )
            ),
          ),

          if(aiMode || aiRequesting)
          Align(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(80),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]
              ),
              child: (aiRequesting && aiStream != null)?
              _singleAiResponseSection()
                  : Text(
                _analyzingMessage,
                style: AppTypography.small(
                    context,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w300
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _singleAiResponseSection() {

    return DefaultTextStyle(
      style: AppTypography.tiny(context, color: AppColors.textBlack),
      child: StreamBuilder<String>(
        stream: aiStream,
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              return const SizedBox();
            case ConnectionState.done:
              return SelectableText(_analyzingMessage);
            case ConnectionState.waiting:
              return const Text('...');
            case ConnectionState.active:
              _analyzingMessage = snapshot.data!;
              return SelectableText(snapshot.data!);
          }
        },
      ),
    );
  }
}