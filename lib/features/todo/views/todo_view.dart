import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/Theme/app_color.dart';
import 'package:todo_app/core/routes/name_routes.dart';
import 'package:todo_app/core/utils/app_string.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.todo),
        actions: [
          IconButton(
            // move to profile screen.
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Container(),

      // button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(RoutesName.addTodo);
        },
        backgroundColor: AppColor.appColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
