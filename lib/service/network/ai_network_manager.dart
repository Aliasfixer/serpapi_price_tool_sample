import 'package:dio/dio.dart';
import 'package:serpapi_price_tool_sample/constants/system_prompt.dart';
import 'dart:convert';

import 'package:serpapi_price_tool_sample/models/language_setting.dart';

class AiNetworkManager {
  static final AiNetworkManager _instance = AiNetworkManager._internal();

  static AiNetworkManager get instance => _instance;

  AiNetworkManager._internal() {
    initDio();
  }

  late Dio dio;

  String modelName = 'qwen3-235b-a22b';

  void configure({String? modelName}) {
    if (modelName != null) this.modelName = modelName;
  }

  initDio() {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://dashscope.aliyuncs.com/compatible-mode/v1/',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          headers: {
            "Authorization": "Bearer sk-0d1ebd7802cc4ec78ec5f8beb464d0c3",
            "Content-Type": "application/json", // 一般也要带上
          },
        )
    );
  }

  Stream<String> sendStreamMessage(String message, Language language) async* {
    final body = {
      'model': modelName,
      'stream': true,
      "enable_thinking": false,
      'messages': [
        SystemPrompt.analyzePrompt[language],
        {
          'role': 'user',
          'content': message
        }
      ],
    };

    try {
      final response = await dio.post(
        'chat/completions',
        data: body,
        options: Options(
          responseType: ResponseType.stream, // 关键：以流接收
        ),
      );

      String buffer = '';
      String streamString = '';

      await for (final chunk in response.data.stream) {

        final chunkString = utf8.decode(chunk);
        buffer += chunkString;

        final lines = buffer.split('\n');
        buffer = lines.removeLast();

        for (String line in lines) {
          line = line.trim();

          if (line.isEmpty) continue;

          if (line.startsWith('data: ')) {
            final dataContent = line.substring(6); // 移除 'data: ' 前缀

            if (dataContent.trim() == '[DONE]') {
              return;
            }

            try {
              final jsonData = json.decode(dataContent);

              final choices = jsonData['choices'] as List?;
              if (choices != null && choices.isNotEmpty) {
                final delta = choices[0]['delta'];
                final content = delta?['content'] as String?;

                if (content != null && content.isNotEmpty) {
                  streamString += content;
                  yield streamString;
                }
              }
            } catch (e) {
              print(e);
            }
          }
        }
      }

      if (buffer
          .trim()
          .isNotEmpty) {
        final line = buffer.trim();
        if (line.startsWith('data: ')) {
          final dataContent = line.substring(6);
          if (dataContent.trim() != '[DONE]') {
            try {
              final jsonData = json.decode(dataContent);
              final choices = jsonData['choices'] as List?;
              if (choices != null && choices.isNotEmpty) {
                final delta = choices[0]['delta'];
                final content = delta?['content'] as String?;
                if (content != null && content.isNotEmpty) {
                  yield content;
                }
              }
            } catch (e) {
              print('最后一个JSON解析错误: $e');
            }
          }
        }
      }
    } catch (e) {
      yield '[Error: $e]';
    }
  }
}