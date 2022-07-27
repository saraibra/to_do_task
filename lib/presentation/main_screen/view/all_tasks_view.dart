import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/presentation/main_screen/cubit/main_cubit.dart';
import 'package:to_do_app/presentation/main_screen/cubit/main_cubit_states.dart';
import 'package:to_do_app/presentation/main_screen/view/widgets/task_item.dart';
import 'package:to_do_app/presentation/resources/string_manager.dart';
import 'package:to_do_app/presentation/resources/value_manger.dart';

class AllTasksView extends StatelessWidget {
  const AllTasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return cubit.allTasks.isEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/tasks.png'),
                  const SizedBox(height: AppSize.s16,),
                  Text(AppStrings.noTasks,
                  style: Theme.of(context).textTheme.displayLarge,
                  )
                ],
              )
              : ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return TaskItem(
                      taskTitle: cubit.allTasks[index]['title'],
                      taskColor: cubit.allTasks[index]['color'],
                      isCompleted: cubit.allTasks[index]['isCompleted'],
                      isFavourited: cubit.allTasks[index]['isFavourited'],
                      id: cubit.allTasks[index]['id'],
                    );
                  },
                  itemCount: cubit.allTasks.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: AppSize.s12,
                    );
                  },
                );
        });
  }
}
