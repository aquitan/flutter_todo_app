class Todo {
  String id;
  String todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false
  });

  static List <Todo> todoList() {
    return [
      Todo(id: '1', todoText: 'buy food', isDone: true),
      Todo(id: '2', todoText: 'buy shampoo'),
      Todo(id: '3', todoText: 'buy snaks'),
      Todo(id: '4', todoText: 'buy tea'),
      Todo(id: '5', todoText: 'buy soda'),
      Todo(id: '6', todoText: 'make food'),
      Todo(id: '7', todoText: 'learn flutter and dart'),
    ];
  }
}