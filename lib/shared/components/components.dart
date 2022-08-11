// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';


Widget defaultFormField({
  bool obscure = false,
  required TextInputType keyboardtype,
  required TextEditingController controller,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  required String labeltext,
  required IconData? prefix,
  IconData? suffix,
  required FormFieldValidator<String> validator,
  VoidCallback? suffixpressed,
}) =>
    TextFormField(
      obscureText: obscure,
      keyboardType: keyboardtype,
      controller: controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labeltext,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixpressed,
          icon: Icon(suffix),
        )
            : null,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 35.0,
          child: Text('${model['time']}'),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        IconButton(
          onPressed: ()
          {
            AppCubit.get(context).updateData(status: 'done', id: model['id'],);
          },
          icon: const Icon(Icons.check_box,),
          color: Colors.green,
        ),
        IconButton(
          onPressed: ()
          {
            AppCubit.get(context).updateData(status: 'archive', id: model['id']);
          },
          icon: const Icon(Icons.archive,),
          color: Colors.black45,
        ),
      ],
    ),
  ),
  onDismissed: (direction) {
    AppCubit.get(context).deleteData(id: model['id']);
  },
);
