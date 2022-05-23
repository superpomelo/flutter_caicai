import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:flutter_caicai/global.dart';

class AccountPages extends StatefulWidget {
  const AccountPages({Key? key}) : super(key: key);

  @override
  State<AccountPages> createState() => _AccountPagesState();
}

class _AccountPagesState extends State<AccountPages> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(Global.profile.data.nickname),
          const SizedBox(
            height: 50,
          ),
          btnFlatButtonWidget(
              title: "退出",
              onPressed: () {
                goLoginPage(context);
              })
        ],
      ),
    );
  }
}
