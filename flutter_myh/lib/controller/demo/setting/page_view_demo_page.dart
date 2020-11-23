import 'package:flutter/material.dart';

class PageViewDemoPage extends StatefulWidget {
  @override
  _PageViewDemoPageState createState() => _PageViewDemoPageState();
}

class _PageViewDemoPageState extends State<PageViewDemoPage> {
  List<String> _list;
  PageController _pageController;
  double _currentPage = 0.0;
  double _scaleFactor = .8;
  double _height = 230.0;

  @override
  void initState() {
    _list = [
      'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2319772070,3114389419&fm=26&gp=0.jpg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789533&di=f7acc1820e1094c9bbef458f93cd82b4&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201411%2F01%2F20141101171342_xHRH2.jpeg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789532&di=8bb423fa11efc97d89ba571fa0008d16&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201410%2F09%2F20141009224754_AswrQ.jpeg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789532&di=f96c5afe1f5b32671ecd9164cbaa52a3&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff331c6a4056b8fc7766941647aa3534927ce0005c5c5-b9WRQf_fw658',
    ];
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page;
      });
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pageView demo'),
      ),
      body: Container(
        height: _height,
        child: PageView.builder(
          itemCount: 9999,
          itemBuilder: (context, int index) {
            return _buildPageItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _currentPage.floor()) {
      //当前的item
      var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else if (index == _currentPage.floor() + 1) {
      //右边的item
      var currScale =
          _scaleFactor + (_currentPage - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else if (index == _currentPage.floor() - 1) {
      //左边
      var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else {
      //其他，不在屏幕显示的item
      matrix4 = Matrix4.diagonal3Values(1.0, _scaleFactor, 1.0)
        ..setTranslationRaw(0.0, _height * (1 - _scaleFactor) / 2, 0.0);
    }

    return Transform(
      transform: matrix4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                image: NetworkImage(_list[index % _list.length]),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
