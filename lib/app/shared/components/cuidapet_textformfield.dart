import 'package:flutter/material.dart';

import '../theme_utils.dart';

class CuidapetTextFormField extends TextFormField {
  CuidapetTextFormField(
      {TextEditingController controller,
      @required String label,
      FormFieldValidator<String> validator,
      bool obscureText = false,
      bool readOnly = false,
      Widget icon,
      String initialValue,
      IconButton suffixIcon})
      : super(
            controller: controller,
            obscureText: obscureText,
            readOnly: readOnly,
            initialValue: initialValue,
            decoration: InputDecoration(
              labelText: label,
              icon: icon,
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                gapPadding: 0,
              ),
              suffixIcon: suffixIcon,
            ),
            validator: validator);
}
