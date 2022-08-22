import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/utils/utils.dart';

TextField getTextField(
    {required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required String hintText,
    bool isSecureWord = false,
    bool autofocus = false,
    required FocusNode focusNode,
    required Function onEditingComplete}) {
  return TextField(
    onEditingComplete: () {
      onEditingComplete();
    },
    focusNode: focusNode, //焦点
    autofocus: autofocus, //自动唤起
    textInputAction: TextInputAction.search,
    keyboardType: TextInputType.name,
    controller: controller,
    // textCapitalization: TextCapitalization.none,
    textAlign: TextAlign.start,
    decoration: InputDecoration(
      //有一点很重要 contentPadding一定要设置上下边距为0
      contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
      //textfield占位语，类似于iOS中的placeholder
      hintText: hintText,
      //给textField设置了外边框，textField的内容就会居中显示
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
    ),
    style: TextStyle(
      color: Colors.black,
      // fontFamily: "Avenir",
      fontWeight: FontWeight.w400,
      fontSize: duSetWidth(15),
    ),
  );
}
