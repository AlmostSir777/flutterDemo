import 'package:flutter/material.dart';

class SendActivity extends StatefulWidget {
  _SendActivityState createState() => _SendActivityState();
}

class _SendActivityState extends State<SendActivity> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    print(args);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '发布成功',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Image.asset('lib/assets/images/nav_close.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SendViewPage(),
    );
  }
}

class SendViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _sendView();
  }

  Widget _sendView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildTop(),
        _buildCenter(),
        _buildTip(),
        _buildShareView(),
      ],
    );
  }

  Widget _buildTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
          ),
          child: CircleAvatar(
            backgroundImage: AssetImage('lib/assets/images/avatar2.png'),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 7, top: 17.0),
          child: Stack(
            alignment: Alignment.centerLeft,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Image.asset('lib/assets/images/publish_chat_box.png'),
              Container(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  '张老师发布了一个任务，请接收~',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCenter() {
    List itemArray = ['10', '11', '12', '13'];
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 6, bottom: 20, right: 6),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.all(const Radius.circular(16.0)),
        child: Container(
          padding: const EdgeInsets.all(12),
          color: const Color(0xfff0D5A9),
          child: Container(
            color: const Color(0xFF3C594E),
            child: Container(
              padding: const EdgeInsets.only(left: 20.0, top: 30.0, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Unit 1 Lesson 3 About animal',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child:
                        Image.asset('lib/assets/images/publish_work_line.png'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, right: 80),
                    child: Wrap(
                      children: _textList(itemArray),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 200),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset('lib/assets/images/publish_work_sign.png'),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 4,
                            left: 5,
                          ),
                          child: Text(
                            '预习',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 10.0),
                    alignment: Alignment.topRight,
                    child: Text(
                      '明天12:00截止',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFFFFC1C1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _textList(List array) {
    List list = <Widget>[];
    for (String item in array) {
      list.add(_buildText('课文跟读 $item'));
    }
    return list;
  }

  Widget _buildTip() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                right: 10.0,
              ),
              color: const Color(0xFFD4CFE4),
              height: 1.0,
            ),
          ),
          Text(
            '给家长发个通知吧',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF757085),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
              ),
              color: const Color(0xFFD4CFE4),
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text) {
    return Container(
      padding: const EdgeInsets.only(right: 10, top: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildShareView() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset('lib/assets/images/share_qq.png'),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15),
            child: Image.asset('lib/assets/images/share_wechat.png'),
          ),
        ],
      ),
    );
  }
}
