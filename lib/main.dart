import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/board/board_screen.dart';
import 'package:todo_app/presentation/board/task_cubit.dart';
import 'package:todo_app/presentation/schedule/schedule_cubit.dart';
import 'package:todo_app/utils/shared/CacheHelper.dart';
import 'package:todo_app/utils/shared/observ.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  BlocOverrides.runZoned(
    () {
      TaskCubit();
      SchedulCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        home: BoardView(),
      ),
    );
  }
}
