import 'package:theft_detecting_system/features/home/data/datasources/video_local_datasource.dart';
import 'package:theft_detecting_system/features/home/data/datasources/video_remote_datasource.dart';
import 'package:theft_detecting_system/features/home/domain/entities/video_stream.dart';
import 'package:theft_detecting_system/features/home/domain/repositories/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remoteDataSource;
  final VideoLocalDataSource localDataSource;

  VideoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<VideoStream> startStreaming() async {
    final stream = await remoteDataSource.getStreamUrl();
    await localDataSource.cacheVideo(stream);
    return stream;
  }

  @override
  Future<void> stopStreaming() async {
    // Implementation for stopping the stream
    // This could involve stopping the video player, etc.
  }

  @override
  Future<List<VideoStream>> getCachedVideos() async {
    return await localDataSource.getCachedVideos();
  }

  @override
  Future<void> clearCache() async {
    await localDataSource.clearCache();
  }
}
