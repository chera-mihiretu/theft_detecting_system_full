import 'package:theft_detecting_system/features/home/domain/entities/video_stream.dart';
import 'package:theft_detecting_system/features/home/domain/repositories/video_repository.dart';

class GetCachedVideos {
  final VideoRepository repository;

  GetCachedVideos(this.repository);

  Future<List<VideoStream>> call() async {
    return await repository.getCachedVideos();
  }
}
