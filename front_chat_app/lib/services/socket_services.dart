import 'package:chatapp/global/environment.dart';
import 'package:chatapp/services/auth_services.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  OnLine,
  OffLine,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  // SocketService() {
  //   _initConfig();
  // }

  void connect() async {
    final token = await AuthService.getToken();

    // Dart client
    _socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': token,
      }
    });

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.OnLine;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.OffLine;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
