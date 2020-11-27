import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_myh/base/base_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../model/root_page_model.dart';
import '../demo/home/padding_align_center_demo.dart';
import '../../base/push_route_tool.dart';
import '../demo/home/subject_page.dart';
import 'home_page_routes.dart';
import '../../base/base_container.dart';

class HomeActivity extends StatefulWidget {
  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity>
    with AutomaticKeepAliveClientMixin {
  @override //第二步保持页面状态返回true
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    print('啥时候执行');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseNormalContainer(
      title: '首页',
      isRootPage: true,
      body: StarView(),
    );
  }
}

class StarView extends StatefulWidget {
  @override
  _StarViewState createState() => _StarViewState();
}

class _StarViewState extends State<StarView> {
  HomeViewModel _viewModel;
  @override
  void initState() {
    _viewModel = HomeViewModel();
    super.initState();
    _viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      model: _viewModel,
      child: Selector<HomeViewModel, List<ListModel>>(
        builder: (_, list, __) => _buildListView(list),
        selector: (_, viewModel) => viewModel.listModels,
      ),
    );
  }

  Column _buildTopView() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildSwiper(),
        _buildTitleSection(),
        _buildButtonSection(),
        _buildDescSection(),
      ],
    );
  }

  Widget _buildTitleSection() {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'KanderSteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.red[500],
                  ),
                  Selector<HomeViewModel, int>(
                      builder: (_, int starNum, __) {
                        return Text('$starNum');
                      },
                      selector: (_, viewModel) => viewModel.starNum),
                ],
              ),
            ),
            onTap: () => _viewModel.addNum(),
          ),
        ],
      ),
    );
    return titleSection;
  }

  Column _buildButtonColumn(IconModel model) {
    Color color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          model.icon,
          color: color,
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            model.name,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonSection() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildButtonColumn(IconModel(Icons.call, 'CALL')),
          _buildButtonColumn(IconModel(Icons.near_me, 'ROUTE')),
          _buildButtonColumn(IconModel(Icons.share, 'SHARE')),
        ],
      ),
    );
  }

  Widget _buildDescSection() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        '11Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );
  }

  Widget _buildSwiper() {
    List bannerArr = [
      'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2319772070,3114389419&fm=26&gp=0.jpg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789533&di=f7acc1820e1094c9bbef458f93cd82b4&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201411%2F01%2F20141101171342_xHRH2.jpeg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789532&di=8bb423fa11efc97d89ba571fa0008d16&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201410%2F09%2F20141009224754_AswrQ.jpeg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601197789532&di=f96c5afe1f5b32671ecd9164cbaa52a3&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff331c6a4056b8fc7766941647aa3534927ce0005c5c5-b9WRQf_fw658',
    ];
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.width * (9 / 16.0),
      child: Swiper(
        itemCount: bannerArr.length,
        scrollDirection: Axis.horizontal,
        autoplay: true,
        viewportFraction: 0.8,
        layout: SwiperLayout.STACK,
        itemWidth: MediaQuery.of(context).size.width,
        itemHeight: 300,
        scale: 0.8,
        loop: true,
        onTap: (index) {
          print('点击了第${index + 1}张图片');
        },
        onIndexChanged: (value) {
          // int index = value;
          // print('滚动到了第${index + 1}张图片');
        },
        itemBuilder: (context, index) {
          return _buildImage(bannerArr[index], 1);
        },
      ),
    );
  }

  Widget _buildImage(String url, int flex) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(0),
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(
              right: 10,
              bottom: 10,
            ),
            child: Text(
              'test',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<ListModel> listModels) {
    return ListView.builder(
      itemCount: listModels.length + 1,
      itemBuilder: (BuildContext context, int row) {
        bool sure = (row == 0);
        return sure
            ? _buildTopView()
            : GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (row == 1) {
                    _gotoDetail(_checkIndex(row));
                  } else if (row == 2) {
                    _gotoContainerDemo();
                  } else if (row == 3) {
                    _gotoPaddingAlignCenter();
                  } else if (row == 4) {
                    _gotoSendDemo();
                  }
                },
                child: _getRow(_checkIndex(row)),
              );
      },
      padding: const EdgeInsets.all(10),
    );
  }

  void _gotoSendDemo() {
    Navigator.pushNamed(
      context,
      HomePageRoutes.sendDemo,
      arguments: {'data': '哈哈哈'},
    );
  }

  void _gotoContainerDemo() {
    Navigator.of(context).push(
      AnimationCustomRoute(
        widget: SubjectPage(),
        type: animationType.rotation,
      ),
    );
  }

  void _gotoPaddingAlignCenter() {
    Navigator.of(context).push(
      AnimationCustomRoute(
        widget: PaddingAlignCenter(),
        type: animationType.scale,
      ),
    );
  }

  void _gotoDetail(ListModel model) async {
    final result = await Navigator.of(context).pushNamed(
      HomePageRoutes.detail,
      arguments: model,
    );
    if (result == null) return;
    ListModel currentModel = result;
    setState(() {
      for (ListModel obj in _viewModel.listModels) {
        if (obj.index == currentModel.index) {
          obj.name = currentModel.name;
        }
      }
    });
    Fluttertoast.showToast(
      msg: '${currentModel.index + 1}--${currentModel.name}',
      gravity: ToastGravity.CENTER,
    );
  }

  ListModel _checkIndex(int index) {
    return _viewModel.listModels[index - 1];
  }

  Widget _getRow(ListModel model) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(left: 10, right: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.ltr,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: model.avatar,
                  width: 80,
                  height: 80,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '第${model.index + 1}个人的名字',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(
                      '${model.name}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: Image.asset(
              'lib/assets/images/nature.jpeg',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
