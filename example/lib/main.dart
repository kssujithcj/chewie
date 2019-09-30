import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(
    ChewieDemo(),
  );
}

class ChewieDemo extends StatefulWidget {
  ChewieDemo({this.title = 'Chewie Demo'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController videoPlayerController1,
      videoPlayerController2,
      videoPlayerController3,
      videoPlayerController4;
  //VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;
  Map<String, String> urls = {
    "360p":
        "https://player.vimeo.com/external/362730929.sd.mp4?s=498b307e8ffa7484e75a78ab1149227edb967066&profile_id=164",
    "480p":
        "https://player.vimeo.com/external/362730929.sd.mp4?s=498b307e8ffa7484e75a78ab1149227edb967066&profile_id=165",
    "720p":
        "https://player.vimeo.com/external/362730929.hd.mp4?s=7dddada22f5fc07aab62305884e55d843e1a480b&profile_id=174",
    "1080p":
        "https://player.vimeo.com/external/362730929.hd.mp4?s=7dddada22f5fc07aab62305884e55d843e1a480b&profile_id=175"
  };

  String selectedQuality = "720p";

  @override
  void initState() {
    super.initState();
    videoPlayerController1 = VideoPlayerController.network(urls["1080p"]);
    videoPlayerController2 = VideoPlayerController.network(urls["720p"]);
    videoPlayerController3 = VideoPlayerController.network(urls["480p"]);
    videoPlayerController4 = VideoPlayerController.network(urls["360p"]);
    /*_videoPlayerController2 = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4');*/
    _chewieController = createController(videoPlayerController2, false);
  }

  ChewieController createController(
      VideoPlayerController videoPlayerController, bool autoPlay) {
    return ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: autoPlay,
      autoInitialize: true,
      selectedQuality: selectedQuality,
      quality: ["1080p", "720p", "480p", "360p"],
      onQualitySelected: (quality) async {
        selectedQuality = quality;
        Duration duration =
            await _chewieController.videoPlayerController.position;
        _chewieController.dispose();
        _chewieController.videoPlayerController.pause();
        _chewieController.videoPlayerController.seekTo(Duration(seconds: 0));
        VideoPlayerController newVideoPlayerController =
            getVideoController(quality);
        newVideoPlayerController.seekTo(duration);
        _chewieController = createController(newVideoPlayerController, true);
        setState(() {});
      },
    );
  }

  VideoPlayerController getVideoController(String selected) {
    if (selected == "1080p") {
      //videoPlayerController1.seekTo(duration);
      return videoPlayerController1;
    } else if (selected == "720p") {
      //videoPlayerController2.seekTo(duration);
      return videoPlayerController2;
    } else if (selected == "480p") {
      //videoPlayerController3.seekTo(duration);
      return videoPlayerController3;
    } else {
      //videoPlayerController4.seekTo(duration);
      return videoPlayerController4;
    }
  }

  @override
  void dispose() {
    videoPlayerController1.dispose();
    videoPlayerController2.dispose();
    videoPlayerController3.dispose();
    videoPlayerController4.dispose();
    //_videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData.light().copyWith(platform: TargetPlatform.android),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
            /* FlatButton(
              onPressed: () {
                _chewieController.enterFullScreen();
              },
              child: Text('Fullscreen'),
            ),*/
            /*Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _chewieController.dispose();
                        _videoPlayerController2.pause();
                        _videoPlayerController2.seekTo(Duration(seconds: 0));
                        _chewieController = ChewieController(
                          videoPlayerController: _videoPlayerController1,
                          aspectRatio: 3 / 2,
                          autoPlay: true,
                          looping: true,
                          selectedQuality: "720p",
                          quality: ["1080p", "720p", "480p", "360p"],
                          onQualitySelected: (quality) {
                            print(quality);
                          },
                        );
                      });
                    },
                    child: Padding(
                      child: Text("Video 1"),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _chewieController.dispose();
                        _videoPlayerController1.pause();
                        _videoPlayerController1.seekTo(Duration(seconds: 0));
                        _chewieController = ChewieController(
                          videoPlayerController: _videoPlayerController2,
                          aspectRatio: 3 / 2,
                          autoPlay: true,
                          looping: true,
                          selectedQuality: "720p",
                          quality: ["1080p", "720p", "480p", "360p"],
                          onQualitySelected: (quality) {
                            print(quality);
                          },
                        );
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Error Video"),
                    ),
                  ),
                )
              ],
            ),*/
            /*Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.android;
                      });
                    },
                    child: Padding(
                      child: Text("Android controls"),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.iOS;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("iOS controls"),
                    ),
                  ),
                )
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
