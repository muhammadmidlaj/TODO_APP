import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:todo/core/utils/extentions.dart';

import 'package:todo/core/utils/typedefs.dart';

import 'package:todo/view/widgets/todo_list_item.dart';
import 'package:todo/view_model/cubit/todo_cubit.dart';

class CompletedTaskCard extends StatelessWidget {
  const CompletedTaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: context.read<TodoCubit>().watchCompletedTodos(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverToBoxAdapter(
                child: Center(child: CupertinoActivityIndicator()));
          }

          if (snapshot.hasData) {
            TodoList todos = snapshot.data!;
            if (todos.isEmpty) {
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
            }
            return MultiSliver(
              children: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(10),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "COMPLETED",
                          style: context.theme.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => TodoListItem(
                     
                      todo: todos[index],
                    ),
                    childCount: todos.length,
                  ),
                ),
              ],
            );
          }

          return const SliverToBoxAdapter(
            child: Text("data"),
          );
        });
  }
}
