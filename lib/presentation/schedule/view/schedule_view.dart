import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/presentation/resources/color_manager.dart';
import 'package:to_do_app/presentation/resources/string_manager.dart';
import 'package:to_do_app/presentation/resources/value_manger.dart';
import 'package:to_do_app/presentation/schedule/cubit/schedule_cubit.dart';

import '../cubit/schedule_states.dart';
import '../widgets/task_card_item.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key? key, required this.database}) : super(key: key);
  final Database database;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.scheduleTitle),
      ),
      body: BlocConsumer<ScheduleCubit, ScheduleCubitStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ScheduleCubit cubit = ScheduleCubit.get(context);

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(AppPadding.p8),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: TableCalendar<TaskModel>(
                    calendarFormat: CalendarFormat.week,
                    headerVisible: false,
                    calendarStyle: CalendarStyle(
                      markersMaxCount: 10,
                      markerDecoration: BoxDecoration(
                        color: ColorManager.darkGrey,
                        shape: BoxShape.circle
                      ),
                        todayDecoration: BoxDecoration(
                            color: ColorManager.primary,
                               shape: BoxShape.circle
                            ),
                        selectedDecoration: BoxDecoration(
                            color: ColorManager.cyan  , shape: BoxShape.circle)),
                    focusedDay: cubit.focusedDay,
                    firstDay: DateTime.utc(2010, 1, 1),
                    lastDay: DateTime.utc(2050, 1, 1),
                    onPageChanged: (day) {
                      cubit.focusedDay = day;
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      cubit.selectDay(selectedDay, focusedDay, context);
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(cubit.selectedDay, day);
                    },
                    eventLoader: (day)=>cubit.getEventsForDay(day)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat("EEEE").format(cubit.focusedDay)),
                      Text(DateFormat("yyyy-MM-dd").format(cubit.focusedDay)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.separated(
                      itemCount: cubit.allTasks.length,
                      itemBuilder: (context, index) {
                        print('length ' + cubit.allTasks.length.toString());

                        return TaskCardItem(
                          title: cubit.allTasks[index]['title'],
                          time: cubit.allTasks[index]['startTime'],
                          color: cubit.allTasks[index]['color'],
                          isCompleted: cubit.allTasks[index]['isCompleted'],
                          id: cubit.allTasks[index]['id'],
                        );
                      },
                      separatorBuilder: (context, inedx) => const SizedBox(
                        height: AppSize.s12,
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
