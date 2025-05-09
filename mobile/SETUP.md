# Theft Detecting System - Setup Instructions

## Environment Configuration

Create a `.env` file in the root directory with the following variables:

```env
# API Configuration
VIDEO_STREAM_API_URL=https://api.example.com/stream
NOTIFICATION_API_URL=https://api.example.com/notifications
VIDEO_CACHE_SIZE_MB=100

# Firebase Configuration
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
FIREBASE_APP_ID=your-app-id

# Google Sign-In Configuration
GOOGLE_CLIENT_ID=your-google-client-id
```

## Firebase Setup

1. Create a Firebase project at https://console.firebase.google.com/
2. Enable Authentication and Google Sign-In
3. Download the configuration files:
   - `google-services.json` for Android (place in `android/app/`)
   - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)
4. Update the `.env` file with your Firebase project details

## Google Sign-In Setup

1. Go to Google Cloud Console
2. Create or select a project
3. Enable Google+ API
4. Create OAuth 2.0 credentials
5. Add your app's package name and SHA-1 fingerprint
6. Update the `GOOGLE_CLIENT_ID` in your `.env` file

## API Endpoints

The app expects the following API endpoints:

### Video Streaming API
- **Endpoint**: `GET /stream`
- **Response**: 
```json
{
  "id": "stream_id",
  "url": "rtmp://stream-url",
  "title": "Live Stream",
  "isLive": true,
  "thumbnailUrl": "https://thumbnail-url"
}
```

### Notifications API
- **Endpoint**: `GET /notifications`
- **Response**:
```json
[
  {
    "id": "notification_id",
    "title": "Motion Detected",
    "description": "Motion detected at camera location",
    "timestamp": "2025-01-16T20:08:55Z",
    "isRead": false,
    "videoUrl": "https://video-url",
    "thumbnailUrl": "https://thumbnail-url"
  }
]
```

## Features Implemented

### ✅ Firebase Authentication
- Google Sign-In integration
- User session management
- Authentication state persistence
- Clean architecture implementation

### ✅ Video Streaming
- Real-time video streaming from external API
- 100MB local cache for offline replay
- Video player integration
- Network error handling

### ✅ Notification System
- Real-time notification updates
- Motion detection alerts
- Video thumbnail display
- Mark as read functionality

### ✅ Clean Architecture
- Domain layer (entities, repositories, use cases)
- Data layer (data sources, models, repository implementations)
- Presentation layer (providers, pages)
- Dependency injection with GetIt

## Running the App

1. Install dependencies:
```bash
flutter pub get
```

2. Create your `.env` file with the configuration above

3. Run the app:
```bash
flutter run
```

## Architecture Overview

```
lib/
├── config/
│   └── environment.dart          # Environment configuration
├── core/
│   └── di/
│       └── injection.dart        # Dependency injection
└── features/
    ├── auth/                     # Authentication feature
    │   ├── domain/               # Business logic
    │   ├── data/                 # Data sources
    │   └── presentation/         # UI layer
    ├── home/                     # Video streaming feature
    │   ├── domain/
    │   ├── data/
    │   └── presentation/
    └── notification/             # Notification feature
        ├── domain/
        ├── data/
        └── presentation/
```

## Dependencies Added

- `firebase_core` & `firebase_auth` - Firebase authentication
- `google_sign_in` - Google Sign-In
- `video_player` & `cached_video_player` - Video streaming and caching
- `dio` & `http` - HTTP client for API calls
- `flutter_dotenv` - Environment variable management
- `provider` - State management
- `get_it` - Dependency injection
- `equatable` - Value objects
- `path_provider` & `shared_preferences` - Local storage
