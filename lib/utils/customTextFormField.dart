import 'package:cab_go_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  TextInputType? keyBoardType;
  String? hintText;
  IconButton? prefixIcon;
  IconButton? suffixIcon;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  Color? color;
  double? height;
  double? width;
  bool? isTextAlignCenter;
  bool? isLoading;
  bool obscureText;
  InputBorder? border;
  TextEditingController? controller;
  String? Function(String?)? validate;
  Widget? prefix;
  int? maxLines;
  final ValueChanged<String>? onChanged;

  CustomTextFormField(
      {super.key,
      this.keyBoardType,
        this.onChanged,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.color,
      this.height,
      this.width,
      this.isTextAlignCenter = false,
      this.obscureText = false,
      this.border,
      this.validate,
      this.controller,
      this.maxLines,
      this.focusNode,
      this.inputAction,
      this.isLoading=false,
      this.prefix,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      width: width ?? 300,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        // border: Border.all(
        //   color: Colors.black54
        // ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        // focusNode: focusNode,
        validator: validate,
        onChanged: onChanged,
        textAlign: isTextAlignCenter == true ? TextAlign.center : TextAlign.left,
        keyboardType: keyBoardType ?? TextInputType.text,
        textInputAction: inputAction,
        obscureText: obscureText,
        cursorColor: kYellow,
        decoration: InputDecoration(
          hintText: hintText ?? 'hint Text',
          prefix: prefix,
          contentPadding: const EdgeInsets.all(12),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kYellow),
          ),
          border: border ?? InputBorder.none,
          // enabledBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(
          //       width: 3, color: Colors.black38
          //   ),
          // )
        ),
      ),
    );
  }
}
