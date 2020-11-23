import 'package:flutter/material.dart';

class SampleWidgetDemoPage extends StatefulWidget {
  @override
  _SampleWidgetDemoPageState createState() => _SampleWidgetDemoPageState();
}

class _SampleWidgetDemoPageState extends State<SampleWidgetDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sample demo'),
      ),
      body: SampleWidgetDemoView(),
    );
  }
}

class SampleWidgetDemoView extends StatefulWidget {
  @override
  _SampleWidgetDemoViewState createState() => _SampleWidgetDemoViewState();
}

class _SampleWidgetDemoViewState extends State<SampleWidgetDemoView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: UnconstrainedBox(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 30,
              minWidth: 30,
              maxHeight: 200,
              maxWidth: 200,
            ),
            child: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.purple,
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
