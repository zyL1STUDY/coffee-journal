import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../core/config/app_environment.dart';
import '../domain/coffee_record.dart';

final coffeeAiMessageServiceProvider = Provider<CoffeeAiMessageService>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return CoffeeAiMessageService(
    apiKey: AppEnvironment.aiApiKey,
    model: AppEnvironment.aiModel,
    client: client,
  );
});

class CoffeeAiMessageService {
  const CoffeeAiMessageService({
    required this.apiKey,
    required this.model,
    required this.client,
  });

  static final _responsesUri = Uri.parse('https://api.openai.com/v1/responses');

  final String? apiKey;
  final String model;
  final http.Client client;

  bool get canGenerate =>
      apiKey?.trim().isNotEmpty == true && model.trim().isNotEmpty;

  Future<String?> generateMessage(CoffeeRecord record) async {
    if (!canGenerate) {
      return null;
    }

    try {
      final response = await client.post(
        _responsesUri,
        headers: {
          'Authorization': 'Bearer ${apiKey!.trim()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': model.trim(),
          'store': false,
          'max_output_tokens': 120,
          'reasoning': {'effort': 'none'},
          'input': [
            {
              'role': 'developer',
              'content':
                  '你是 Coffee Journal 的 AI 记忆文案助手。只输出一句简体中文短句，语气温柔、具体、低打扰。不要像聊天机器人，不要解释，不要使用列表，不要编造用户没有提供的事实。',
            },
            {'role': 'user', 'content': _promptFor(record)},
          ],
        }),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return null;
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, Object?>) {
        return null;
      }

      return _sanitize(_extractOutputText(decoded));
    } catch (_) {
      return null;
    }
  }

  String _promptFor(CoffeeRecord record) {
    final drinkName = record.drinkName?.trim();
    final note = record.note?.trim();

    return [
      '请根据这条咖啡记录生成一句 Coffee Memory 文案。',
      '来源类型：${record.sourceType.title}',
      '来源名称：${record.sourceName}',
      if (drinkName != null && drinkName.isNotEmpty) '饮品名：$drinkName',
      if (note != null && note.isNotEmpty) '用户备注：$note',
      '记录时间：${record.createdAt.toIso8601String()}',
      '要求：一句话，最多 24 个中文字符，温柔但不过度煽情。',
    ].join('\n');
  }

  String? _extractOutputText(Map<String, Object?> json) {
    final outputText = json['output_text'];
    if (outputText is String && outputText.trim().isNotEmpty) {
      return outputText;
    }

    final output = json['output'];
    if (output is! List) {
      return null;
    }

    for (final item in output) {
      if (item is! Map<String, Object?>) {
        continue;
      }

      final content = item['content'];
      if (content is! List) {
        continue;
      }

      for (final contentItem in content) {
        if (contentItem is! Map<String, Object?>) {
          continue;
        }

        final text = contentItem['text'];
        if (text is String && text.trim().isNotEmpty) {
          return text;
        }
      }
    }

    return null;
  }

  String? _sanitize(String? value) {
    final text = value
        ?.trim()
        .replaceAll(RegExp(r'^["“”]+|["“”]+$'), '')
        .split('\n')
        .first
        .trim();
    if (text == null || text.isEmpty) {
      return null;
    }

    if (text.length > 36) {
      return '${text.substring(0, 36)}…';
    }

    return text;
  }
}
