import 'package:flutter/material.dart';

import '../constants/Theme.dart';

class Input extends StatelessWidget {
  final String? placeholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function? onTap;
  final Function? onChanged;
  final TextEditingController? controller;
  final bool autofocus;
  final Color borderColor;
  final TextInputType textInputType;
  final bool obscureText;

  Input(
      {this.placeholder,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.onChanged,
      this.autofocus = false,
      this.borderColor = NowUIColors.border,
      this.controller,
      this.textInputType = TextInputType.text,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: textInputType,
        obscureText: obscureText,
        cursorColor: NowUIColors.muted,
        onTap: onTap == null ? () {} : onTap!(),
        onChanged: onChanged == null ? (String _) {} : onChanged!(),
        controller: controller,
        autofocus: autofocus,
        style: TextStyle(height: 0.55, fontSize: 13.0, color: NowUIColors.time),
        textAlignVertical: TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            filled: true,
            fillColor: NowUIColors.white,
            hintStyle: TextStyle(
              color: NowUIColors.time,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
