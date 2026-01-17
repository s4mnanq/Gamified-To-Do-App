import 'package:gamified_todo_app/core/errors/api_exception.dart';

class ApiErrorHandler {
  /// Extracts a user-friendly error message from the API exception.
  ///
  /// This method intelligently determines what error information to display:
  /// - If the exception contains `details` (validation errors, field-specific errors),
  ///   it formats and returns those details in a readable format
  /// - If no `details` exist, it returns the general `message` field
  ///
  /// **When to use:**
  /// - Displaying error messages to users in snackbars, dialogs, or toast notifications
  /// - When you need a single, formatted string to show what went wrong
  ///
  /// **Example:**
  /// ```dart
  /// try {
  ///   await authService.login(email, password);
  /// } catch (e) {
  ///   if (e is ApiException) {
  ///     String errorMsg = ApiErrorHandler.getErrorMessage(e);
  ///     ScaffoldMessenger.of(context).showSnackBar(
  ///       SnackBar(content: Text(errorMsg)),
  ///     );
  ///   }
  /// }
  /// ```
  ///
  /// **Returns:**
  /// - Formatted details string if `details` exists (e.g., "Email: Invalid format\nPassword: Too short")
  /// - General message string if no `details` (e.g., "Invalid email or password")
  static String getErrorMessage(ApiException exception) {
    // If details exist and contain meaningful information, prioritize it
    if (exception.details != null && exception.details!.isNotEmpty) {
      return _formatDetails(exception.details!);
    }

    // Otherwise return the message
    return exception.message;
  }

  /// Gets the raw error value for programmatic processing.
  ///
  /// This method returns the error data in its original form, allowing you to
  /// handle it programmatically based on its type:
  /// - Returns `Map<String, dynamic>` when detailed field-specific errors exist
  /// - Returns `String` when only a general message is available
  ///
  /// **When to use:**
  /// - When you need to handle different error fields separately
  /// - For form validation where you want to show errors under specific input fields
  /// - When you need to perform conditional logic based on which fields have errors
  /// - When integrating with form libraries that need field-specific error data
  ///
  /// **Example:**
  /// ```dart
  /// void handleRegistrationError(ApiException exception) {
  ///   dynamic errorValue = ApiErrorHandler.getErrorValue(exception);
  ///
  ///   if (errorValue is Map<String, dynamic>) {
  ///     // Handle field-specific validation errors
  ///     if (errorValue.containsKey('email')) {
  ///       emailController.setError(errorValue['email']);
  ///     }
  ///     if (errorValue.containsKey('password')) {
  ///       passwordController.setError(errorValue['password']);
  ///     }
  ///   } else if (errorValue is String) {
  ///     // Handle general error message
  ///     showSnackBar(errorValue);
  ///   }
  /// }
  /// ```
  ///
  /// **Returns:**
  /// - `Map<String, dynamic>` containing field names and their error messages
  /// - `String` containing the general error message
  static dynamic getErrorValue(ApiException exception) {
    if (exception.details != null && exception.details!.isNotEmpty) {
      return exception.details;
    }
    return exception.message;
  }

  /// Checks whether the exception contains detailed error information.
  ///
  /// Use this to determine if you should show a detailed error breakdown
  /// or just a simple message to the user.
  ///
  /// **When to use:**
  /// - Before deciding which type of error UI to show (detailed vs simple)
  /// - To conditionally render different error display components
  /// - When you need to log or track whether errors are detailed or general
  ///
  /// **Example:**
  /// ```dart
  /// void showErrorUI(ApiException exception) {
  ///   if (ApiErrorHandler.hasDetails(exception)) {
  ///     // Show detailed error dialog with list of issues
  ///     showDialog(
  ///       context: context,
  ///       builder: (_) => DetailedErrorDialog(details: exception.details!),
  ///     );
  ///   } else {
  ///     // Show simple snackbar with message
  ///     showSnackBar(exception.message);
  ///   }
  /// }
  /// ```
  ///
  /// **Returns:**
  /// - `true` if the exception has non-empty `details`
  /// - `false` if `details` is null or empty
  static bool hasDetails(ApiException exception) {
    return exception.details != null && exception.details!.isNotEmpty;
  }

  /// Retrieves a specific error detail by field name.
  ///
  /// This is useful when you want to extract the error for a specific form field
  /// without processing the entire details map.
  ///
  /// **When to use:**
  /// - Extracting error messages for individual form fields
  /// - When you only care about specific fields (e.g., just email or password)
  /// - Setting field-specific validation errors in your UI
  ///
  /// **Example:**
  /// ```dart
  /// void updateFormErrors(ApiException exception) {
  ///   String? emailError = ApiErrorHandler.getDetail(exception, 'email');
  ///   String? passwordError = ApiErrorHandler.getDetail(exception, 'password');
  ///
  ///   if (emailError != null) {
  ///     setState(() => _emailError = emailError);
  ///   }
  ///   if (passwordError != null) {
  ///     setState(() => _passwordError = passwordError);
  ///   }
  /// }
  /// ```
  ///
  /// **Parameters:**
  /// - `exception`: The API exception containing error information
  /// - `key`: The field name to look up (e.g., 'email', 'password', 'username')
  ///
  /// **Returns:**
  /// - The error message string for the specified field, or `null` if not found
  static String? getDetail(ApiException exception, String key) {
    return exception.details?[key]?.toString();
  }

  /// Formats a details map into a human-readable string.
  ///
  /// Converts field-specific errors into a clean, readable format:
  /// - Single error: Returns just the error value
  /// - Multiple errors: Returns formatted list with field names
  ///
  /// **Internal use only** - called by `getErrorMessage()`
  static String _formatDetails(Map<String, dynamic> details) {
    if (details.isEmpty) return '';

    // If there's only one detail, return its value
    if (details.length == 1) {
      return details.values.first.toString();
    }

    // Multiple details - format as bullet points
    return details.entries
        .map((e) => '${_formatKey(e.key)}: ${e.value}')
        .join('\n');
  }

  /// Converts technical field names to user-friendly labels.
  ///
  /// Transforms field names from camelCase or snake_case to Title Case:
  /// - `emailAddress` → `Email Address`
  /// - `user_name` → `User Name`
  /// - `passwordConfirm` → `Password Confirm`
  ///
  /// **Internal use only** - called by `_formatDetails()`
  static String _formatKey(String key) {
    // Convert camelCase or snake_case to Title Case
    return key
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .replaceAll('_', ' ')
        .trim()
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}
