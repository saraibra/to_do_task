import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/presentation/add_task/widgets/default_button.dart';
import 'package:to_do_app/presentation/main_screen/cubit/main_cubit.dart';
import 'package:to_do_app/presentation/main_screen/view/all_tasks_view.dart';
import 'package:to_do_app/presentation/main_screen/view/completeted_tasks_view.dart';
import 'package:to_do_app/presentation/main_screen/view/favourites_view.dart';
import 'package:to_do_app/presentation/main_screen/view/uncompleted_tasks_view.dart';
import 'package:to_do_app/presentation/resources/color_manager.dart';
import 'package:to_do_app/presentation/resources/value_manger.dart';
import 'package:to_do_app/presentation/schedule/cubit/schedule_cubit.dart';
import 'package:to_do_app/presentation/schedule/view/schedule_view.dart';

import '../../add_task/view/add_task.dart';
import '../../resources/string_manager.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.boardTitle),
          actions: [
            IconButton(
                onPressed: () {
                  ScheduleCubit.get(context).getTasksFromDataBase(
                      context,
                      DateFormat("yyyy-MM-dd").format(DateTime.now()) +
                          " 00:00:00.000");

                  navigateTo(
                      context,
                      ScheduleView(
                        database: MainCubit.get(context).database,
                      ));
                },
                icon: const Icon(Icons.calendar_today_outlined)),
          ],
          bottom: TabBar(
            labelColor: ColorManager.black,
            indicatorColor: ColorManager.primary,
            unselectedLabelColor: ColorManager.grey,
            labelPadding: const EdgeInsets.all(AppSize.s0),
            tabs: const [
              Tab(
                text: AppStrings.all,
              ),
              Tab(
                text: AppStrings.completed,
              ),
              Tab(
                text: AppStrings.uncompleted,
              ),
              Tab(
                text: AppStrings.favourite,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              const Expanded(
                child: TabBarView(children: [
                  AllTasksView(),
                  CompletedTasksView(),
                  UnCompletedTasksView(),
                  FavouritesView()
                ]),
              ),
              DefaultButton(
                  text: AppStrings.addTask,
                  onPressed: () {
                    navigateTo(context, AddTask());
                  })
            ],
          ),
        ),
      ),
    );
  }

  void navigateTo(context, widget) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );
}
