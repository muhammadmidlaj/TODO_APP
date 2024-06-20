import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/core/utils/extentions.dart';
import 'package:todo/core/utils/toast_components.dart';

import 'package:todo/view/screens/add_todo_screen.dart';
import 'package:todo/view/widgets/completed_task_card.dart';

import 'package:todo/view/widgets/uncompleted_todos.dart';
import 'package:todo/view_model/cubit/todo_cubit.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoCreated) {
          "Todo created successfully".showMessage(ToastType.success);
        }

        if (state is TodoFailure) {
          state.failure.message.showMessage(ToastType.error);
        }

        if (state is TodoDeleted) {
          "Deleted Successfully".showMessage(ToastType.success);
        }

        if (state is TodoUpdated) {
          "Updated Successfully".showMessage(ToastType.success);
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: Text(
            "👋 Welcome",
            style: context.theme.textTheme.titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.theme.primaryColor,
          foregroundColor: Colors.white,
          onPressed: () => navigateToAddTodoScreen(context),
          child: const Icon(Icons.add),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CustomScrollView(
              slivers: [
                const UncompletedTodos(),
                SliverToBoxAdapter(
                  child: 20.hs,
                ),
                const CompletedTaskCard()
              ],
            )),
      ),
    );
  }

  navigateToAddTodoScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const AddToDoScreen(),
    ));
  }
}
