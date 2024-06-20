import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/configs/di/injection.dart';
import 'package:todo/core/utils/extentions.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_textfield.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/view_model/cubit/todo_cubit.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({
    super.key,
  });

  @override
  State<AddToDoScreen> createState() => _AddToDOScreenState();
}

class _AddToDOScreenState extends State<AddToDoScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<TodoCubit, TodoState>(
        listener: (context, state) {
          if (state is TodoFailure) {
            log(state.failure.message);
          }

          if (state is TodoCreated) {
            log("created");
            Navigator.of(context).pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      15.hs,
                      CustomTextField(
                        controller: titleController,
                        label: "Title",
                        hintText: "eg - Eat breakfast",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Title is required";
                          }
                          return null;
                        },
                      ),
                      15.hs,
                      CustomTextField(
                        controller: descriptionController,
                        label: "Description",
                        hintText: "Optional",
                        maxLine: 4,
                        maxLength: 500,
                      ),
                      80.hs,
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: BlocBuilder<TodoCubit, TodoState>(
                      builder: (context, state) {
                        return CustomButton(
                          isLoading: state is TodoLoading,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              createTodo();
                            }
                          },
                          label: "Create",
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  createTodo() {
    Todo todo = Todo(
        id: uuid.v4(),
        title: titleController.text,
        description: descriptionController.text,
        isCompleted: false);

    context.read<TodoCubit>().createNewTodo(todo);
  }
}
