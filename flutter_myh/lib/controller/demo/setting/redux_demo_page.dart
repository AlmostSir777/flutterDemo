import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../base/base_container.dart';

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

// 绑定action与动作
final articlesReducers = combineReducers<List<ArtcleModel>>([
  TypedReducer<List<ArtcleModel>, AddArticleItemAction>(
      AddArticleItemAction.addArticleItem),
  TypedReducer<List<ArtcleModel>, RemoveArticleItemAction>(
      RemoveArticleItemAction.removeArticleItem),
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
  @override
  Widget build(BuildContext context) {
    final store = Store<ArtcleState>(
      artcleReducer,
      initialState: ArtcleState.initialState(),
    );
    return StoreProvider(
      store: store,
      child: StoreBuilder<ArtcleState>(builder: (_, store) {
        return ArticelPage();
      }),
    );
  }
}

class ArticelPage extends StatefulWidget {
  @override
  _ArticelPageState createState() => _ArticelPageState();
}

class _ArticelPageState extends State<ArticelPage> {
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
                    return ListTile(
                      subtitle: Text(viewModel.artcleList[row].id.toString()),
                      title: Text(viewModel.artcleList[row].title),
                      leading: Text(viewModel.artcleList[row].author),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            viewModel.removeItem(viewModel.artcleList[row]),
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
