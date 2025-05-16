import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String labelText;
  final IconData? prefixIcon;
  final String? hintText;
  final bool readOnly;
  final Function()? ontap;
  final TextEditingController? controller;
  final bool isPassword;
  final IconData? suffixIcon;
  final String? prefixText;
  final Function(String)? onChanged;
  final int? maxLength;
  final String? Function(String?)? validator;
  final Widget? prefixWidget;
  const CustomTextField(
      {super.key,
      this.validator,
       this.prefixText,
      required this.labelText,
     this.keyboardType,
       this.prefixIcon,
      this.controller,
      this.isPassword = false,
       hideText,
      this.maxLength,
      this.suffixIcon,
      this.hintText,
      this.readOnly = false,
      this.onChanged,
      this.prefixWidget,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
      child: TextFormField(
        maxLength: maxLength,
        focusNode: readOnly == true ? AlwaysDisabledFocusNode() : null,
        validator: validator,
        onTap: ontap,
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIconConstraints: BoxConstraints(maxHeight: 36,maxWidth: 36,minHeight: 36,minWidth: 36),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          labelStyle: TextStyle(color: Color(0xff58A184)),
          prefixIcon: prefixWidget ??
              (prefixIcon == null
                  ? null
                  : Icon(prefixIcon, color: Colors.grey)),
          prefixText: prefixText,
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Color(0xff58A184))
              : null,
          hintText: hintText,
          counterStyle: TextStyle(fontSize: 0),
          prefixStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: readOnly ? Colors.black : Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff58A184)),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff58A184), width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff58A184)),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff58A184), width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
