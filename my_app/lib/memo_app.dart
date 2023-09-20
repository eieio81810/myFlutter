import 'package:flutter/material.dart';

import 'memo_list_page.dart';

class MemoApp extends StatelessWidget {
  // テーマカラーをブラウンにするために設定
  static Map<int, Color> color = {
    50: const Color(0xFFEFEBE9),
    100: const Color(0xFFD7CCC8),
    200: const Color(0xFFBCAAA4),
    300: const Color(0xFFA1887F),
    400: const Color(0xFF8D6E63),
    500: const Color(0xFF895548),
    600: const Color(0xFF6D4C41),
    700: const Color(0xFF5D4037),
    800: const Color(0xFF4E342E),
    900: const Color(0xFF3E2723),
  };
  final MaterialColor primeColor = MaterialColor(0xFFA1887F, color);

  MemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: "Memo App",
      theme: ThemeData(
        // テーマカラー設定
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primeColor).copyWith(secondary: primeColor)
      ),
      // メモリスト画面を表示
      home: const MemoListPage(),
    );
  }
}