# Gamified Todo App

A Flutter-based gamified todo application with authentication and token refresh flow.

## Prerequisites

- Flutter SDK (3.10.0 or higher)
- Dart SDK (included with Flutter)
- Android Studio or Xcode (for emulator)
- A running backend API server

## Project Structure

```
lib/
├── core/
│   ├── constants/       # API endpoints, storage keys
│   ├── errors/          # Custom exceptions
│   ├── network/         # Dio HTTP client
│   └── services/        # Token storage service
├── env/                 # Environment configuration
├── models/              # Data models
├── modules/
│   ├── auth/            # Login/authentication
│   └── main/            # Main app screens
├── repositories/        # API repositories
├── routes/              # Navigation routes and middleware
├── theme/               # App theme
└── widgets/             # Reusable widgets
```

## Setup Instructions

### 1. Clone and Install Dependencies

```bash
git clone <repository-url>
cd gamified_todo_app
flutter pub get
```

### 2. Configure Environment

Copy the example environment file and configure your backend URL:

```bash
cp env/.env.example env/.env.dev
cp env/.env.example env/.env.prod
```

Edit `env/.env.dev` with your local backend URL:

```
BASE_URL=http://10.0.2.2:8080/api
```

**Note**: For Android emulator, use `10.0.2.2` instead of `127.0.0.1` to access localhost.
For iOS simulator, use `127.0.0.1` or `localhost`.

### 3. Start Your Backend API

Ensure your backend is running and accessible at the configured URL. The app expects these endpoints:

- `POST /v1/auth/login` - Login with email/password
- `POST /v1/auth/refresh` - Refresh access token
- `GET /v1/user/me` - Get current user info

### 4. Run the Application

#### Development Mode (Android Emulator)

1. Start Android emulator:
   ```bash
   flutter emulators --launch <emulator-id>
   ```
   Or open Android Studio → AVD Manager → Launch emulator

2. Run the app:
   ```bash
   flutter run --debug
   ```

#### Development Mode (iOS Simulator)

1. Start iOS simulator:
   ```bash
   open -a Simulator
   ```

2. Run the app:
   ```bash
   flutter run --debug
   ```

#### Production Build

```bash
flutter run --release
```

Or build APK/IPA:

```bash
flutter build apk --release
flutter build ios --release
```

## Authentication Flow

The app implements automatic token management:

1. **Startup**: App checks for valid access token via AuthMiddleware
2. **Valid Token**: Navigates to Main screen
3. **No Token**: Redirects to Login screen
4. **401 Error**: Automatically attempts token refresh
5. **Refresh Success**: Retries the original request
6. **Refresh Failure**: Clears tokens and redirects to Login

### Token Storage

Tokens are securely stored using `flutter_secure_storage`:
- Access token: Used for API authentication
- Refresh token: Used to obtain new access token

## API Response Format

The app expects the following API response structure:

```json
{
  "success": true,
  "message": "Success message",
  "data": {
    "accessToken": "your-access-token",
    "refreshToken": "your-refresh-token"
  },
  "status": 200,
  "path": "/v1/auth/login"
}
```

Error responses:

```json
{
  "success": false,
  "message": "Error message",
  "data": null,
  "status": 401,
  "path": "/v1/auth/refresh",
  "error": "Token Expired",
  "details": null
}
```

## Emulator Network Configuration

### Android Emulator

- `10.0.2.2` maps to host `127.0.0.1`
- `10.0.2.15` is the emulator's own loopback
- Use `10.0.2.2:8080` to access `localhost:8080` on your machine

### iOS Simulator

- Use `127.0.0.1` or `localhost` directly
- No special mapping required

## Common Issues

### 1. Connection Refused

If you get connection errors:
- Verify backend is running
- Check firewall settings
- Use correct IP for emulator (see above)

### 2. Token Expired Immediately

- Check system time on emulator matches host
- Verify token expiration time in backend

### 3. Build Errors

```bash
flutter clean
flutter pub get
flutter run
```

## Development

### Code Formatting

```bash
dart format .
```

### Analysis

```bash
flutter analyze
```

## License

This project is licensed under the MIT License.
