import 'package:flutter/material.dart';
import 'package:flutter_myh/const/config.dart';
import 'package:flutter/services.dart';

import '../../../base/base_container.dart';
import '../../setting_page/setting_page_routes.dart';

class ClipDemoPage extends StatefulWidget {
  @override
  _ClipDemoPageState createState() => _ClipDemoPageState();
}

class _ClipDemoPageState extends State<ClipDemoPage> {
  @override
  Widget build(BuildContext context) {
    return BaseNormalContainer(
      title: '裁剪',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 20,
          ),
          ClipRectDemoView(),
          Container(height: 1, color: line_color),
          CircleRectDemo(),
          Container(height: 1, color: line_color),
          OvalRectDemo(),
          Container(height: 1, color: line_color),
          ClipPathDemo(),
          Container(height: 1, color: line_color),
        ],
      ),
    );
  }
}

class ClipRectDemoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ImageDemoView(
        size: Size(100, 50),
      ),
    );
  }
}

class CircleRectDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: ImageDemoView(
        size: Size(100, 100),
        callback: () =>
            Navigator.pushNamed(context, SettingPageRoutes.clipDetail),
      ),
    );
  }
}

class OvalRectDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: ImageDemoView(
        size: Size(100, 100),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2.0, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => oldClipper != this;
}

class ClipPathDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TriangleClipper(),
      child: ImageDemoView(
        size: Size(100, 100),
      ),
    );
  }
}

class ImageDemoView extends StatelessWidget {
  final Size size;
  final VoidCallback callback;
  ImageDemoView({
    @required this.size,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    String _imgUrl =
        'https://p3fx.kgimg.com/v2/fxuserlogo/7e83eb705e9a7dbddfbc4a265e14e018.jpg_200x200.jpg';
    return callback != null
        ? Hero(
            tag: _imgUrl,
            child: GestureDetector(
              onTap: () {
                if (callback != null) {
                  callback();
                }
              },
              child: Image.network(
                _imgUrl,
                fit: BoxFit.cover,
                width: size.width,
                height: size.height,
              ),
            ),
          )
        : Image.network(
            _imgUrl,
            fit: BoxFit.cover,
            width: size.width,
            height: size.height,
          );
  }
}

class ImageDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _imgUrl =
        'https://p3fx.kgimg.com/v2/fxuserlogo/7e83eb705e9a7dbddfbc4a265e14e018.jpg_200x200.jpg';
    return BaseNormalContainer(
      showNav: false,
      overlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark, statusBarColor: Colors.black),
      title: '图片详情',
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Hero(
            tag: _imgUrl,
            child: Image.network(
              _imgUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
