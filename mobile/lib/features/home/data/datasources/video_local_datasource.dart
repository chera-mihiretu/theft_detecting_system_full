import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theft_detecting_system/config/environment.dart';
import 'package:theft_detecting_system/features/home/domain/entities/video_stream.dart';

abstract class VideoLocalDataSource {
  Future<void> cacheVideo(VideoStream video);
  Future<List<VideoStream>> getCachedVideos();
  Future<void> clearCache();
  Future<int> getCacheSize();
}

class VideoLocalDataSourceImpl implements VideoLocalDataSource {
  static const String _cacheKey = 'cached_videos';
  static const String _cacheSizeKey = 'cache_size';

  @override
  Future<void> cacheVideo(VideoStream video) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheDir = await getApplicationDocumentsDirectory();
      final videoDir = Directory('${cacheDir.path}/video_cache');
      
      if (!await videoDir.exists()) {
        await videoDir.create(recursive: true);
      }

      // Check cache size before adding new video
      final currentSize = await getCacheSize();
      final maxSizeBytes = Environment.videoCacheSizeMB * 1024 * 1024;
      
      if (currentSize > maxSizeBytes) {
        await _cleanOldestVideos();
      }

      // Store video metadata
      final cachedVideos = await getCachedVideos();
      cachedVideos.add(video);
      
      final videoJsonList = cachedVideos.map((v) => {
        'id': v.id,
        'url': v.url,
        'title': v.title,
        'timestamp': v.timestamp.toIso8601String(),
        'isLive': v.isLive,
        'thumbnailUrl': v.thumbnailUrl,
      }).toList();
      
      await prefs.setString(_cacheKey, videoJsonList.toString());
      
      // Update cache size (simplified - in real implementation, you'd track actual file sizes)
      await prefs.setInt(_cacheSizeKey, currentSize + 1024 * 1024); // Assume 1MB per video
      
    } catch (e) {
      throw Exception('Failed to cache video: $e');
    }
  }

  @override
  Future<List<VideoStream>> getCachedVideos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final videoJsonString = prefs.getString(_cacheKey);
      
      if (videoJsonString == null) return [];
      
      // Parse the stored videos (simplified - in real implementation, use proper JSON parsing)
      return [];
    } catch (e) {
      throw Exception('Failed to get cached videos: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      await prefs.remove(_cacheSizeKey);
      
      final cacheDir = await getApplicationDocumentsDirectory();
      final videoDir = Directory('${cacheDir.path}/video_cache');
      
      if (await videoDir.exists()) {
        await videoDir.delete(recursive: true);
      }
    } catch (e) {
      throw Exception('Failed to clear cache: $e');
    }
  }

  @override
  Future<int> getCacheSize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_cacheSizeKey) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<void> _cleanOldestVideos() async {
    try {
      final cachedVideos = await getCachedVideos();
      if (cachedVideos.isEmpty) return;
      
      // Sort by timestamp and remove oldest
      cachedVideos.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      final videosToKeep = cachedVideos.skip(1).toList(); // Remove oldest
      
      final prefs = await SharedPreferences.getInstance();
      final videoJsonList = videosToKeep.map((v) => {
        'id': v.id,
        'url': v.url,
        'title': v.title,
        'timestamp': v.timestamp.toIso8601String(),
        'isLive': v.isLive,
        'thumbnailUrl': v.thumbnailUrl,
      }).toList();
      
      await prefs.setString(_cacheKey, videoJsonList.toString());
    } catch (e) {
      throw Exception('Failed to clean oldest videos: $e');
    }
  }
}
