import 'package:Midas/core/translate/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_review/launch_review.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/utils/variables.dart';
import './bloc/index.dart';

class UpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<VersionBloc>(context).state;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('core_18')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              (state as SoftUpdate)?.message ?? "",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          RaisedButton(
            onPressed: update,
            child: Text(tr('core_19')),
            textColor: Colors.white,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  void update() {
    LaunchReview.launch(
        androidAppId: Variables.androidAppId,
        iOSAppId: Variables.iOSAppId,
        writeReview: false);
  }

  static void showUpdateDialog(BuildContext context, VersionBloc bloc) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(tr('core_18')),
          content: new Text((bloc.state as SoftUpdate)?.message ?? ""),
          actions: <Widget>[
            new FlatButton(
              child: new Text(tr('core_20')),
              onPressed: () {
                bloc.add(TellMeLater());
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(tr('core_19')),
              onPressed: () {
                LaunchReview.launch(
                    androidAppId: Variables.androidAppId,
                    iOSAppId: Variables.iOSAppId,
                    writeReview: false);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((onValue) {
      bloc.add(TellMeLater());
    });
  }
}
