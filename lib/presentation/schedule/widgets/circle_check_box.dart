import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/presentation/main_screen/cubit/main_cubit_states.dart';
import 'package:to_do_app/presentation/schedule/cubit/schedule_cubit.dart';

import '../../main_screen/cubit/main_cubit.dart';
import '../../resources/color_manager.dart';
import '../../resources/value_manger.dart';

class CircleCheckBox extends StatelessWidget {
  const CircleCheckBox(
      {Key? key,
      required this.isCompleted,
      required this.taskColor,
      required this.id,
      this.isSchedule = false})
      : super(key: key);

  final String isCompleted;
  final int taskColor;
  final bool isSchedule;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return GestureDetector(
            onTap: () {
              cubit.setTaskCompleted(id, isCompleted);
              if(isSchedule){
             ScheduleCubit.get(context).getTasksFromDataBase(
                  context, ScheduleCubit.get(context).selectedDateText);
              }
 
            },
            child: Container(
              height: AppSize.s20,
              width: AppSize.s20,
              decoration: BoxDecoration(
                  color: Color(taskColor),
                  border: Border.all(color: ColorManager.white),
                  shape: BoxShape.circle),
              child: isCompleted == 'true'
                  ? Icon(
                      Icons.check,
                      color: ColorManager.white,
                      size: AppSize.s14,
                    )
                  : SizedBox(),
            ),
          );
        });
  }
}
