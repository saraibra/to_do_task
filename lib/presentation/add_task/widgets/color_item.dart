import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/resources/color_manager.dart';
import 'package:to_do_app/presentation/resources/value_manger.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({ Key? key, required this.color, required this.selected }) : super(key: key);
 final Color color;
 final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s50,
      width: AppSize.s50,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: color
          )),
          child: selected? Center(
            child: Icon(Icons.check,
            color: ColorManager.white,
            ),
          ):const SizedBox(),
     
    );
  }
}