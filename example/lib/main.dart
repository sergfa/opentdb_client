import 'package:flutter/material.dart';
import 'package:opentdb_client/opentdb_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<OpentdbQuizItem> items = [];
  List<OpentdbCategoryItem> catItems = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onPressed() async {
    //List<OpentdbQuizItem> quizItems = await fetchQuiz();
    setState(() {
      this.catItems = OpentdbRepository.fetchCategories();
      /*if (quizItems != null) {
        items = quizItems;
      }*/
    });
  }

  Future<List<OpentdbQuizItem>> fetchQuiz() async {
    List<OpentdbQuizItem> quizItems;
    final List<OpentdbCategoryItem> categories =
        OpentdbRepository.fetchCategories();
    final OpentdbCategoryItem quizCategory =
        categories.where((element) => element.name == 'Film').first;
    try {
      quizItems = await OpentdbRepository.fetchQuiz(
        category: quizCategory.id,
        amount: 20,
        difficulty: OpentdbQuizDifficalty.EASY,
        type: OpentdbQuizType.MULTIPLE,
      );
    } catch (e) {}
    return quizItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: catItems.length,
          itemBuilder: (context, i) {
            var item = catItems[i];
            return Card(
              child: ListTile(
                title: Text(item.name),
                subtitle: Text('${item.id}'),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
