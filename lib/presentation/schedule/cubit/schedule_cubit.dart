import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/presentation/main_screen/cubit/main_cubit.dart';
import 'package:to_do_app/presentation/schedule/cubit/schedule_states.dart';

import '../../../models/task_model.dart';

class ScheduleCubit extends Cubit<ScheduleCubitStates> {
  ScheduleCubit() : super(AppInitialState());
  static ScheduleCubit get(context) => BlocProvider.of(context);
  List<Map> allTasks = [];
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  Map<DateTime, List<TaskModel>> kEventsSource = {};
  void getTasksFromDataBase(BuildContext context, String date) {
    allTasks = [];
    kEventsSource = {};
    MainCubit.get(context)
        .database
        .rawQuery('SELECT * FROM Tasks WHERE date = ?', [date]).then((value) {
      value.forEach((element) {
        kEventsSource[DateFormat('yyyy-MM-dd hh:mm:ss')
            .parse(element['date'])] = kEventsSource[
                    DateFormat('yyyy-MM-dd hh:mm:ss').parse(element['date'])] !=
                null
            ? [
                ...?kEventsSource[
                    DateFormat('yyyy-MM-dd hh:mm:ss').parse(element['date'])],
                TaskModel.fromMap(element)
              ]
            : [TaskModel.fromMap(element)];
        allTasks.add(element);
        emit(AppGetDataState());
      });
    });
  }

  String selectedDateText = '';
  void selectDay(
      DateTime selectedDate, DateTime focusedDate, BuildContext context) {
    if (!isSameDay(selectedDay, selectedDate)) {
      focusedDay = focusedDate;
      selectedDay = selectedDate;
      selectedDateText =
          DateFormat("yyyy-MM-dd").format(selectedDate) + " 00:00:00.000";
      getTasksFromDataBase(context, selectedDateText);
      getEventsForDay(selectedDate);
    } else if (isSameDay(selectedDay, focusedDate)) {}
    emit(ChangeDayState());
  }

  List<TaskModel> getEventsForDay(DateTime day) {
    final kEvents = LinkedHashMap<DateTime, List<TaskModel>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(kEventsSource);
    print(allTasks.length);
    return kEvents[day] ?? [];
  }
  int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
}
