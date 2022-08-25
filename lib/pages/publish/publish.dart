/*
 * @Author: superpomelo 
 * @Date: 2022-08-22 18:04:40
 * @LastEditors: superpomelo 
 * @LastEditTime: 2022-08-25 14:25:22
 * @FilePath: /flutter_caicai/lib/pages/publish/publish.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/widgets/textformfield_widget.dart';
import 'package:flutter_caicai/pages/publish/view/publish_bottom_view.dart';
import 'package:flutter_caicai/pages/publish/view/publish_form_view.dart';
import 'package:flutter_caicai/pages/publish/view/publish_title_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PublishPage extends StatefulWidget {
  const PublishPage({Key? key}) : super(key: key);

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  final TextEditingController _controller = TextEditingController();
  //创建FocusNode焦点对象实例
  final FocusNode _focusNode = FocusNode();

  ///添加图片/视频部分
  Widget _buildForm() {
    return PublishFormView(onTypeChanged: (value) {});
  }

  ///标题部分
  Widget _buildTitle() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(children: [
        publishTitle(
            controller: _controller,
            hintText: '填写标题会有更多关注哦～',
            focusNode: _focusNode,
            onEditingComplete: () {
              _focusNode.unfocus(); //隐藏焦点
              //拦截空搜索
              if (_controller.text.isEmpty) {
                print('请输入搜索内容');
                return;
              }
              if (_controller.text.contains(' ')) {
                print('请不要输入空格');
                return;
              }
            }),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 1, 0, 0),
          color: Colors.blueGrey,
          height: 0.5,
        )
      ]),
    );
  }

  ///正文部分
  Widget _buildBody() {
    return Container(
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child:
            multilineFrom('', hintText: '添加正文', maxLength: 150, validator: (e) {
          if (e == null) {
            return;
          }
          print(e);
        }));
  }

  /// 发布按钮部分
  Widget _buildBottom() {
    return Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: publishBottom(onPressed: () {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(''),
      ),
      body: Column(
        children: [
          _buildForm(),
          _buildTitle(),
          _buildBody(),
          const Spacer(),
          _buildBottom()
        ],
      ),
    );
  }
}
