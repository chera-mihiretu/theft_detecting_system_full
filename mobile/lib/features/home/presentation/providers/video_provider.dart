import 'package:flutter/foundation.dart';
import 'package:theft_detecting_system/features/home/domain/entities/video_stream.dart';
import 'package:theft_detecting_system/features/home/domain/usecases/get_cached_videos.dart';
import 'package:theft_detecting_system/features/home/domain/usecases/start_streaming.dart';
import 'package:theft_detecting_system/features/home/domain/usecases/stop_streaming.dart';

class VideoProvider extends ChangeNotifier {
  final StartStreaming _startStreaming;
  final StopStreaming _stopStreaming;
  final GetCachedVideos _getCachedVideos;

  VideoProvider({
    required StartStreaming startStreaming,
    required StopStreaming stopStreaming,
    required GetCachedVideos getCachedVideos,
  })  : _startStreaming = startStreaming,
        _stopStreaming = stopStreaming,
        _getCachedVideos = getCachedVideos;

  VideoStream? _currentStream;
  List<VideoStream> _cachedVideos = [];
  bool _isLoading = false;
  bool _isStreaming = false;
  String? _error;

  VideoStream? get currentStream => _currentStream;
  List<VideoStream> get cachedVideos => _cachedVideos;
  bool get isLoading => _isLoading;
  bool get isStreaming => _isStreaming;
  String? get error => _error;

  Future<void> startStreaming() async {
    _setLoading(true);
    _clearError();

    try {
      _currentStream = await _startStreaming();
      _isStreaming = true;
      notifyListeners();
    } catch (e) {
      _setError('Failed to start streaming: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> stopStreaming() async {
    _setLoading(true);
    _clearError();

    try {
      await _stopStreaming();
      _isStreaming = false;
      notifyListeners();
    } catch (e) {
      _setError('Failed to stop streaming: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadCachedVideos() async {
    _setLoading(true);
    _clearError();

    try {
      _cachedVideos = await _getCachedVideos();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load cached videos: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}
