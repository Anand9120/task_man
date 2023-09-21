import 'package:flutter/material.dart';
import 'package:task_man/constants/colors.dart';
import 'package:task_man/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final onTodoChanged;
  final onDeleteItem;
  const TodoItem({super.key, required this.todo,required this.onTodoChanged, required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
onTodoChanged(todo);
        },shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        tileColor: Colors.white,
        leading:  Icon( todo.isDone ?Icons.check_box:Icons.check_box_outline_blank,color: blue),
        title: Text(todo.todoText!,style: TextStyle(decoration:todo.isDone? TextDecoration.lineThrough:null,fontSize: 20,color: black),),trailing: Container
        (margin: EdgeInsets.symmetric(vertical: 10),padding: EdgeInsets.all(0),
          height: 35,width: 35,

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: red),child: IconButton(
    onPressed: (){
onDeleteItem(todo.id);
    },
          icon:Icon(
            Icons.delete,color: Colors.white,),iconSize: 20,
        ))
      ),

    );
  }
}