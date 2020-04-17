import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Core/utils/index.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginFailureWidget extends StatelessWidget {
  final double height;
  final String message;
  final String linkRedirect;
  final String linkRedirectName;
  LoginFailureWidget(
      {this.height = 56,
      this.message,
      this.linkRedirect,
      this.linkRedirectName})
      : assert(message != null, 'message not null');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 90.0,
          maxHeight: 200,
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 241, 210, 1),
              border: Border(
                left: BorderSide(
                  color: Color.fromRGBO(253, 184, 30, 1),
                  width: 5,
                ),
              ),
            ),
            padding: EdgeInsets.all(paddingL),
            child: RichText(
              text: TextSpan(
                  text: message,
                  style: style13.copyWith(
                      color: Colors.black, height: 1.2, wordSpacing: 1.2),
                  children: [
                    TextSpan(
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => _launchURL(),
                        text:
                            ' ${linkRedirectName != null ? linkRedirectName : ''}',
                        style: style13.copyWith(
                            color: Color.fromRGBO(0, 98, 205, 1),
                            fontWeight: FontWeight.bold)),
                  ]),
            )),
      ),
    );
  }

  _launchURL() async {
    if (await canLaunch(linkRedirect)) {
      await launch(linkRedirect);
    } else {
      throw 'Could not launch $linkRedirect';
    }
  }
}
