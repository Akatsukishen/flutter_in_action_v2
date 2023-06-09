import 'package:flutter/material.dart';

abstract class BasePage extends StatelessWidget {
  const BasePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context);
}
