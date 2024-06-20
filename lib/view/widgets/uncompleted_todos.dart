import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/core/constants/image_constants.dart';

import 'package:todo/core/utils/extentions.dart';
import 'package:todo/core/utils/typedefs.dart';
import 'package:todo/view/widgets/todo_list_item.dart';
import 'package:todo/view_model/cubit/todo_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UncompletedTodos extends StatelessWidget {
  const UncompletedTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: context.read<TodoCubit>().watchAllTodos(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverToBoxAdapter(
                child: Center(child: CupertinoActivityIndicator()));
          }
          if (snapshot.hasData) {
            TodoList todos = snapshot.data!;
            if (todos.isEmpty) {
              return SliverToBoxAdapter(
                child: Column(
                  children: [
                    20.hs,
                    SvgPicture.asset(
                      ImageConstants.imgNotePad,
                      height: 150,
                      width: 150,
                    ),
                    10.hs,
                    Text(
                      "It's all clear. Have a rest",
                      style: context.theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.grey.shade400),
                    ),
                    20.hs,
                  ],
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => TodoListItem(
                  todo: todos[index],
                ),
                childCount: todos.length,
              ),
            );
          }

          return Text(snapshot.connectionState.toString());
        });
  }
}
