import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog使用'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var result = await showAlertDialog(context);
                if (result == null) {
                  debugPrint("===> 不删除");
                } else {
                  debugPrint("===> 删除");
                }
              },
              child: const Text('AlertDialog使用'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await showSimpleDialog(context);
                if (result == 1) {
                  debugPrint("===> 中文简体");
                } else if (result == 2) {
                  debugPrint("===> 美国英语");
                }
              },
              child: const Text('SimpleDialog使用'),
            ),
            ElevatedButton(
              onPressed: () async {
                var index = await showDialogList(context);
                if (index != null) {
                  debugPrint("===> 选择了$index");
                }
              },
              child: const Text('Dialog中使用List'),
            ),
            ElevatedButton(
              onPressed: () {
                showCustomDialog(context, (context) {
                  return AlertDialog(
                    title: const Text('提示'),
                    content: const Text('确定要删除该文件嘛？'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('取消'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('确认'),
                      )
                    ],
                  );
                }, true, null);
              },
              child: const Text('非Material方式Dialog'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = _showModalBottomSheet(context);
                debugPrint("===> result = $result");
              },
              child: const Text('底部菜单列表'),
            ),
            ElevatedButton(
              onPressed: () {
                showLoading1(context);
              },
              child: const Text('loading1'),
            ),
            ElevatedButton(
              onPressed: () {
                showLoading2(context);
              },
              child: const Text('loading2'),
            ),
            ElevatedButton(
              onPressed: () {
                showStatefulDialogError(context);
              },
              child: const Text('Dialog有状态'),
            ),
            ElevatedButton(
              onPressed: () {
                showStatefulDialog(context);
              },
              child: const Text('Dialog有状态2'),
            ),
            ElevatedButton(
              onPressed: () {
                showStatefulDialog3(context);
              },
              child: const Text('Dialog有状态3'),
            ),
            ElevatedButton(
              onPressed: () {
                showStatefulDialog4(context);
              },
              child: const Text('Dialog有状态4'),
            ),
          ],
        ),
      ),
    );
  }

  // AlertDialog 提示框
  Future<bool?> showAlertDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('提示'),
            content: const Text('确定要删除该文件嘛？'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('确认'),
              )
            ],
          );
        });
  }

  // SimpleDilaog
  Future<int?> showSimpleDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('请选择语言'),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop(1);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop(2);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('美国英语'),
                ),
              ),
            ],
          );
        });
  }

  // AlertDialog SimpleDialog 以内容的实际大小显示，不支持List的懒加载
  Future<int?> showDialogList(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          var list = Column(
            children: [
              const ListTile(
                title: Text('请选择'),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('$index'),
                      onTap: () {
                        Navigator.of(context).pop(index);
                      },
                    );
                  },
                  itemCount: 30,
                ),
              ),
            ],
          );
          return Dialog(
            child: list,
          );
        });
  }

  //showDialog打开的是Material风格的Dialog
  Future<T?> showCustomDialog<T>(
    BuildContext context,
    WidgetBuilder builder,
    bool barrierDismisable,
    ThemeData? theme,
  ) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (contxt, _, __) {
        //要显示的内容
        final Widget pageChild = Builder(
          builder: builder,
        );
        return SafeArea(
          child: Builder(
            builder: (context) {
              return theme != null
                  ? Theme(data: theme, child: pageChild)
                  : pageChild;
            },
          ),
        );
      },
      barrierDismissible: barrierDismisable,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87, //背景颜色
      transitionDuration: const Duration(milliseconds: 150), //动画时间
      transitionBuilder: _buildMaterialDialogTransitions, //打开动画
    );
  }

  Widget _buildMaterialDialogTransitions(BuildContext context,
      Animation<double> anim, Animation<double> secondAnim, Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: anim, curve: Curves.easeOut),
      child: child,
    );
  }

  Future<int?> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet<int>(
        context: context,
        builder: (contex) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('$index'),
                onTap: () {
                  Navigator.of(context).pop(index);
                },
              );
            },
            itemCount: 30,
          );
        });
  }

  void showLoading1(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top:26.0),
                  child: Text('正在加载,请稍后...'),
                )
              ],
            ),
          );
        });
  }

  /// 原有的AlertDialog有最短宽度约束
  /// 使用UnconstrainedBox 移除原有的约束
  /// 再使用SizedBox来固定宽度约束
  void showLoading2(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const UnconstrainedBox(
            child: SizedBox(
              width: 280,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 26.0),
                      child: Text('正在加载,请稍后...'),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  bool withTree = false;
  void showStatefulDialogError(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('确定要删除当前文件嘛?'),
                Row(
                  children: [
                    const Text('同时删除子目录?'),
                    Checkbox(
                      value: withTree,
                      onChanged: (value) {
                        setState(() {
                          // 无法刷新状态, setState只能刷新当前context下面的子控件
                          // 而dialog是另开一个route，alertdialog并不是当前context的子控件
                          withTree = value ?? false;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void showStatefulDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('确定要删除当前文件嘛?'),
                Row(
                  children: [
                    const Text('同时删除子目录?'),
                    StatefulBuilder(
                      //包裹一个无状态控件，让其可以调用父控件的方法，来更新自身
                      builder: (context, setstate) {
                        return Checkbox(
                          value: withTree,
                          onChanged: (value) {
                            setstate(() {
                              withTree = value ?? false;
                            });
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void showStatefulDialog3(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('确定要删除当前文件嘛?'),
                Row(
                  children: [
                    const Text('同时删除子目录?'),
                    Checkbox(
                      value: withTree,
                      onChanged: (value) {
                        setState(() {
                          ///把context对应的Element标记为脏数据，flutter框架发现是脏数据，下一帧会进行刷新。
                          (context as Element).markNeedsBuild();
                          withTree = value ?? false;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void showStatefulDialog4(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('确定要删除当前文件嘛?'),
                Row(
                  children: [
                    const Text('同时删除子目录?'),
                    Builder(builder: (context) {
                      //使用builder来缩小脏数据的范围
                      return Checkbox(
                        value: withTree,
                        onChanged: (value) {
                          setState(() {
                            ///
                            (context as Element).markNeedsBuild();
                            withTree = value ?? false;
                          });
                        },
                      );
                    }),
                  ],
                )
              ],
            ),
          );
        });
  }
}
