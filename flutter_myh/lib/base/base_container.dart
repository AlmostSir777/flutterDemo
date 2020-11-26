import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'base_widget.dart';

class BaseContainer<T extends ChangeNotifier> extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Widget titleView;
  final Widget leading;
  final Widget tailing;
  final bool showNav;
  final Color backgroundColor;
  final Widget body;
  final T model;
  final VoidCallback callback;

  BaseContainer({
    this.title,
    this.titleColor,
    this.titleView,
    this.leading,
    this.tailing,
    this.showNav = true,
    this.backgroundColor = Colors.white,
    @required this.body,
    @required this.model,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: leading,
        tailing: tailing,
        callBack: callback,
        title: titleView != null
            ? titleView
            : Text(
                title ?? '',
                style: TextStyle(
                  color: titleColor ?? Colors.white,
                  fontSize: 16,
                ),
              ),
      ),
      body: SafeArea(
        child: BaseWidget<T>(
          child: body,
          model: model,
        ),
      ),
    );
  }
}
