import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_app_bar.dart';
import 'base_widget.dart';
import 'base_scroll_behavior.dart';

class BaseContainer<T extends ChangeNotifier> extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Widget titleView;
  final Widget leading;
  final Widget tailing;
  final bool showNav;
  final Color backgroundColor;
  final Color navColor;
  final Widget body;
  final T model;
  final VoidCallback callback;
  final SystemUiOverlayStyle overlayStyle;
  final bool isRootPage;

  BaseContainer({
    this.title,
    this.titleColor,
    this.titleView,
    this.leading,
    this.tailing,
    this.showNav = true,
    this.backgroundColor = Colors.white,
    this.navColor,
    this.overlayStyle,
    @required this.body,
    @required this.model,
    this.callback,
    this.isRootPage = false,
  });
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: overlayStyle ?? SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: CustomAppBar(
          leading: leading,
          tailing: tailing,
          callBack: callback,
          navColor: navColor,
          title: titleView != null
              ? titleView
              : AppBarTitle(
                  title: title,
                  textColor: titleColor,
                ),
          isRootPage: isRootPage,
        ),
        body: ScrollConfiguration(
          behavior: BaseScrollBehavior(),
          child: BaseWidget<T>(
            child: body,
            model: model,
          ),
        ),
      ),
    );
  }
}

class BaseNormalContainer extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Widget titleView;
  final Widget leading;
  final Widget tailing;
  final bool showNav;
  final Color backgroundColor;
  final Color navColor;
  final Widget body;
  final VoidCallback callback;
  final SystemUiOverlayStyle overlayStyle;
  final bool isRootPage;

  BaseNormalContainer({
    this.title,
    this.titleColor,
    this.titleView,
    this.leading,
    this.tailing,
    this.showNav = true,
    this.backgroundColor = Colors.white,
    this.navColor,
    this.overlayStyle,
    @required this.body,
    this.callback,
    this.isRootPage = false,
  });
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: overlayStyle ?? SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: CustomAppBar(
          leading: leading,
          tailing: tailing,
          callBack: callback,
          navColor: navColor,
          title: titleView != null
              ? titleView
              : AppBarTitle(
                  title: title,
                  textColor: titleColor,
                ),
          isRootPage: isRootPage,
          showNav: showNav,
        ),
        backgroundColor: backgroundColor,
        body: ScrollConfiguration(
          behavior: BaseScrollBehavior(),
          child: body,
        ),
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  final String title;
  final Color textColor;
  AppBarTitle({
    this.title,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor ?? Colors.white,
        fontSize: 18,
      ),
    );
  }
}
