import 'dart:io';
import 'package:flutter/material.dart';

/// Utility class for showing platform-adaptive snackbars and notifications.
///
/// Automatically detects the platform (Android/iOS) and shows appropriate
/// UI feedback with your app's neon green cyberpunk theme:
/// - **Android**: Material Design SnackBar
/// - **iOS**: Cupertino-style banner with iOS styling
///
/// **Usage:**
/// ```dart
/// // Success message
/// SnackbarUtils.showSuccess(
///   context,
///   message: 'Login successful!',
/// );
///
/// // Error message (perfect with ApiErrorHandler)
/// SnackbarUtils.showError(
///   context,
///   message: ApiErrorHandler.getErrorMessage(response),
/// );
///
/// // Info message
/// SnackbarUtils.showInfo(
///   context,
///   message: 'Please check your email',
/// );
/// ```
class SnackbarUtils {
  SnackbarUtils._(); // Private constructor to prevent instantiation

  // Theme colors matching AppTheme
  static const Color _neonGreen = Color(0xFF00FF41);
  // static const Color _darkGreen = Color(0xFF00B234);
  // static const Color _pureBlack = Color(0xFF000000);
  static const Color _darkGray = Color(0xFF2D2D2D);
  // static const Color _mediumGray = Color(0xFF3D3D3D);
  static const Color _textWhite = Color(0xFFFFFFFF);
  // static const Color _textGray = Color(0xFFB0B0B0);
  static const Color _errorRed = Color(0xFFFF4444);

  /// Shows a success message with neon green styling.
  ///
  /// **When to use:**
  /// - After successful login/registration
  /// - When data is saved successfully
  /// - After completing an action successfully
  ///
  /// **Example:**
  /// ```dart
  /// await authRepository.login(email, password);
  /// SnackbarUtils.showSuccess(context, message: 'Welcome back!');
  /// ```
  ///
  /// **Parameters:**
  /// - `context`: BuildContext for showing the snackbar
  /// - `message`: Success message to display
  /// - `duration`: How long to show (default: 3 seconds)
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackbar(
      context,
      message: message,
      type: _SnackbarType.success,
      duration: duration,
    );
  }

  /// Shows an error message with red styling matching your theme.
  ///
  /// **When to use:**
  /// - After failed API requests
  /// - When validation fails
  /// - When an exception occurs
  /// - Perfect for use with ApiErrorHandler
  ///
  /// **Example with ApiErrorHandler:**
  /// ```dart
  /// try {
  ///   await authRepository.login(email, password);
  /// } catch (e) {
  ///   if (e is ApiResponse) {
  ///     SnackbarUtils.showError(
  ///       context,
  ///       message: ApiErrorHandler.getErrorMessage(e),
  ///     );
  ///   }
  /// }
  /// ```
  ///
  /// **Parameters:**
  /// - `context`: BuildContext for showing the snackbar
  /// - `message`: Error message to display
  /// - `duration`: How long to show (default: 4 seconds for errors)
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _showSnackbar(
      context,
      message: message,
      type: _SnackbarType.error,
      duration: duration,
    );
  }

  /// Shows an informational message with cyan/blue styling.
  ///
  /// **When to use:**
  /// - Showing tips or hints
  /// - Neutral notifications
  /// - Status updates
  /// - Loading completion messages
  ///
  /// **Example:**
  /// ```dart
  /// SnackbarUtils.showInfo(
  ///   context,
  ///   message: 'Verification email sent',
  /// );
  /// ```
  ///
  /// **Parameters:**
  /// - `context`: BuildContext for showing the snackbar
  /// - `message`: Info message to display
  /// - `duration`: How long to show (default: 3 seconds)
  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackbar(
      context,
      message: message,
      type: _SnackbarType.info,
      duration: duration,
    );
  }

  /// Shows a warning message with amber/yellow styling.
  ///
  /// **When to use:**
  /// - Warning users about potential issues
  /// - Showing non-critical alerts
  /// - Confirmation messages before destructive actions
  ///
  /// **Example:**
  /// ```dart
  /// SnackbarUtils.showWarning(
  ///   context,
  ///   message: 'This action cannot be undone',
  /// );
  /// ```
  ///
  /// **Parameters:**
  /// - `context`: BuildContext for showing the snackbar
  /// - `message`: Warning message to display
  /// - `duration`: How long to show (default: 3 seconds)
  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackbar(
      context,
      message: message,
      type: _SnackbarType.warning,
      duration: duration,
    );
  }

  /// Internal method that handles platform detection and snackbar display.
  static void _showSnackbar(
    BuildContext context, {
    required String message,
    required _SnackbarType type,
    required Duration duration,
  }) {
    // Remove any existing snackbars
    ScaffoldMessenger.of(context).clearSnackBars();

    if (Platform.isIOS) {
      _showIOSSnackbar(context, message, type, duration);
    } else {
      _showAndroidSnackbar(context, message, type, duration);
    }
  }

  /// Shows Material Design snackbar (Android style) with cyberpunk theme.
  static void _showAndroidSnackbar(
    BuildContext context,
    String message,
    _SnackbarType type,
    Duration duration,
  ) {
    final colors = _getColors(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(_getIcon(type), color: colors.iconColor, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: colors.textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: colors.backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colors.borderColor, width: 1.5),
        ),
        margin: const EdgeInsets.all(16),
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  /// Shows iOS-style snackbar with Cupertino design and cyberpunk theme.
  static void _showIOSSnackbar(
    BuildContext context,
    String message,
    _SnackbarType type,
    Duration duration,
  ) {
    final colors = _getColors(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(_getIcon(type), color: colors.iconColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: colors.textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.24,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: colors.backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: colors.borderColor.withValues(alpha:0.5),
            width: 1,
          ),
        ),
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  /// Returns appropriate icon for each message type based on platform.
  static IconData _getIcon(_SnackbarType type) {
    switch (type) {
      case _SnackbarType.success:
        return Icons.check_circle_rounded;
      case _SnackbarType.error:
        return Icons.error_rounded;
      case _SnackbarType.warning:
        return Icons.warning_rounded;
      case _SnackbarType.info:
        return Icons.info_rounded;
    }
  }

  /// Returns colors matching your app's cyberpunk theme for each message type.
  static _SnackbarColors _getColors(_SnackbarType type) {
    switch (type) {
      case _SnackbarType.success:
        return _SnackbarColors(
          backgroundColor: _darkGray,
          textColor: _textWhite,
          iconColor: _neonGreen,
          borderColor: _neonGreen,
        );
      case _SnackbarType.error:
        return _SnackbarColors(
          backgroundColor: _darkGray,
          textColor: _textWhite,
          iconColor: _errorRed,
          borderColor: _errorRed,
        );
      case _SnackbarType.warning:
        return _SnackbarColors(
          backgroundColor: _darkGray,
          textColor: _textWhite,
          iconColor: const Color(0xFFFFB020), // Amber
          borderColor: const Color(0xFFFFB020),
        );
      case _SnackbarType.info:
        return _SnackbarColors(
          backgroundColor: _darkGray,
          textColor: _textWhite,
          iconColor: const Color(0xFF00D9FF), // Cyan
          borderColor: const Color(0xFF00D9FF),
        );
    }
  }
}

/// Internal enum for snackbar types.
enum _SnackbarType { success, error, warning, info }

/// Internal class for organizing snackbar colors.
class _SnackbarColors {
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color borderColor;

  _SnackbarColors({
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.borderColor,
  });
}
