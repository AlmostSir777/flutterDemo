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
    Fluttertoast.showToast(msg: '数据加载完毕');
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
              Consumer<BannerViewModel>(builder: (_, viewModel, __) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.list.length,
                    itemBuilder: (_, int row) {
                      BannerModel value = viewModel.list[row];
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
                                  imageUrl: value.imgUrl,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                Text(value.title),
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
                    });
              }),
              Container(
                padding: EdgeInsets.only(top: 20),
                height: 40,
                child: Center(
                  child: GestureDetector(
                    onTap: () => _timeCountModel.timeAdd(),
                    child: Text('点击计数'),
                  ),
                ),
              ),
              Selector<TimeCountModel, int>(
                builder: (_, count, __) {
                  return Container(
                    alignment: Alignment.center,
                    height: 40,
                    color: Colors.blue,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('当前计数${count.toString()}'),
                      ],
                    ),
                  );
                },
                selector: (_, viewModel) => viewModel.timeCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
