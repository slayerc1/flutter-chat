// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:chat/global/environment.dart';

enum ServerStatus { online, offline, connecting }

class SocketService extends ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late io.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  io.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() async {

    final token = await AuthService.getToken();

    // Dart client
    _socket = io.io(Environment.socketUrl, {
      'transports' : ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': token
      }
    });

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

  }

  void disconnect() {
    _socket.disconnect();
  }
}
