import 'package:flutter/foundation.dart';
import 'todo.dart' show Todo;

class TodoList with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, Todo> _list = new Map();

  Map<String, Todo> get list => _list;

  void add(Todo todo) {
    _list[todo.id] = todo;
    notifyListeners();
  }

  void remove(String id) {
    _list.remove(id);
    notifyListeners();
  }

  void statusChange(Todo todo) {
    todo.complete = !todo.complete;
    _list.update(todo.id, (value) => todo);
    notifyListeners();
  }

  Todo getById(String id) {
    return _list[id];
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement debugFillProperties
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('todo', _list));
  }
}