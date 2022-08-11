


// ignore_for_file: deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/bloc_observer.dart';

import 'layout/bottom navigation bar/bottom_navigation_bar.dart';

void main() {
  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}
