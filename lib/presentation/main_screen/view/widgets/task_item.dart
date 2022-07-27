import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/main_screen/cubit/main_cubit.dart';
import 'package:to_do_app/presentation/resources/color_manager.dart';

import '../../../resources/value_manger.dart';
import 'custom_check_box.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
      {Key? key,
      required this.taskTitle,
      required this.taskColor,
      required this.isCompleted,
      required this.id, required this.isFavourited})
      : super(key: key);
  final String taskTitle;
  final int taskColor;
  final String isCompleted;
    final String isFavourited;

  final int id;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSize.s50,
      child: Row(
        children: [
          CustomCheckBox(
            isCompleted: isCompleted,
            taskColor: taskColor,
            id: id,
          ),
          const SizedBox(
            width: AppSize.s12,
          ),
          FittedBox(
            child: Text(
              taskTitle,
              maxLines: 2,
            overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Spacer(),
          DropdownButton(
            
            icon: Icon(
              Icons.more_vert,
              color: Color(taskColor),
            ),
            items: MainCubit.get(context).menuList.map(
              (value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              },
            ).toList(),
            onChanged: (value) {
              MainCubit.get(context).changeMenuValue(value,id,isFavourited);
            },
            underline: const SizedBox(),
          ),
        ],
      ),
    );
  }
}
