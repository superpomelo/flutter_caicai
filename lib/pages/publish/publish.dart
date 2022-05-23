import 'package:flutter/material.dart';

class PublishPage extends StatefulWidget {
  const PublishPage({Key? key}) : super(key: key);

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      // backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text('PublishPage'),
    ));
  }
}
