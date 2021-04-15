import 'package:api_base/pages/videos/video_model.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerItem extends StatefulWidget {
  final VideoModel videoModel;
  final FlickManager flickManager;

  const VideoPlayerItem({Key key, @required this.videoModel, this.flickManager}) : super(key: key);
  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {



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
    return VisibilityDetector(
      key: ObjectKey(widget.flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          widget.flickManager.flickControlManager.autoPause();
        } else if (visibility.visibleFraction == 1) {
          widget.flickManager.flickControlManager.autoResume();
        }

      },
      child: Container(

        child: FlickVideoPlayer(
          flickManager: widget.flickManager,

          flickVideoWithControls: FlickVideoWithControls(
            controls: FlickPortraitControls(),

          ),
          flickVideoWithControlsFullscreen: FlickVideoWithControls(
            controls: FlickLandscapeControls(),

          ),


        ),
      ),
    );
  }
}