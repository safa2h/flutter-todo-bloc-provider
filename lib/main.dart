import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo4/data/data.dart';
import 'package:todo4/data/repo/repository.dart';
import 'package:todo4/data/source/hive_task_source.dart';

import 'package:todo4/screens/home/home.dart';

const String taskBoxName = 'TaskBox';
const Color primeryColor = Color(0xff794cff);
const Color primeryVarientColor = Color(0xff5c0aff);
const Color normalperiority = Color(0xfff09819);
const Color lowPeriority = Color(0xff3be1f1);
const Color highPeriority = primeryColor;
const Color secondryextcolor = Color(0xffafbed0);

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primeryVarientColor));
  await Hive.initFlutter();
  Hive.registerAdapter(TaskEntityAdapter());
  Hive.registerAdapter(PeriorityAdapter());
  await Hive.openBox<TaskEntity>(taskBoxName);
  runApp(ChangeNotifierProvider<Repository<TaskEntity>>(
      create: (context) =>
          Repository<TaskEntity>(HiveTaskDataSource(Hive.box(taskBoxName))),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final primeryTextcolor = const Color(0xff1d2830);
  final secondryTextcolor = const Color(0xffafbed0);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        colorScheme: ColorScheme.light(
            primary: primeryColor,
            secondary: primeryColor,
            onPrimary: Colors.white,
            background: Color(0xfff3f5f8),
            onSurface: primeryTextcolor,
            onBackground: primeryTextcolor,
            onSecondary: Colors.white),
      ),
      home: HomeScreen(),
    );
  }
}
