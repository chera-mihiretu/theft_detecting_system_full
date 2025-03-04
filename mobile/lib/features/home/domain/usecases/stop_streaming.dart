import 'package:theft_detecting_system/features/home/domain/repositories/video_repository.dart';

class StopStreaming {
  final VideoRepository repository;

  StopStreaming(this.repository);

  Future<void> call() async {
    await repository.stopStreaming();
  }
}
