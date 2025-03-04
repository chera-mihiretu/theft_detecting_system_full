import 'package:dio/dio.dart';
import 'package:theft_detecting_system/config/environment.dart';
import 'package:theft_detecting_system/features/home/domain/entities/video_stream.dart';

abstract class VideoRemoteDataSource {
  Future<VideoStream> getStreamUrl();
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  final Dio _dio;

  VideoRemoteDataSourceImpl({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<VideoStream> getStreamUrl() async {
    try {
      final response = await _dio.get(Environment.videoStreamApiUrl);
      
      if (response.statusCode == 200) {
        final data = response.data;
        return VideoStream(
          id: data['id'] ?? 'stream_${DateTime.now().millisecondsSinceEpoch}',
          url: data['url'] ?? '',
          title: data['title'] ?? 'Live Stream',
          timestamp: DateTime.now(),
          isLive: data['isLive'] ?? true,
          thumbnailUrl: data['thumbnailUrl'],
        );
      } else {
        throw Exception('Failed to get stream URL: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get stream URL: $e');
    }
  }
}
