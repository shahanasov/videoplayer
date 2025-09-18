import 'package:flutter/material.dart';
import 'package:noviindusvideoapp/core/theme/colors.dart';
import 'package:noviindusvideoapp/data/models/feed_model.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedCard extends StatefulWidget {
  final Feed feed;
  final bool isPlaying;
  final VoidCallback onPlay;

  const FeedCard({
    super.key,
    required this.feed,
    required this.isPlaying,
    required this.onPlay,
  });

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.isPlaying) _initVideo();
  }

  @override
  void didUpdateWidget(covariant FeedCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && _controller == null) {
      _initVideo();
    } else if (!widget.isPlaying && _controller != null) {
      _controller?.pause();
      _controller?.dispose();
      _controller = null;
    }
  }

  Future<void> _initVideo() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.feed.video),
    );
    await _controller!.initialize();
    setState(() {});
    _controller!.play();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    decoration: BoxDecoration(
      color:AppColors.secondary,
   
    ),
    child: Column(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1,),
          // User + Time
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 5),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: widget.feed.userImage != null
                    ? NetworkImage(widget.feed.userImage!)
                    : const AssetImage("assets/images/profile.jpg") as ImageProvider,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.feed.userName,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    timeAgo(widget.feed.createdAt.toString()),
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Video / Thumbnail
        Stack(
          children: [
            widget.isPlaying && _controller != null
                ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  )
                : Image.network(
                    widget.feed.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 280,
                  ),
            // Play button
            if (!widget.isPlaying)
              Positioned.fill(
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 60,
                    ),
                    onPressed: widget.onPlay,
                  ),
                ),
              ),
          ],
        ),

      

        // Description with See More
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
          child: RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: widget.feed.description,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              children: [
                 TextSpan(text: "..."),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                    
                    },
                    child: const Text(
                      'See More',
                      style: TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


  String timeAgo(String isoDateString) {
    if (isoDateString.isEmpty) return '';
    final date = DateTime.tryParse(isoDateString);
    if (date == null) return '';
    return timeago.format(date);
  }
}
