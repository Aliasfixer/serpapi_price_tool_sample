import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serpapi_price_tool_sample/providers/api_provider.dart';
import 'package:serpapi_price_tool_sample/providers/language_provider.dart';
import 'package:serpapi_price_tool_sample/providers/product_provider.dart';
import 'package:serpapi_price_tool_sample/screens/home_screen.dart';
import 'package:serpapi_price_tool_sample/screens/home_screen/product_repository.dart';
import 'constants/config.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(productRepository: ProductRepository()),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => ApiProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    initLanguageSetting();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initLanguageSetting() async {
    context.read<LanguageProvider>().loadLanguageSetting();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '演示软件',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen()
    );
  }
}
