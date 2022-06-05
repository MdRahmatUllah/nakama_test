import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nakama/nakama.dart';
import 'package:nakama/api.dart' as api;
import 'package:nakama/rtapi.dart' as rt;
import 'widgets/match_area.dart';
import 'widgets/matchmaker.dart';
import 'widgets/sign_in_box.dart';
import 'widgets/welcome.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  __HomeScreenState createState() => __HomeScreenState();
}

class __HomeScreenState extends State<HomeScreen> {
  late final NakamaBaseClient _nakamaClient;

  Session? _session;
  api.Account? _account;
  rt.Match? _match;

  void _getHTTPClient() async {
    var response = await http.post(
        Uri.parse(
            'http://192.168.68.3:7350/v2/account/authenticate/email?username=kibria_22'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Basic ZGVmYXVsdGtleTo='
        },
        body:
            jsonEncode({'email': 'maruf22@gmail.com', "password": "maruf222"}));
    print('Response code: ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // _getHTTPClient();
    _nakamaClient = getNakamaClient(
      host: '192.168.68.3',
      httpPort: 7350,
      ssl: false,
      serverKey: 'defaultkey',
    );
  }

  @override
  void dispose() {
    NakamaWebsocketClient.instance.close();
    super.dispose();
  }

  void _signIn(String email, String password) async {
    if (kDebugMode) {
      print('Signing in with email $email');
    }
    late Session res;
    try {
      res = await _nakamaClient.authenticateEmail(
        email: email,
        password: password,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in: $e');
      }
    }

    if (kDebugMode) {
      print('Res: ' + res.toString());
    }
    // sign in was successful
    setState(() => _session = res);

    // get user's profile
    final ac = await _nakamaClient.getAccount(res);
    setState(() => _account = ac as api.Account?);
    if (kDebugMode) {
      print('account: $ac');
    }
    final r = NakamaWebsocketClient.init(
      host: '192.168.68.3',
      ssl: false,
      token: _session!.token,
    );
    if (kDebugMode) {
      print('websocket client: $r');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nakama Flutter Demo')),
      // body: Text('Hello World')
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _session != null && _account != null
            ? Column(
                children: [
                  Welcome(_account!),
                  if (_match == null)
                    Matchmaker(
                      onMatch: (m) => setState(() => _match = m),
                    ),
                  if (_match != null) MatchArea(_match!),
                ],
              )
            : SignInBox(onSignIn: _signIn),
      ),
    );
  }
}
