import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoCardWidget extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnailUrl;
  final String? title;
  final String? description;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const VideoCardWidget({
    super.key,
    this.videoUrl,
    this.thumbnailUrl,
    this.title,
    this.description,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  State<VideoCardWidget> createState() => _VideoCardWidgetState();
}

class _VideoCardWidgetState extends State<VideoCardWidget> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _isInitialized = false;
  bool _hasError = false;

  // Sample video URLs (you can replace with your own)
  final String _sampleVideoUrl =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    final videoUrl = widget.videoUrl ?? _sampleVideoUrl;

    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            _hasError = true;
          });
        }
        print('Video initialization error: $error');
      });

    _controller?.addListener(() {
      if (mounted) {
        setState(() {
          _isPlaying = _controller?.value.isPlaying ?? false;
        });
      }
    });
  }

  void _togglePlayPause() {
    if (_controller != null && _isInitialized) {
      if (_isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildVideoArea() {
    if (_hasError) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFF3D2A52),
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 24),
              SizedBox(height: 4),
              Text(
                'Video failed to load',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFF3D2A52),
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF8EC9ED),
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.black,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Video player
            AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),

            // Play/Pause overlay
            GestureDetector(
              onTap: _togglePlayPause,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: _isPlaying ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8EC9ED).withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Video controls (optional)
            if (_isPlaying)
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: VideoProgressIndicator(
                    _controller!,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: const Color(0xFF8EC9ED),
                      bufferedColor: Colors.white.withOpacity(0.5),
                      backgroundColor: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? 320,
        height: widget.height ?? screenHeight * 0.4,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: const Color(0xFF533E59)),
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6B4E7D),
              Color(0xFF4A3B5C),
              Color(0xFF2A1E3D),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video area
              Container(
                height: 155.h,
                width: double.infinity,
                child: _buildVideoArea(),
              ),

              const SizedBox(height: 16),

              // Content area
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile and rating area
                    Row(
                      children: [
                        // Profile circle
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF8EC9ED),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Rating bars
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8EC9ED),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 24,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8EC9ED),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Content placeholder lines
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B6B9C),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B6B9C),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B6B9C),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B6B9C),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B6B9C),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B6B9C),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    Container(
                      width: double.infinity * 0.7,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B6B9C),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
