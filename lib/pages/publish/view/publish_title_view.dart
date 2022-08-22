import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/widgets/textfield_widget.dart';

///发布标题部分
Widget publishTitle(
    {required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required String hintText,
    bool isSecureWord = false,
    bool autofocus = false,
    required FocusNode focusNode,
    required Function onEditingComplete}) {
  return getTextField(
      controller: controller,
      hintText: hintText,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete);
}
