import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/todo_item.dart';

import '../models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todosList = Todo.todoList();
  final _todoController = TextEditingController();
  List<Todo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todosList;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ToDo App'),
          leading: const Icon(Icons.menu),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SearchBox(onSearch: _runFilter,),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: const Text(
                            'ToDo List',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w500),
                          ),
                        ),
                        for (Todo todo in _foundToDo.reversed) TodoItem(
                          todo: todo,
                          onTodoChanged: _handleToDoChange,
                          onDeleteItem: _handleDeleteTodo,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      margin:
                          const EdgeInsets.only(bottom: 40, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 10,
                            spreadRadius: 0)
                      ]),
                      child: TextField(
                        controller: _todoController,
                        decoration: const InputDecoration(
                          hintText: 'Add a new todo',
                          border: InputBorder.none
                        ),
                      ),
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40, right: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(10),
                        minimumSize: WidgetStateProperty.all(
                          const Size(40, 50)
                        ),
                        backgroundColor: const WidgetStatePropertyAll(Colors.blue),
                        overlayColor: const WidgetStatePropertyAll(Colors.green),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                        )
                      ),
                      onPressed: () {
                        _addToDoItem(_todoController.text);
                      }, child: const Icon(Icons.add, color: Colors.white,),
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
  void _handleToDoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteTodo(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String text) {
    setState(() {
      todosList.add(Todo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        todoText: text));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> results = [];

    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList.where((item) => item.todoText.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

}



class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key, this.onSearch,
  });

  final onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: TextField(
        onChanged: (value) => onSearch(value),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[500],
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 20, minWidth: 25)),
      ),
    );
  }
}
