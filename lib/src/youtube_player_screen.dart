import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';

class YoutubePlayerScreen extends StatefulWidget {
  final String title;
  final String url;
  final String videoId;
  final Function? onOpenYoutubeAppClicked;

  YoutubePlayerScreen(
    this.title,
    this.url,
    this.videoId, {
    this.onOpenYoutubeAppClicked,
  });

  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title ?? ''),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.onOpenYoutubeAppClicked != null) {
                widget.onOpenYoutubeAppClicked!();
                Navigator.of(context).maybePop();
              }
            },
            icon: const Icon(
              Icons.shop_two,
              size: 18,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: FlutterYoutubeView(
        scaleMode: YoutubeScaleMode.fitWidth, // <option> fitWidth, fitHeight
        params: YoutubeParam(
          videoId: widget.videoId,
          showUI: true,
          startSeconds: 0.0, // <option>
          autoPlay: false,
        ), // <option>
      ),
    );
  }
}
