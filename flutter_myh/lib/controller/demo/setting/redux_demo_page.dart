import 'package:flutter/material.dart';
import 'package:flutter_myh/controller/setting_page/setting_config.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../base/base_container.dart';
import '../../../controller/setting_page/setting_page_routes.dart';

class ArtcleModel {
  String author;
  num id;
  String title;
  ArtcleModel({
    this.id,
    this.title,
    this.author,
  });
}

class AddArticleItemAction {
  ArtcleModel item;
  AddArticleItemAction({
    this.item,
  });

  static List<ArtcleModel> addArticleItem(
      List<ArtcleModel> list, AddArticleItemAction action) {
    list?.add(action?.item);
    return list;
  }
}

class RemoveArticleItemAction {
  ArtcleModel item;
  RemoveArticleItemAction({
    this.item,
  });

  static List<ArtcleModel> removeArticleItem(
      List<ArtcleModel> list, RemoveArticleItemAction action) {
    list?.remove(action?.item);
    return list;
  }
}

class LoadArticleItemAction {
  List<ArtcleModel> items;
  LoadArticleItemAction({
    this.items,
  });

  static List<ArtcleModel> loadArticleItem(
      List<ArtcleModel> list, LoadArticleItemAction action) {
    list?.addAll(action?.items);
    return list;
  }
}

// 绑定action与动作
final articlesReducers = combineReducers<List<ArtcleModel>>([
  TypedReducer<List<ArtcleModel>, AddArticleItemAction>(
      AddArticleItemAction.addArticleItem),
  TypedReducer<List<ArtcleModel>, RemoveArticleItemAction>(
      RemoveArticleItemAction.removeArticleItem),
  TypedReducer<List<ArtcleModel>, LoadArticleItemAction>(
      LoadArticleItemAction.loadArticleItem),
]);

class ArtcleState {
  List<ArtcleModel> artcleListState;
  ArtcleState({
    this.artcleListState,
  });
  ArtcleState.initialState() {
    artcleListState = List<ArtcleModel>();
  }
}

ArtcleState artcleReducer(ArtcleState state, action) {
  return ArtcleState(
      artcleListState: articlesReducers(state.artcleListState, action));
}

class ReduxDemoPage extends StatefulWidget {
  @override
  _ReduxDemoPageState createState() => _ReduxDemoPageState();
}

class _ReduxDemoPageState extends State<ReduxDemoPage> {
  final store = Store<ArtcleState>(
    artcleReducer,
    initialState: ArtcleState.initialState(),
  );
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<ArtcleState>(builder: (_, store) {
        return ArticelPage(
          store: store,
        );
      }),
    );
  }
}

class ArticelPage extends StatefulWidget {
  final Store<ArtcleState> store;
  ArticelPage({this.store});
  @override
  _ArticelPageState createState() => _ArticelPageState();
}

class _ArticelPageState extends State<ArticelPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    List<ArtcleModel> list = List();
    list.add(ArtcleModel(
      id: 100,
      title: '测试',
      author: 'iOS开发',
    ));
    StoreProvider.of<ArtcleState>(context)
        .dispatch(LoadArticleItemAction(items: list));
  }

  @override
  Widget build(BuildContext context) {
    return BaseNormalContainer(
      title: 'redux练习',
      tailing: StoreConnector<ArtcleState, ArticleViewModel>(
        builder: (_, viewModel) {
          return IconButton(
            icon: Icon(
              Icons.add,
              size: 30.0,
            ),
            onPressed: () => viewModel.addItem(
              ArtcleModel(
                id: viewModel.artcleList.length,
                title: '测试',
                author: 'iOS开发',
              ),
            ),
          );
        },
        converter: (store) => ArticleViewModel.create(store),
      ),
      body: StoreConnector<ArtcleState, ArticleViewModel>(
        builder: (_, viewModel) {
          return viewModel.artcleList.length == 0
              ? Center(
                  child: Text('暂无数据'),
                )
              : ListView.builder(
                  itemCount: viewModel.artcleList.length,
                  itemBuilder: (_, int row) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.pushNamed(
                          context, SettingPageRoutes.reduxDetail,
                          arguments: widget.store),
                      child: ListTile(
                        subtitle: Text(viewModel.artcleList[row].id.toString()),
                        title: Text(viewModel.artcleList[row].title),
                        leading: Text(viewModel.artcleList[row].author),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              viewModel.removeItem(viewModel.artcleList[row]),
                        ),
                      ),
                    );
                  });
        },
        converter: (store) => ArticleViewModel.create(store),
      ),
    );
  }
}

class ArticleViewModel {
  List<ArtcleModel> artcleList;
  Function(ArtcleModel) addItem;
  Function(ArtcleModel) removeItem;
  ArticleViewModel({
    this.artcleList,
    this.addItem,
    this.removeItem,
  });
  factory ArticleViewModel.create(Store<ArtcleState> store) {
    _addItem(ArtcleModel item) {
      store.dispatch(AddArticleItemAction(item: item));
    }

    _removeItem(ArtcleModel item) {
      store.dispatch(RemoveArticleItemAction(item: item));
    }

    return ArticleViewModel(
      artcleList: store.state.artcleListState,
      addItem: _addItem,
      removeItem: _removeItem,
    );
  }
}

class ArticleDetailPage extends StatefulWidget {
  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    Store<ArtcleState> store = ModalRoute.of(context).settings.arguments;
    return StoreProvider(
      store: store,
      child: StoreBuilder<ArtcleState>(builder: (_, store) {
        return BaseNormalContainer(
          title: '详情',
          tailing: StoreConnector<ArtcleState, ArticleViewModel>(
            builder: (_, viewModel) {
              return IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30.0,
                ),
                onPressed: () => viewModel.addItem(
                  ArtcleModel(
                    id: viewModel.artcleList.length,
                    title: '测试',
                    author: 'iOS开发',
                  ),
                ),
              );
            },
            converter: (store) => ArticleViewModel.create(store),
          ),
          body: StoreConnector<ArtcleState, ArticleViewModel>(
            builder: (_, viewModel) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    if (viewModel.artcleList.length > 0) {
                      viewModel.removeItem(viewModel.artcleList[0]);
                    }
                  },
                  child: Text('当前数据${viewModel.artcleList.length}条'),
                ),
              );
            },
            converter: (store) => ArticleViewModel.create(store),
          ),
        );
      }),
    );
  }
}
