import 'package:flutter/material.dart';
import 'package:nakama/nakama.dart';
import 'package:nakama/api.dart' as api;

/*
 * This is the main class of Nakama.
 * It is responsible for initializing the Nakama SDK and
 * for creating the main application.
 * Account
 * Seassion
 * Socket
 * Dispose
 * Disconnect method
 * connectasync
 * restoreAsync
 * 
 */

class NakamaSessionManager {
  NakamaSessionManager._internal();
  static final NakamaSessionManager _instance =
      NakamaSessionManager._internal();
  static NakamaSessionManager get instance => _instance;

  NakamaBaseClient? _client;

  NakamaBaseClient? get client {
    _client ??= getNakamaClient(
      host: '192.168.0.108',
      httpPort: 7350,
      ssl: false,
      serverKey: 'defaultkey',
    );
    return _client;
  }

  Session? _session;

  Session? get session {
    return _session;
  }

  set session(Session? session) {
    _session = session;
  }

  api.Account? _account;

  api.Account? get account {
    return _account;
  }

  set account(api.Account? account) {
    _account = account;
  }

  NakamaWebsocketClient? _socket;

  NakamaWebsocketClient? get socket {
    _socket ??= NakamaWebsocketClient.init(
      host: '192.168.0.108',
      ssl: false,
      token: _session!.token,
    );
  }

  Future<bool> authenticateEmailPassword(
      {required String email,
      required String password,
      bool create = false}) async {
    try {
      session = await client?.authenticateEmail(
        email: email,
        password: password,
        create: create,
      );
      return true;
    } catch (e) {
      print('Error signing in: $e');
      return false;
    }
  }
}
