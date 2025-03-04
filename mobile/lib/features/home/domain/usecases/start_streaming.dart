import 'package:theft_detecting_system/features/home/domain/entities/video_stream.dart';
import 'package:theft_detecting_system/features/home/domain/repositories/video_repository.dart';

class StartStreaming {
  final VideoRepository repository;

  StartStreaming(this.repository);

  Future<VideoStream> call() async {
    return await repository.startStreaming();
  }
}
