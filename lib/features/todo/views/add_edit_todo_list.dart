import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/Theme/app_color.dart';
import 'package:todo_app/core/utils/app_string.dart';
import 'package:todo_app/core/utils/custome_snackbar.dart';
import 'package:todo_app/core/utils/full_screen_dialog_loader.dart';
import 'package:todo_app/core/widget/custome_text_form_field.dart';
import 'package:todo_app/core/widget/rounded_button.dart';
import 'package:todo_app/features/todo/cubit/todo_cubit.dart';

class AddEditTodoList extends StatefulWidget {
  const AddEditTodoList({super.key});

  @override
  State<AddEditTodoList> createState() => _AddEditTodoListState();
}

class _AddEditTodoListState extends State<AddEditTodoList> {
  // global key and text edit controller.
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleEditController, _descriptionEditController;
  late bool isCompleted;

  // init the state of the given parameter.
  @override
  void initState() {
    super.initState();
    _titleEditController = TextEditingController();
    _descriptionEditController = TextEditingController();
    isCompleted = false;
  }

  // dispose the text and description edit controller.
  @override
  void dispose() {
    _titleEditController.dispose();
    _descriptionEditController.dispose();
    super.dispose();
  }

  // clear the text and description form fields.
  void _clearText() {
    _titleEditController.clear();
    _descriptionEditController.clear();
  }

  void _sumit() {
    if (_formKey.currentState!.validate()) {
      final title = _titleEditController.text;
      final description = _descriptionEditController.text;
      context
          .read<TodoCubit>()
          .addTodo(title: title, description: description, isComplete: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.addTodo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<TodoCubit, TodoState>(
          listener: (context, state) {
            if (state is TodoAddEditDeleteLoading) {
              FullScreenDialogLoader.show(context);
            } else if (state is TodoAddEditDeleteSuccess) {
              FullScreenDialogLoader.cancel(context);
              _clearText();
              CustomeSnackbar.showSuccess(context, AppString.todoCreate);
            } else if (state is TodoError) {
              FullScreenDialogLoader.cancel(context);
              CustomeSnackbar.showError(context, state.error);
            }
          },
          builder: (context, state) {
            return Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomeTextFormField(
                        controller: _titleEditController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppString.required;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        hintText: AppString.title,
                        suffix: null),
                    // spacing between the title and description.
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeTextFormField(
                        controller: _descriptionEditController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppString.required;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        hintText: AppString.description,
                        suffix: null),
                    // spacing between the button  and description.
                    const SizedBox(
                      height: 10,
                    ),
                    RoundedButton(
                        buttonText: AppString.add,
                        onPressed: () {
                          _sumit();
                        },
                        color: AppColor.appColor)
                  ],
                ));
          },
        ),
      ),
    );
  }
}
