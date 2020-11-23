import 'package:flutter/material.dart';

enum ViewState {
  alignState,
  centerState,
  paddingState,
}

class PaddingAlignCenter extends StatefulWidget {
  _PaddingAlignCenterState createState() => _PaddingAlignCenterState();
}

class _PaddingAlignCenterState extends State<PaddingAlignCenter> {
  ViewState currentState = ViewState.alignState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('padding-align-center'),
      ),
      body: _buildView(),
    );
  }

  Widget _buildView() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.yellow,
      child: Stack(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              _refreshState();
            },
            color: Colors.green,
          ),
          _buildViewForState(),
        ],
      ),
    );
  }

  Widget _buildViewForState() {
    var view;
    switch (currentState) {
      case ViewState.alignState:
        {
          view = _buildAlign();
          break;
        }
      case ViewState.centerState:
        {
          view = _buildCenter();
          break;
        }
        break;
      default:
        {
          view = _buildPadding();
          break;
        }
    }
    return view;
  }

  void _refreshState() {
    ViewState state = ViewState.alignState;
    switch (currentState) {
      case ViewState.alignState:
        {
          state = ViewState.centerState;
          break;
        }
      case ViewState.centerState:
        {
          state = ViewState.paddingState;
          break;
        }
        break;
      default:
        {
          state = ViewState.alignState;
          break;
        }
    }
    setState(() {
      currentState = state;
    });
  }

  Widget _buildAlign() {
    return Align(
      alignment: Alignment.topRight,
      widthFactor: 6,
      heightFactor: 2,
      child: Text(
        'align',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildCenter() {
    return Center(
      widthFactor: 6,
      heightFactor: 2,
      child: Text(
        'center',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildPadding() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 80),
      child: Text(
        'padding',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
