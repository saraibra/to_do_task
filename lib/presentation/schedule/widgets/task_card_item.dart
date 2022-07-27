import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/resources/value_manger.dart';
import 'package:to_do_app/presentation/schedule/widgets/circle_check_box.dart';

import '../../main_screen/view/widgets/custom_check_box.dart';
import '../../resources/color_manager.dart';

class TaskCardItem extends StatelessWidget {
  const TaskCardItem(
      {Key? key,
      required this.time,
      required this.title,
      required this.color,
      required this.isCompleted,
      required this.id})
      : super(key: key);
  final String time;
  final String title;
  final int color;
  final int id;

  final String isCompleted;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSize.s100,
      decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(AppSize.s12)),
      child: ListTile(
          title: Text(
            time,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          trailing: CircleCheckBox(
            isCompleted: isCompleted,
            taskColor: color,
            isSchedule: true,
            id: id,
          )),
    );
  }
}
