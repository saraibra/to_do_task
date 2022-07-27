import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/add_task/widgets/color_item.dart';
import 'package:to_do_app/presentation/main_screen/cubit/main_cubit.dart';
import 'package:to_do_app/presentation/resources/color_manager.dart';
import 'package:to_do_app/presentation/resources/value_manger.dart';

class ColorList extends StatelessWidget {
  const ColorList({Key? key, required this.colorList}) : super(key: key);
  final List<Color> colorList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.s80,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                MainCubit.get(context).selectContainerColor(index);
              },
              child: ColorItem(
                color: colorList[index],
                selected: MainCubit.get(context).selected == index,
              )),
          separatorBuilder: (context, index) => const SizedBox(
                width: AppSize.s12,
              ),
          itemCount: colorList.length),
    );
  }
}
