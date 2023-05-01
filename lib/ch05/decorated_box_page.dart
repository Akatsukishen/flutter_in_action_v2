import 'package:flutter/material.dart';

import '../base/base_page.dart';

/// 装饰Box的使用
class DecoratedBoxPage extends BasePage {
  const DecoratedBoxPage({super.key,super.title = 'DecoratedBox使用'}) ;

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red,Colors.orange.shade700]),
          borderRadius: BorderRadius.circular(3.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(2.0, 2.0),
              blurRadius: 4.0
            )
          ]
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 80,vertical: 18),
          child: Text('Login',style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}