import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/presentation/main_screen/view/widgets/task_item.dart';

import '../../resources/value_manger.dart';
import '../cubit/main_cubit.dart';
import '../cubit/main_cubit_states.dart';
import 'widgets/complete_task_item.dart';

class UnCompletedTasksView extends StatelessWidget {
  const UnCompletedTasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return CompleteTaskItem(
                taskTitle: cubit.uncompletedTasks[index]['title'],
                taskColor: cubit.uncompletedTasks[index]['color'],
                isCompleted: cubit.uncompletedTasks[index]['isCompleted'],
                isFavourited: cubit.uncompletedTasks[index]['isFavourited'],
                id: cubit.uncompletedTasks[index]['id'],
                startDate: cubit.uncompletedTasks[index]['startTime'],
                endDate: cubit.uncompletedTasks[index]['endTime'],
              );
            },
            itemCount: cubit.uncompletedTasks.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: AppSize.s12,
              );
            },
          );
        });
  }
}
