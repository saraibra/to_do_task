import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/value_manger.dart';
import '../cubit/main_cubit.dart';
import '../cubit/main_cubit_states.dart';
import 'widgets/complete_task_item.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<MainCubit, MainCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return CompleteTaskItem(
                taskTitle: cubit.favouritedTasks[index]['title'],
                taskColor: cubit.favouritedTasks[index]['color'],
                isCompleted: cubit.favouritedTasks[index]['isCompleted'],
                isFavourited: cubit.favouritedTasks[index]['isFavourited'],
                startDate: cubit.favouritedTasks[index]['startTime'],
                endDate: cubit.favouritedTasks[index]['endTime'],
                id: cubit.favouritedTasks[index]['id'],
              );
            },
            itemCount: cubit.favouritedTasks.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: AppSize.s12,
              );
            },
          );
        });
  }
}
