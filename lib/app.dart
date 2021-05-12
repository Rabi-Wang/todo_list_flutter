import 'package:flutter/material.dart';
import 'pages/detail/index.dart';
import 'pages/list/index.dart';
import 'models/todo_list.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoList()),
      ],
      child: MaterialApp(
        title: 'flutter todo list',
        initialRoute: '/',
        routes: {
          '/': (context) => ListPage(),
          '/list': (context) => ListPage(),
          '/detail': (context) => DetailPage(false),
          '/edit': (context) => DetailPage(true),
        },
      ),
    );
  }
}
