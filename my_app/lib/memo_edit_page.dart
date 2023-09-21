import 'package:flutter/material.dart';

/// メモリスト編集画面用Widget
class MemoEditPage extends StatefulWidget {
  const MemoEditPage(this.text, {super.key});
  final String text;
  @override
  MemoEditPageState createState() => MemoEditPageState();
}

class MemoEditPageState extends State<MemoEditPage> {
  String _text = "";

  @override
  void initState() {
    super.initState();
    // 画面遷移時に渡された値を初期値に設定する
    _text = widget.text;
  }

  // データを元に表示するWidget
  @override
  Widget build(BuildContext context) {
    // 初期値を設定する
    final controller = TextEditingController(text: _text);
    // TextEditingControllerに設定したテキストのlengthをカーソルの位置に設定する
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoEdit'),
      ),
      body: SingleChildScrollView(child:Container(
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
              controller: controller,
              // 入力されたテキストの値を受け取る(valueが入力されたテキスト)
              onChanged: (String value) {
                // データを変更したことを知らせる(画面を更新する)
                setState(() {
                  // データを変更
                  controller.text = value;
                  _text = value;
                });
              },
            ),
            const SizedBox(height: 8),
            SizedBox(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // Editボタン
              child: ElevatedButton(
                onPressed: () {
                  // "pop"で前の画面に戻る
                  // "pop"の引数から前の画面にデータを渡す
                  Navigator.of(context).pop(_text);
                },
                child: const Text("Edit", style: TextStyle(color: Colors.white)),
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
