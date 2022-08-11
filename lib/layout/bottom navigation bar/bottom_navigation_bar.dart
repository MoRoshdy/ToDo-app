// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';


class BottomNavBar extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var dateController = TextEditingController();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var scaffoldkey = GlobalKey<ScaffoldState>();

  BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertToDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentindex],
              ),
            ),
            body: state is AppGetDatabaseLoadingState
                ? const Center(child: CircularProgressIndicator())
                : cubit.screens[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentindex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: 'Archive',
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // insertToDatabase();

                if (cubit.isBottomSheetShown) {
                  if (formkey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );
                    // insertToDatabase(
                    //   title: titleController.text,
                    //   date: dateController.text,
                    //   time: timeController.text,
                    // ).then((value) {
                    //   getDataFromDatabase(database).then((value) {
                    //     Navigator.pop(context);
                    //
                    //     // setState(() {
                    //     //   isBottomSheetShown = false;
                    //     //   fabIcon = Icons.edit;
                    //     //
                    //     //   tasks = value;
                    //     // });
                    //   });
                    // });
                  }
                } else {
                  scaffoldkey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                      padding: const EdgeInsets.all(20.0),
                      color: Colors.white,
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                              keyboardtype: TextInputType.text,
                              controller: titleController,
                              labeltext: 'Task Title',
                              prefix: Icons.title,
                              onSubmit: (value) {
                                print(value);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'title must not be empty';
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              keyboardtype: TextInputType.datetime,
                              controller: timeController,
                              labeltext: 'Task Time',
                              prefix: Icons.watch_later_outlined,
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text =
                                      value!.format(context);
                                  print(value.format(context));
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'time must not be empty';
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              keyboardtype: TextInputType.datetime,
                              controller: dateController,
                              labeltext: 'Task Date',
                              prefix: Icons.calendar_today,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2022-05-03'),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                  print(DateFormat.yMMMd().format(value));
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'date must not be empty';
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 20.0,
                  )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheet(isShown: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheet(isShown: true, icon: Icons.add);
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
          );
        },
      ),
    );
  }
}
