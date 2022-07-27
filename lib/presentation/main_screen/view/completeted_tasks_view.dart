import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/value_manger.dart';
import '../cubit/main_cubit.dart';
import '../cubit/main_cubit_states.dart';
import 'widgets/complete_task_item.dart';
import 'widgets/task_item.dart';

class CompletedTasksView extends StatelessWidget {
  const CompletedTasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return CompleteTaskItem(
                taskTitle: cubit.completedTasks[index]['title'],
                taskColor: cubit.completedTasks[index]['color'],
                isCompleted: cubit.completedTasks[index]['isCompleted'],
                isFavourited: cubit.completedTasks[index]['isFavourited'],
                startDate: cubit.completedTasks[index]['startTime'],
                endDate: cubit.completedTasks[index]['endTime'],
                id: cubit.completedTasks[index]['id'],
              );
            },
            itemCount: cubit.completedTasks.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: AppSize.s12,
              );
            },
          );
        });
  }
}
