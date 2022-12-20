import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  const VideoPlayerItem({super.key, required this.VideoUrl});
  final String VideoUrl;

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.VideoUrl)
      ..initialize().then((value) {
        controller.play();
        controller.setVolume(1);
        controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onDoubleTap: (() {
        controller.pause();
      }),
      onTap: (() {
        controller.play();
      }),
      child: Container(
        height: size.height,
        width: size.width,
        child: VideoPlayer(controller),
      ),
    );
  }
}
