import 'package:uuid/uuid.dart';

class Todo {
  bool complete;
  final String id;
  final DateTime time;
  String task;

  Todo({
    this.task,
    this.complete = false,
    DateTime time,
    String id
  }) : this.time = time ?? DateTime.now(), this.id = id ?? Uuid().v4();

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $time, id: $id }';
  }
}
