import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/provider_test_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProviderMorePage extends StatefulWidget {
  @override
  _ProviderMorePageState createState() => _ProviderMorePageState();
}

class _ProviderMorePageState extends State<ProviderMorePage> {
  TimeCountModel _timeCountModel;
  BannerViewModel _bannerViewModel;
  @override
  void initState() {
    _timeCountModel = TimeCountModel();
    _bannerViewModel = BannerViewModel();
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await _bannerViewModel.loadData();
    Fluttertoast.showToast(
      msg: '数据加载完毕',
      gravity: ToastGravity.CENTER,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('多个viewmodel应用'),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<TimeCountModel>(
            create: (context) => _timeCountModel,
          ),
          ChangeNotifierProvider<BannerViewModel>(
            create: (context) => _bannerViewModel,
          ),
        ],
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Selector<TimeCountModel, int>(
                builder: (_, count, __) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        height: 40,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              _timeCountModel.timeAdd();
                            },
                            child: Text('点击计数'),
                          ),
                        ),
                      ),
                      Text('当前计数${count.toString()}',
                          style: TextStyle(
                            backgroundColor: Colors.red,
                          )),
                    ],
                  );
                },
                selector: (_, viewModel) => viewModel.timeCount,
              ),
              Consumer<BannerViewModel>(builder: (_, viewModel, __) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.list.length,
                    itemBuilder: (_, int row) {
                      BannerModel value = viewModel.list[row];
                      return BannerItem(item: value);
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class BannerItem extends StatefulWidget {
  final BannerModel item;
  BannerItem({this.item});
  @override
  _BannerItemState createState() => _BannerItemState();
}

class _BannerItemState extends State<BannerItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          height: 49,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.item.imgUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              Text(widget.item.title),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.item.isCollect = !widget.item.isCollect;
                  });
                },
                child: Icon(
                    widget.item.isCollect ? Icons.flash_on : Icons.flash_off),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width: MediaQuery.of(context).size.width,
          height: 0.5,
        ),
      ],
    );
  }
}
