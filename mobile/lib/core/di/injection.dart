import 'package:get_it/get_it.dart';
import 'package:theft_detecting_system/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:theft_detecting_system/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:theft_detecting_system/features/auth/domain/repositories/auth_repository.dart';
import 'package:theft_detecting_system/features/auth/domain/usecases/get_current_user.dart';
import 'package:theft_detecting_system/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:theft_detecting_system/features/auth/domain/usecases/sign_out.dart';
import 'package:theft_detecting_system/features/auth/presentation/providers/auth_provider.dart';
import 'package:theft_detecting_system/features/home/data/datasources/video_local_datasource.dart';
import 'package:theft_detecting_system/features/home/data/datasources/video_remote_datasource.dart';
import 'package:theft_detecting_system/features/home/data/repositories/video_repository_impl.dart';
import 'package:theft_detecting_system/features/home/domain/repositories/video_repository.dart';
import 'package:theft_detecting_system/features/home/domain/usecases/get_cached_videos.dart';
import 'package:theft_detecting_system/features/home/domain/usecases/start_streaming.dart';
import 'package:theft_detecting_system/features/home/domain/usecases/stop_streaming.dart';
import 'package:theft_detecting_system/features/home/presentation/providers/video_provider.dart';
import 'package:theft_detecting_system/features/notification/data/datasources/notification_remote_datasource.dart';
import 'package:theft_detecting_system/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:theft_detecting_system/features/notification/domain/repositories/notification_repository.dart';
import 'package:theft_detecting_system/features/notification/domain/usecases/delete_notification.dart';
import 'package:theft_detecting_system/features/notification/domain/usecases/get_notifications.dart';
import 'package:theft_detecting_system/features/notification/domain/usecases/mark_as_read.dart';
import 'package:theft_detecting_system/features/notification/presentation/providers/notification_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  await _initAuth();
  await _initHome();
  await _initNotification();
}

Future<void> _initAuth() async {
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));

  // Provider
  sl.registerFactory(() => AuthProvider(
    signInWithGoogle: sl(),
    signOut: sl(),
    getCurrentUser: sl(),
  ));
}

Future<void> _initHome() async {
  // Data sources
  sl.registerLazySingleton<VideoRemoteDataSource>(
    () => VideoRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<VideoLocalDataSource>(
    () => VideoLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<VideoRepository>(
    () => VideoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => StartStreaming(sl()));
  sl.registerLazySingleton(() => StopStreaming(sl()));
  sl.registerLazySingleton(() => GetCachedVideos(sl()));

  // Provider
  sl.registerFactory(() => VideoProvider(
    startStreaming: sl(),
    stopStreaming: sl(),
    getCachedVideos: sl(),
  ));
}

Future<void> _initNotification() async {
  // Data sources
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNotifications(sl()));
  sl.registerLazySingleton(() => MarkAsRead(sl()));
  sl.registerLazySingleton(() => DeleteNotification(sl()));

  // Provider
  sl.registerFactory(() => NotificationProvider(
    getNotifications: sl(),
    markAsRead: sl(),
    deleteNotification: sl(),
  ));
}
