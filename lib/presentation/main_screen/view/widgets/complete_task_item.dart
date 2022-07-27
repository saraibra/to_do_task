import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/main_screen/cubit/main_cubit.dart';
import 'package:to_do_app/presentation/resources/color_manager.dart';
import 'package:to_do_app/presentation/schedule/widgets/circle_check_box.dart';

import '../../../resources/value_manger.dart';
import 'custom_check_box.dart';

class CompleteTaskItem extends StatelessWidget {
  const CompleteTaskItem(
      {Key? key,
      required this.taskTitle,
      required this.taskColor,
      required this.isCompleted,
      required this.isFavourited,
      required this.id,
      required this.startDate,
      required this.endDate})
      : super(key: key);

  final String taskTitle;
  final int taskColor;
  final String isCompleted;
  final String isFavourited;
  final String startDate;
  final String endDate;

  final int id;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(taskColor),
          borderRadius: BorderRadius.circular(AppSize.s12)),
      width: double.infinity,
      //height: AppSize.s50,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            Row(
              children: [
                CircleCheckBox(
                  isCompleted: isCompleted,
                  taskColor: taskColor,
                  id: id,
                ),
                const SizedBox(
                  width: AppSize.s12,
                ),
                Text(
                  taskTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      MainCubit.get(context)
                          .checkIsTaskFavourited(id, isFavourited);
                    },
                    icon: Icon(
                      isFavourited == 'true'
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: ColorManager.white,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Start date: $startDate',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'End date: $endDate',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
