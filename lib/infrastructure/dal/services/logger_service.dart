import 'dart:developer';

class LoggerService {
  static void logInfo(String message) {
    log('[INFO]: $message');
  }

  static void logError(String message, dynamic error) {
    log('[ERROR]: $message \nError: $error');
  }
}
