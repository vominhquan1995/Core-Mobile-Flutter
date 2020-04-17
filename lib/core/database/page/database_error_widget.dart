import 'package:flutter/material.dart';

class DBHelperError extends StatelessWidget {
  final e;
  DBHelperError({this.e});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('DB Error ${e.toString() ?? ''}'),
      ),
    );
  }
}
