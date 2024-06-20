import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:todo/configs/di/injection.dart';
import 'package:todo/view/screens/home_screen.dart';
import 'package:todo/view_model/cubit/todo_cubit.dart';

void main() async {
  await initDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TodoCubit>(),
      child: OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ToDo',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF009973)),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
