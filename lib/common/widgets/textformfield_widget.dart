/*
 * @Author: superpomelo 
 * @Date: 2022-08-18 12:05:18
 * @LastEditors: superpomelo 
 * @LastEditTime: 2022-08-19 11:52:10
 * @FilePath: /flutter_caicai/lib/common/widgets/textformfield_widget.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/utils/utils.dart';

Widget multilineFrom(
  String title, {
  // required String key,
  String? hintText,
  String? initialValue,
  int? maxLength,
  FormFieldValidator<String>? validator,
}) {
  // final controllers = <String, TextEditingController>{};

  // void clear() {
  //   controllers.forEach((_, controller) {
  //     controller.clear();
  //   });
  // }
  // FocusScope.of(context).nextFocus();

  TextEditingController? _controller;
  // if (controllers.containsKey(key)) {
  //   _controller = controllers[key];
  // } else {
  _controller = TextEditingController(text: initialValue);
  //   controllers[key] = _controller;
  // }

  var _textFormField = TextFormField(
    focusNode: FocusNode(),
    controller: _controller,
    initialValue: initialValue,
    // expands: true,
    // keyboardType: ,
    // autofocus: ,
    // readOnly: ,
    // strutStyle: ,
    // showCursor: ,
    maxLines: null,
    maxLength: maxLength,
    // onChanged: ,
    // onTap: ,
    // onSaved: ,
    validator: validator,
    // inputFormatters: [],
    // enabled: ,
    onFieldSubmitted: (value) {
      debugPrint('-----------onFieldSubmitted');
    },
    textInputAction: TextInputAction.newline,
    style: TextStyle(
      color: const Color(0xFF0B0E11),
      fontSize: duSetFontSize(14),
      fontWeight: FontWeight.w500,
    ),
    keyboardType: TextInputType.multiline,
    decoration: InputDecoration(
      hintMaxLines: 100000,
      // filled: true,
      // fillColor: Colors.orange,
      border: InputBorder.none,
      counterText: '',
      contentPadding: const EdgeInsets.all(0),
      // alignLabelWithHint: true,
      hintText: hintText,
      hintStyle: TextStyle(
        color: const Color(0xFFD1D1D6),
        fontSize: duSetFontSize(14),
        fontWeight: FontWeight.w500,
      ),
      // isCollapsed: true,
    ),
    // textAlignVertical: TextAlignVertical.top,
  );

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: duSetWidth(0)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: duSetWidth(12)),
        //   child: Text(
        //     title,
        //     style: const TextStyle(color: Colors.black),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(bottom: duSetWidth(18)),
          child: _textFormField,
        ),
      ],
    ),
  );
}
