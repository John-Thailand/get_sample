import 'package:flutter/material.dart';
import 'package:get/get.dart';

// MaterialApp を GetMaterialAppに置き換える
void main() {
  // Get.put() を使ってクラスをインスタンス化し、配下のウィジェットで利用できるようにする。
  // ほとんど全ページで使うコントローラーである場合、main()でrunApp()する前にGet.putする。
  final Controller c = Get.put(Controller());
  runApp(GetMaterialApp(home: Home()));
}

class Controller extends GetxController {
  // obs（observer：観察者） をつけると変更を監視できるようになる。
  var count = 0.obs;
  increment() => count++;
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 他のページで使われているコントローラーを見つけて、それを使用できる。
    final Controller c = Get.find();

    return Scaffold(
      // カウントが変更されるたびに Text()を更新する
      // そのためにObx(() => を使用します。
      appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

      // Get.to()で画面遷移ができる。Navigatorに比べたらめちゃくちゃ簡単
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.to(Other()),
          child: const Text("Go to Other"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => c.increment(),
      ),
    );
  }
}

class Other extends StatelessWidget {
  // 他のページで使われているコントローラーを見つけて、それを使用できる。
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    // 更新された変数にアクセス
    return Scaffold(
      body: Center(
        child: Text("${c.count}"),
      ),
    );
  }
}
