import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/resources/color_manager.dart';
import 'package:to_do_app/presentation/resources/value_manger.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.textColor = Colors.white,
 
})
      : super(key: key);
  final String text;
  Color textColor;
 

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: MaterialButton(
        height: AppSize.s40,
        onPressed: onPressed,
        textColor: textColor,
        child: Text(text),
      ),
    );
  }
}