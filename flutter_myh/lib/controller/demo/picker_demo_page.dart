import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

typedef DoneCallBack(String value);
typedef CancelCallBack();

class PickerTimeView extends StatefulWidget {
  final DoneCallBack doneCallBack;
  final CancelCallBack cancelCallBack;
  PickerTimeView({
    this.doneCallBack,
    this.cancelCallBack,
  });
  @override
  _PickerTimeViewState createState() => _PickerTimeViewState();
}

class _PickerTimeViewState extends State<PickerTimeView> {
  FixedExtentScrollController _fixedExtentScrollController;
  List<String> _list;
  @override
  void initState() {
    _fixedExtentScrollController = FixedExtentScrollController(initialItem: 4);
    _list = [];
    for (int i = 0; i < 24; i++) {
      _list.add(i < 10 ? '0${i.toString()}' : '${i.toString()}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.cancelCallBack != null) {
                        widget.cancelCallBack();
                      }
                    },
                    child: Text('取消'),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                    right: 15,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.doneCallBack != null) {
                        widget.doneCallBack(
                            _list[_fixedExtentScrollController.selectedItem]);
                      }
                    },
                    child: Text('确定'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 250,
            // width: 80,
            alignment: Alignment.center,
            child: CupertinoPicker.builder(
              childCount: _list.length,
              itemExtent: 36.0,
              backgroundColor: Colors.white,
              scrollController: _fixedExtentScrollController,
              itemBuilder: (_, int row) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(_list[row]),
                );
              },
              onSelectedItemChanged: (int row) {},
            ),
          ),
        ],
      ),
    );
  }
}
