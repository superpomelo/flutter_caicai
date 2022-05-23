import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'dart:async';
import 'package:get/get.dart';

// ignore: camel_case_types
class signUpPage extends StatefulWidget {
  const signUpPage({Key? key}) : super(key: key);

  @override
  State<signUpPage> createState() => _signUpPageState();
}

// ignore: camel_case_types
class _signUpPageState extends State<signUpPage> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  //发送验证码倒计时
  var _timeTag = 60.obs;
//定时器
  _getcode() async {
    const timeout = Duration(seconds: 1);
    Timer.periodic(timeout, (timer) {
      //callback function
      //1s 回调一次

      _timeTag = _timeTag - 1;

      if (_timeTag.value == 0) {
        _timeTag.value = 60;
        timer.cancel(); // 取消定时器
      }
    });
  }

  //创建
  _handelCreateAnAccount() {
    toastInfo(msg: "创建成功");
  }

  //Sign up
  Widget _buildText() {
    return Container(
      margin: EdgeInsets.only(top: duSetHeight(15)),
      child: Text(
        '创建一个账户',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.primaryText,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontSize: duSetFontSize(24),
            height: 1),
      ),
    );
  }

  //登录表单
  Widget _buildInputForm() {
    return Container(
      width: duSetWidth(295),
      margin: EdgeInsets.only(top: duSetHeight(49)),
      child: Column(
        children: [
          Container(
              child: Stack(
            children: [
              Positioned(
                child: inputTextEdit(
                    controller: _emailController, hintText: "邮箱", marginTop: 0),
              ),
              Positioned(
                  top: duSetHeight(4),
                  right: duSetWidth(5),
                  child: Obx(() => btnFlatButtonWidget(
                      fontSize: duSetFontSize(12),
                      onPressed: _timeTag.value == 60
                          ? () {
                              _getcode();
                            }
                          : () {},
                      title: _timeTag.value == 60
                          ? "发送验证码"
                          : _timeTag.value.toString(),
                      width: duSetWidth(80),
                      height: duSetWidth(35))))
            ],
          )),

          inputTextEdit(controller: _codeController, hintText: "邮箱验证码"),
          inputTextEdit(
              controller: _passController, hintText: "密码", isPassWord: true),
          Container(
            height: duSetHeight(44),
            width: duSetWidth(295),
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: Row(
              children: [
                btnFlatButtonWidget(
                    width: 295,
                    onPressed: _handelCreateAnAccount,
                    gbColor: AppColors.primaryElement,
                    title: "创建一个账户"),
              ],
            ),
          ),
          // Container(
          //   height: duSetHeight(44),
          //   margin: EdgeInsets.only(top: duSetHeight(20)),
          //   child: TextButton(
          //       onPressed: () {},
          //       child: Text(
          //         "Forgot password?",
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //             color: AppColors.secondaryElementText,
          //             fontFamily: "Avenir",
          //             fontWeight: FontWeight.w400,
          //             fontSize: duSetFontSize(16),
          //             height: 1 // 设置下行高，否则字体下沉
          //             ),
          //       )),
          // )
        ],
      ),
    );
  }

  //I have an account
  Widget _buildHaveAnAccountButton() {
    return Container(
      margin: EdgeInsets.only(bottom: duSetHeight(20)),
      child: btnFlatButtonWidget(
          onPressed: () {
            Navigator.pop(context);
          },
          width: 294,
          gbColor: AppColors.secondaryElement,
          fontColor: AppColors.primaryText,
          title: "我有账户",
          fontWeight: FontWeight.w500,
          fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: transparentAppBar(context: context, actions: [
        IconButton(
          icon: const Icon(Icons.info_outline, color: AppColors.primaryText),
          onPressed: () {},
        ),
      ]),
      body: Center(
          child: Column(
        children: [
          _buildText(),
          _buildInputForm(),
          const Spacer(),
          _buildHaveAnAccountButton()
        ],
      )),
    );
  }
}
