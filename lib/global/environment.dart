

import 'dart:io';

class Environment {
  static String baseUrl = Platform.isAndroid ? '192.168.1.35:3000' : 'localhost:3000';
  static String socketUrl = Platform.isAndroid ? 'http://192.168.1.35:3000' : 'http://localhost:3000';
  static String apiUrl = '/api';
}