import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4')
      ..initialize().then((value) {
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _controller.play();
          });
        });
      });
    _controller.addListener(() {
      if (!_controller.value.isPlaying) {}
    });
  }

  @override
  void dispose() {
    _controller.pause();
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('player'),
      ),
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(
                alignment: Alignment.center,
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        'https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
