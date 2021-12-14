import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar({
    Key? key,
    required this.actions,
    required this.title,
    required this.leading,
    this.color,
  }) : super(key: key);

  final List<Widget> actions;
  final Widget leading;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: color ?? Colors.white,
      elevation: 0,
      leading: leading,
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.headline4!.copyWith(letterSpacing: 1.5),
        overflow: TextOverflow.ellipsis,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(50.0));
}
