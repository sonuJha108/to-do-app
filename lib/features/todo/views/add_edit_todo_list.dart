import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/core/Theme/app_color.dart';
import 'package:todo_app/core/utils/app_string.dart';
import 'package:todo_app/core/widget/custome_text_form_field.dart';
import 'package:todo_app/core/widget/rounded_button.dart';

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
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.addTodo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
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
                      _clearText();
                    },
                    color: AppColor.appColor)
              ],
            )),
      ),
    );
  }
}
