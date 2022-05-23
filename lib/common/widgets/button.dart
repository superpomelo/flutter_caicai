import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';

///普通btn
Widget btnFlatButtonWidget(
    {required VoidCallback onPressed,
    double width = 140,
    double height = 44,
    Color gbColor = AppColors.primaryElement,
    String title = "button",
    Color fontColor = AppColors.primaryElementText,
    double fontSize = 18,
    double circular = 4,
    String fontName = "Montserrat",
    FontWeight fontWeight = FontWeight.w400}) {
  //点击限制
  var _isCan = true;
  // ignore: sized_box_for_whitespace
  return Container(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: TextButton(
      onPressed: () {
        if (_isCan == true) {
          _isCan = false;
          onPressed();
          Future.delayed(const Duration(seconds: 2), () {
            _isCan = true;
          });
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(gbColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(circular))))),
      child: Text(
        title,
        style: TextStyle(
            color: fontColor,
            fontWeight: fontWeight,
            fontSize: fontSize,
            fontFamily: fontName),
      ),
    ),
  );
}

///镂空button
Widget btnTextButtonBorderOnlyWidget(
    {required VoidCallback onPressed,
    double width = 88,
    double height = 44,
    String iconFileName = "facebook"}) {
  //点击限制
  var _isCan = true;
  // ignore: sized_box_for_whitespace
  return Container(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: TextButton(
      child: Image.asset("assets/images/icons-$iconFileName.png"),
      onPressed: () {
        if (_isCan == true) {
          _isCan = false;
          onPressed();
          Future.delayed(const Duration(seconds: 2), () {
            _isCan = true;
          });
        }
      },
      style: ButtonStyle(
          //边框
          side: MaterialStateProperty.all(
            const BorderSide(
                color: Color.fromARGB(255, 230, 230, 231), width: 0.67),
          ),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(duSetWidth(6)))))),
    ),
  );
}
