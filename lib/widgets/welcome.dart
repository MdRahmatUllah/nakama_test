import 'package:flutter/material.dart';
import 'package:nakama/api.dart';

import '../data_page.dart';

class Welcome extends StatelessWidget {
  final Account account;

  const Welcome(this.account, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, TextPage.routeName);
            },
            child: Text('Check for Test'),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Welcome ${account.user.username}!'),
            ),
          ),
        ],
      ),
    );
  }
}
