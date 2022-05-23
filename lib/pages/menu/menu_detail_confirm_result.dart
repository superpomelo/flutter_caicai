import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/utils/screen.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class MenuDetailConfirmResult extends StatefulWidget {
  MenuDetailConfirmResult({Key? key}) : super(key: key);

  @override
  State<MenuDetailConfirmResult> createState() =>
      _MenuDetailConfirmResultState();
}

class _MenuDetailConfirmResultState extends State<MenuDetailConfirmResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: duSetHeight(100)),
                child: Text(
                  "恭喜! 下单成功.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: duSetFontSize(20),
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w600,
                      height: 1.3),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: duSetHeight(15)),
                child: btnFlatButtonWidget(
                    onPressed: () {
                      Get.back();
                    },
                    title: "返回",
                    width: 290),
              ),
            ],
          )
        ],
      ),
    );
  }
}
