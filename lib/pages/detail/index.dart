import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo.dart';
import '../../models/todo_list.dart';

class DetailPage extends StatefulWidget {
  DetailPage(this._isCreate, {String curId}) {
    this._curId = curId;
  }

  final bool _isCreate;
  String _curId;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isCreate;
  String _task;
  String _curId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isCreate = widget._isCreate;
    _curId = widget._curId;
  }

  @override
  Widget build(BuildContext context) {
    TodoList list = Provider.of<TodoList>(context);
    return Scaffold(
      appBar: AppBar(
        title: _isCreate ? Text('新增Todo') : Text('Todo详情页'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pushNamed('/'),
        ),
      ),
      body: _isCreate ?
      Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: '任务',
                prefixIcon: Icon(Icons.article),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '必须填写';
                }
                return null;
              },
              onSaved: (value) {
                _task = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    print(_task);
                    list.add(new Todo(
                      task: _task,
                      time: new DateTime.now(),
                      complete: false,
                    ));
                    Navigator.of(context).pushNamed('/');
                  }  
                },
                child: Text('提交'),
              ),
            )
          ],
        ),
      ) :
      Column(
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Text('任务：', style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text('${list.getById(_curId).task}', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text('任务状态：', style: TextStyle(fontSize: 16)),
                  Text('${list.getById(_curId).complete ? '已完成' : '未完成'}', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text('任务创建时间：', style: TextStyle(fontSize: 16), textAlign: TextAlign.left),
                  Text('${list.getById(_curId).time}', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
