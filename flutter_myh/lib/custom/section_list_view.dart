import 'package:flutter/material.dart';

typedef Widget HeaderComplete(BuildContext context);
typedef Widget FooterComplete(BuildContext context);
typedef Widget SectionHeaderComplete(BuildContext context, int section);
typedef Widget SectionFooterComplete(BuildContext context, int section);
typedef Widget ItemComplete(BuildContext context, IndexPath indexPath);
typedef int SectionCount();
typedef int ItemsCount(int section);

class SectionListView extends StatefulWidget {
  final HeaderComplete headerComplete;
  final FooterComplete footerComplete;
  final SectionHeaderComplete headerSectionComplete;
  final SectionFooterComplete footerSectionComplete;
  final ItemComplete itemComplete;
  final SectionCount sectionCount;
  final ItemsCount itemsCount;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  SectionListView({
    this.headerComplete,
    this.footerComplete,
    this.headerSectionComplete,
    this.footerSectionComplete,
    @required this.itemComplete,
    this.sectionCount,
    @required this.itemsCount,
    this.shrinkWrap = false,
    this.physics,
  });
  @override
  _SectionListViewState createState() => _SectionListViewState();
}

class _SectionListViewState extends State<SectionListView> {
  int _itemsAllCount;
  ScrollController _controller;
  void _loadItemsCount() {
    int _itemsCount = 2;

    int sectionCount = widget.sectionCount != null ? widget.sectionCount() : 1;

    _itemsCount += sectionCount * 2;

    for (int i = 0; i < sectionCount; i++) {
      _itemsCount += widget.itemsCount(i);
    }
    _itemsAllCount = _itemsCount;
  }

  Widget _loadItems(BuildContext context, int row) {
    Widget item;
    int _itemsCount = 1;
    if (row == 0) {
      item = widget.headerComplete != null
          ? widget.headerComplete(context)
          : Container();
    } else if (row == _itemsAllCount) {
      item = widget.footerComplete != null
          ? widget.footerComplete(context)
          : Container();
    } else {
      int sectionCount =
          widget.sectionCount != null ? widget.sectionCount() : 1;

      for (int i = 0; i < sectionCount; i++) {
        int sectionItemCount = widget.itemsCount(i);
        if (row == _itemsCount) {
          item = widget.headerSectionComplete != null
              ? widget.headerSectionComplete(context, i)
              : Container();
        } else if (row <= _itemsCount + sectionItemCount) {
          item = widget.itemComplete(
              context, IndexPath(section: i, row: row - _itemsCount - 1));
        } else if (row == _itemsCount + sectionItemCount + 1) {
          item = widget.footerSectionComplete != null
              ? widget.footerSectionComplete(context, i)
              : Container();
        }
        if (item != null) {
          break;
        }
        _itemsCount += sectionItemCount + 2;
      }
    }
    return item;
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        print(_controller.offset);
      });
  }

  @override
  Widget build(BuildContext context) {
    _loadItemsCount();
    return SafeArea(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            height: 20,
            color: Colors.red,
          ),
          NotificationListener(
            onNotification: (Notification notification) {
              if (notification is ScrollStartNotification) {
                print('滚动开始');
              }
              if (notification is ScrollUpdateNotification) {
                print('滚动中');
              }
              if (notification is ScrollEndNotification) {
                print('停止滚动');
                if (_controller.position.extentAfter == 0) {
                  print('滚动到底部');
                }
                if (_controller.position.extentBefore == 0) {
                  print('滚动到头部');
                }
              }
              return true;
            },
            child: ListView.builder(
              shrinkWrap: widget.shrinkWrap ?? false,
              physics: widget.physics,
              itemCount: _itemsAllCount,
              controller: _controller,
              itemBuilder: (_, int row) {
                return _loadItems(_, row) ?? Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IndexPath {
  final int section;
  final int row;
  IndexPath({
    @required this.section,
    @required this.row,
  });
}
