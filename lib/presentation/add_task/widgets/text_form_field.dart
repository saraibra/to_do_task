import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/resources/value_manger.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final double width;
  final String? value;
  final validate;
  Widget? suffixIcon;
  final bool enabled;
  DefaultTextFormField({
    Key? key,
    required this.controller,
    required this.type,
    this.validate,
    required this.value,
    this.width = double.infinity,
    this.suffixIcon,
    this.enabled = true,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        validator: validate,
        keyboardType: type,
        enabled: enabled,
      
        decoration: InputDecoration(hintText: value, suffixIcon: suffixIcon,
    
        ),
        

      ),
    );
  }
}
