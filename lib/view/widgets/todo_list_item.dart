import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todo/core/utils/extentions.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/view/screens/todo_details_screen.dart';
import 'package:todo/view_model/cubit/todo_cubit.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({
    super.key,
    required this.todo,
  });
  final Todo todo;

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.todo.id),
      direction: Axis.horizontal,
      closeOnScroll: true,
      endActionPane:
          ActionPane(motion: const ScrollMotion(), extentRatio: 0.2, children: [
        SlidableAction(
          flex: 1,
          onPressed: (context) => deleteTodo(context),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
        ),
      ]),
      child: InkWell(
        onTap: () => navigateToDetailsScreen(context),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(16, 24, 40, 0.05),
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(0, 1),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                activeColor: Colors.grey.shade400,
                onChanged: (value) {
                  if (value!) {
                    context.read<TodoCubit>().markAsCompleted(widget.todo.id);
                  } else {
                    context.read<TodoCubit>().markAsUnCompleted(widget.todo.id);
                  }
                },
                value: widget.todo.isCompleted,
              ),
              10.ws,
              Expanded(
                child: Text(
                  widget.todo.title.capitalizeFirstLetter(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.titleMedium!.copyWith(
                    color: widget.todo.isCompleted
                        ? Colors.grey.shade700
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  navigateToDetailsScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TodoDetailsScreen(todo: widget.todo),
    ));
  }

  deleteTodo(BuildContext context) {
    context.read<TodoCubit>().deleteTodo(widget.todo.id);
    // Navigator.of(context).pop();
  }
}
