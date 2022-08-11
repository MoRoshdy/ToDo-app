import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({Key? key}) : super(key: key);



  @override
  _DoneTasksState createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;

        return tasks.isEmpty ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.menu,
                size: 100.0,
                color: Colors.grey,
              ),
              Text(
                'No Tasks Yet, please add some tasks',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ) : ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
            separatorBuilder: (context, index) => Divider(
              thickness: 5.0,
              color: Colors.grey[300],
            ),
            itemCount: tasks.length);
      },
    );
  }
}
