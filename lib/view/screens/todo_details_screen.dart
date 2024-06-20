import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/dialogues.dart';
import 'package:todo/core/utils/extentions.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/view_model/cubit/todo_cubit.dart';

class TodoDetailsScreen extends StatefulWidget {
  const TodoDetailsScreen({super.key, required this.todo});
  final Todo todo;

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  ValueNotifier<bool> dataChanged = ValueNotifier<bool>(false);
  bool isCompleted = false;

  bool titleChanged = false;
  bool descriptionChanged = false;

  @override
  void initState() {
    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.description ?? "";
    isCompleted = widget.todo.isCompleted;
    super.initState();
    _listenToTitleAndDiscription();
  }

  void discardFunction() {
    Navigator.of(context).pop();

    setState(() {
      discard = true;
    });
    log("step 3 ${dataChanged.value}");
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  bool discard = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoStatusChanged) {
          setState(() {
            isCompleted = state.status;
          });
        }
      },
      child: PopScope(
        canPop: discard,
        onPopInvoked: (didPop) {
          !discard
              ? WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDiscard(context,
                      "You will loose all the changes made to this todo", () {
                    discardFunction();
                  });
                })
              : null;
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              ValueListenableBuilder(
                valueListenable: dataChanged,
                builder: (context, value, _) {
                  return value
                      ? IconButton(
                          onPressed: () => updateTodo(context),
                          icon: const Icon(Icons.done))
                      : IconButton(
                          onPressed: () => deleteTodo(context),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ));
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    style: context.theme.textTheme.titleLarge!.copyWith(
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null),
                    maxLength: 100,
                    maxLines: 3,
                    minLines: 1,
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Task Title",
                        counterText: '',
                        hintStyle: context.theme.textTheme.titleLarge),
                  ),
                  TextField(
                    controller: descriptionController,
                    style: context.theme.textTheme.bodyLarge,
                    maxLines: 12,
                    minLines: 4,
                    maxLength: 500,
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "add your notes",
                        counterText: '',
                        hintStyle: context.theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.grey)),
                  ),
                  25.hs,
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              children: [
                Checkbox(
                    value: isCompleted,
                    onChanged: (value) async {
                      if (isCompleted) {
                        context
                            .read<TodoCubit>()
                            .markAsUnCompleted(widget.todo.id);
                      } else {
                        context
                            .read<TodoCubit>()
                            .markAsCompleted(widget.todo.id);
                      }
                    }),
                20.ws,
                Text(isCompleted ? "Mark as UnComplete" : "Mark as Complete")
              ],
            ),
          ),
        ),
      ),
    );
  }

  deleteTodo(BuildContext context) {
    showDeleteDialogue(context, "Delete activity?",
        "Are you sure you want to delete this activity", () {
      context.read<TodoCubit>().deleteTodo(widget.todo.id);
      Navigator.of(context)
        ..pop()
        ..pop();
    });
  }

  updateTodo(BuildContext context) {
    Todo todo = Todo(
        id: widget.todo.id,
        title: titleController.text,
        description: descriptionController.text,
        isCompleted: widget.todo.isCompleted);
    context.read<TodoCubit>().updateTodo(todo);
    discard = true;
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _listenToTitleAndDiscription() {
    titleController.addListener(() {
      if (widget.todo.title != titleController.text) {
        titleChanged = true;
        _checkForChanges();
      } else {
        titleChanged = false;
        _checkForChanges();
      }
    });

    descriptionController.addListener(() {
      if (widget.todo.description != descriptionController.text) {
        descriptionChanged = true;
        _checkForChanges();
      } else {
        descriptionChanged = false;
        _checkForChanges();
      }
    });
  }

  void _checkForChanges() {
    if (!titleChanged && !descriptionChanged) {
      dataChanged.value = false;
      setState(() {
        discard = true;
      });
    } else {
      dataChanged.value = true;
      setState(() {
        discard = false;
      });
    }
  }
}
