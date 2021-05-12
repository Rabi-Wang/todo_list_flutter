import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo_list.dart';
import 'package:todo_list/pages/detail/index.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoList list = Provider.of<TodoList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        leading: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/edit'),
      ),
      body: ListView.builder(
        itemCount: list.list.length,
        itemBuilder: (context, index) {
          var v = list.list.values.toList()[index];
          return Card(
            child: Dismissible(
              key: Key(v.id),
              onDismissed: (direction) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('删除了任务${v.task}')));
                list.remove(v.id);
              },
              background: Container(
                color: Colors.red,
                child: ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Icon(v.complete ? Icons.check_circle : Icons.access_time, color: v.complete ? Colors.green : Colors.red,),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: v.complete ?
                        Text('已完成', style: TextStyle(color: Colors.white)) :
                        Text('未完成', style: TextStyle(color: Colors.white)),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: EdgeInsets.only(right: 10, left: 10),
                    ),
                    Container(
                      width: 200,
                      child: Text(v.task, overflow: TextOverflow.ellipsis, maxLines: 1),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(false, curId: v.id))),
                ),
                onTap: () {
                  onPressed: list.statusChange(v);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
