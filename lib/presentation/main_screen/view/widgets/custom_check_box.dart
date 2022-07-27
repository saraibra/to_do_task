import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/value_manger.dart';
import '../../cubit/main_cubit.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox(
      {Key? key,
      required this.isCompleted,
      required this.taskColor,
      required this.id,
   })
      : super(key: key);
  final String isCompleted;
  final int taskColor;

  final int id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MainCubit.get(context).setTaskCompleted(id, isCompleted);
      },
      child: Container(
        height: AppSize.s20,
        width: AppSize.s20,
        decoration: BoxDecoration(
            color:
                isCompleted == 'true' ? Color(taskColor) : ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s4),
            border: Border.all(color: Color(taskColor)),
            shape: BoxShape.rectangle),
        child: isCompleted == 'true'
            ? Icon(
                Icons.check,
                color: ColorManager.white,
                size: AppSize.s14,
              )
            : SizedBox(),
      ),
    );
  }
}
