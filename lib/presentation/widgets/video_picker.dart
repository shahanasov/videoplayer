import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'package:noviindusvideoapp/providers/add_feed_provider.dart';

class VideoUploadWidget extends StatefulWidget {
  const VideoUploadWidget({super.key});

  @override
  State<VideoUploadWidget> createState() => _VideoUploadWidgetState();
}

class _VideoUploadWidgetState extends State<VideoUploadWidget> {
  VideoPlayerController? _videoController;
  File? _currentVideo;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _initVideo(File file) {
    _videoController?.dispose();
    _videoController = VideoPlayerController.file(file)
      ..initialize().then((_) {
        setState(() {});
        _videoController!.pause();
      });
    _currentVideo = file;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddFeedProvider>();

    // Initialize only if the video has changed
    if (provider.video != null && provider.video != _currentVideo) {
      _initVideo(provider.video!);
    }

    return GestureDetector(
      onTap: () async {
        await provider.pickVideo();
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFF404040),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: _videoController != null && _videoController!.value.isInitialized
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: double.infinity,
                  height: 200, 
                  child: FittedBox(
                    fit: BoxFit.cover, 
                    child: SizedBox(
                      width: _videoController!.value.size.width,
                      height: _videoController!.value.size.height,
                      child: VideoPlayer(_videoController!),
                    ),
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFF404040),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Select a video from Gallery',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
      ),
    );
  }
}
