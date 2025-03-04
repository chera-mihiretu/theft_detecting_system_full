import 'package:theft_detecting_system/features/home/domain/entities/video_stream.dart';

abstract class VideoRepository {
  Future<VideoStream> startStreaming();
  Future<void> stopStreaming();
  Future<List<VideoStream>> getCachedVideos();
  Future<void> clearCache();
}
