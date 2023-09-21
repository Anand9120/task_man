import 'package:flutter/material.dart';
import 'package:task_man/constants/colors.dart';
import 'package:task_man/models/todo.dart';
import 'package:task_man/widgets/todo_item.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todosList = Todo.todoList();
  final _todoController=TextEditingController();
  List<Todo> _foundTodo=[];
@override
  void initState() {
   _foundTodo=todosList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          onPressed: () {

          }, icon: const Icon(Icons.menu, color: black,),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/img.png'),),
          )
        ],
        title: const Text('Todo App', style: TextStyle(color: red),),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
          children: [Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child:
            Column(
              children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ( TextField(
                      onChanged: (value)=>_runFilter(value),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          prefixIcon: Icon(
                            Icons.search, color: black, size: 25,),
                          prefixIconConstraints: BoxConstraints(
                              maxHeight: 20, minWidth: 25
                          ),
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: grey, fontSize: 20)

                      ),

                    ))
                ), Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child:
                        const Text('All ToDos',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight
                              .w500),),
                      ),
                      for(Todo todo in _foundTodo.reversed)
                        TodoItem(todo: todo, onTodoChanged: _handleTodoChange,onDeleteItem:_deleteTodoItem,),

                    ],
                  ),
                )
              ],
            ),
          ),
            Align(alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(child: Container(
                    margin: const EdgeInsets.only(
                        bottom: 20, left: 20, right: 20
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [ BoxShadow(
                          color: Colors.grey, blurRadius: 10.0,
                          spreadRadius: 0.0, offset: Offset(0.0, 0.0)
                      )
                      ], borderRadius: BorderRadius.circular(10),


                    ),
                    child:  TextField(controller: _todoController,
                      decoration: const InputDecoration(
                          hintText: 'Add new todo item',
                          border: InputBorder.none
                      ),
                    ),
                  )
                  ),
                  Container(margin: const EdgeInsets.only(bottom: 20, right: 20),

                    child: ElevatedButton(
                      child: const Text('+', style: TextStyle(fontSize: 40),
                      ),
                      onPressed: () {
                        _addTodoItem(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(60, 60),
                          primary: blue, elevation: 10
                      ),
                    ),

                  )

                ],),
            )
          ]
      ),

    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {


    todo.isDone = !todo.isDone;
    });
  }
  void _deleteTodoItem(String id){
    setState(() {
      todosList.removeWhere((item) => item.id==id);
    });

  }
  void _addTodoItem(String todo){
    setState(() {
    todosList.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo)
    );
    });
    _todoController.clear();
  }
  void _runFilter(String enteredKeyword){
  List<Todo> result=[];
  if(enteredKeyword.isEmpty){
    result=todosList;
  }else{
    result=todosList.where((element) => element.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
  }
  setState(() {
    _foundTodo=result;
  });
  }
}