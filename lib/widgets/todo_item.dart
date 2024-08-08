import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final Todo? todo;
  final onTodoChanged;
  final onDeleteItem;

  const TodoItem({
    super.key, required this.todo, required this.onTodoChanged, required this.onDeleteItem,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.white,
        leading: Icon(
          todo!.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue
        ),
        title: Text(todo!.todoText, style: TextStyle(
          fontSize: 18,
          decoration: todo!.isDone ? TextDecoration.lineThrough : TextDecoration.none
        ),),
        trailing: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            onPressed: () {
              onDeleteItem(todo!.id);
            },
            icon: const Icon(Icons.delete),
            color: Colors.white,
            iconSize: 18,
          ),
        ),
      ),
    );
  }
}
