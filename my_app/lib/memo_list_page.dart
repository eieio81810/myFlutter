// メモリスト画面用Widget
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_app/memo_add_page.dart';
import 'package:my_app/memo_edit_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoListPage extends StatefulWidget {
  const MemoListPage({super.key});

  @override
  MemoListPageState createState() => MemoListPageState();
}

class MemoListPageState extends State<MemoListPage> {
  // メモデータ
  List<String> memoList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  // アプリ起動時に保存したデータを読み込む
  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      memoList = prefs.getStringList("memoList")??[]; // リストが1個もない時、空のリスト入れる
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: const Text("MemoList"),
      ),
      // データを元にListViewを作成
      body: ListView.builder(
        itemCount: memoList.length,
        itemBuilder: (context, index) {
          // インデックスに対応するメモを取得する
          return Slidable(
            // 右方向にリストアイテムをスライドした場合の設定
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    final prefs = await SharedPreferences.getInstance();
                    // contextを渡す前に、contextが現在のWidgetツリー内に存在しているかどうかチェック
                    // 存在しなければ、画面遷移済を意味するので、以降の画面遷移処理は行わない
                    if (!mounted) return;
                    // "push"で新規画面に遷移
                    // メモ編集画面から渡される値を受け取る
                    final editText = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MemoEditPage(memoList[index])),
                    );
                    if (editText != null) {
                      // キャンセルした場合は、newListText が null となるため注意
                      setState(() {
                        // リスト追加
                        memoList[index] = editText;
                      });
                    }
                    prefs.setStringList("memoList", memoList);
                  },
                  backgroundColor: Colors.brown,
                  icon: Icons.edit,
                ),
              ],
            ),
            child: Card(
              child: ListTile(
                title: Text(memoList[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  iconSize: 20,
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() {
                      memoList.removeAt(index);
                      prefs.setStringList("memoList", memoList);
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          // contextを渡す前に、contextが現在のWidgetツリー内に存在しているかどうかチェック
          // 存在しなければ、画面遷移済を意味するので、以降の画面遷移処理は行わない
          if (!mounted) return;
          // "push"で新規画面に遷移
          // メモ追加画面から渡される値を受け取る
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてメモ追加画面を指定
              return const MemoAddPage();
            }),
          );
          if (newListText != null) {
            // キャンセルした場合は、newListText が null となるため注意
            setState(() {
              // リスト追加
              memoList.add(newListText);
            });
          }
          prefs.setStringList("memoList", memoList);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
