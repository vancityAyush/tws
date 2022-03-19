import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SubCategoryDetail extends StatefulWidget {
  final String video, description, name;
  SubCategoryDetail({this.video, this.description, this.name});

  @override
  State<SubCategoryDetail> createState() => _SubCategoryDetailState();
}

class _SubCategoryDetailState extends State<SubCategoryDetail> {
  FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
          "http://fitnessapp.frantic.in/" + widget.video),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0XFF2CB3BF),
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VisibilityDetector(
              key: ObjectKey(flickManager),
              onVisibilityChanged: (visibility) {
                if (visibility.visibleFraction == 0 && this.mounted) {
                  flickManager.flickControlManager?.autoPause();
                } else if (visibility.visibleFraction == 1) {
                  flickManager.flickControlManager?.autoResume();
                }
              },
              child: FlickVideoPlayer(
                flickManager: flickManager,
                flickVideoWithControlsFullscreen: FlickVideoWithControls(
                  controls: FlickLandscapeControls(),
                  videoFit: BoxFit.fitWidth,
                  willVideoPlayerControllerChange: false,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.description,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
