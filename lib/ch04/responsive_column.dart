import 'package:flutter/material.dart';

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 200) {
        //宽度小于200
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        );
      } else {
        var widgets = <Widget>[];
        for (int i = 0; i < children.length; i += 2) {
          if (i + 1 < children.length) {
            widgets.add(Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  children[i],
                  const SizedBox(
                    width: 10,
                  ),
                  children[i + 1]
                ],
              ),
            ));
          } else {
            widgets.add(Padding(
                padding: const EdgeInsets.only(top: 10), child: children[i]));
          }
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: widgets,
        );
      }
    });
  }
}
