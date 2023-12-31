import 'package:flutter/material.dart';

/// メモリスト追加画面用Widget
class MemoAddPage extends StatefulWidget {
  const MemoAddPage({super.key});

  @override
  MemoAddPageState createState() => MemoAddPageState();
}

class MemoAddPageState extends State<MemoAddPage> {
  // 入力されたテキストをデータとして持つ
  String _text = "";

  // データを元に表示するWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MemoAdd"),
      ),
      body: SingleChildScrollView(child: Container(
        // 余白を付ける
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 入力されたテキストを表示
            Text(_text, style: TextStyle(color: Colors.brown[300])),
            const SizedBox(height: 8),
            // テキスト入力箇所
            TextField(
              // 入力されたテキストの値を受け取る(valueが入力されたテキスト)
              onChanged: (String value) {
                // データを変更したことを知らせる(画面を更新する)
                setState(() {
                  // データを変更
                  _text = value;
                });
              },
            ),
            const SizedBox(height: 8),
            SizedBox(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // Saveボタン
              child: ElevatedButton(
                onPressed: () {
                  // "pop"で前の画面に戻る
                  // "pop"の引数から前の画面にデータを渡す
                  Navigator.of(context).pop(_text);
                },
                child: const Text("Save", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // Cancelボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
            ),
          ],
        ),
      ),),
    );
  }
}
