import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/page-core/widget_custom.dart';
import 'package:Midas/utils/theme.dart';
import 'package:Midas/widgets/lich_su_rut_diem/lich_su_rut_diem_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateSucces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 5 / 3,
                    child: Image.asset(
                      'assets/images/success.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        paddingL, paddingXS, paddingL, paddingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          tr('withdrawal_13'),
                          textAlign: TextAlign.center,
                          style: style20_semibold.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: paddingL),
                        Text(
                          tr('withdrawal_14'),
                          style: style15,
                        ),
                        SizedBox(height: paddingL),
                        Text(
                          tr('withdrawal_15'),
                          style: style15,
                        ),
                        SizedBox(height: paddingXS),
                        OutlineButton(
                            child: new Center(
                              child: Text(
                                tr('withdrawal_16'),
                                style: style17_semibold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (_) =>
                                    WidgetsCore(widget: LichSuRutDiemList()),
                              ));
                            },
                            borderSide:
                                BorderSide(color: colorPurple, width: 2),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5))),
                        SizedBox(height: paddingL),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
