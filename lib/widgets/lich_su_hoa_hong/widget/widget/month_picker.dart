import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/lich_su_hoa_hong/bloc/month_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MonthPickerHor extends StatefulWidget {
  final ValueChanged<dynamic> onChange;

  const MonthPickerHor({Key key, this.onChange}) : super(key: key);

  @override
  _MonthPickerHorState createState() => _MonthPickerHorState();
}

class _MonthPickerHorState extends State<MonthPickerHor> {
  MonthPickerBloc bloc;
  var format = '';
  var date;
  /**
   * Để lấy tháng cần hiển thị(Mặc định là 1 => Tháng trước)
   */
  var curentMonth;
  DateTime prevMonth;
  dynamic getTime;

  //Click chọn tháng trước
  var LOAI_TRUOC = '-1';
  //Click chọn tháng sau
  var LOAI_SAU = '1';

  @override
  void initState() {
    super.initState();
    bloc = MonthPickerBloc();
    bloc.add(ChangePickerEvent());

    date = new DateTime.now();
    curentMonth = 1;
    prevMonth = new DateTime(date.year, date.month - curentMonth);
  }

  @override
  void dispose() {
    super.dispose();
  }

  thangTruoc() {
    bloc.add(ChangePickerEvent(loai: LOAI_TRUOC, curentMonth: curentMonth));
  }

  thangSau() {
    bloc.add(ChangePickerEvent(loai: LOAI_SAU, curentMonth: curentMonth));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MonthPickerBloc, MonthPickerState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is GetedMonthPickerState) {
            curentMonth = state.curentMonth;
            getTime = state.dateTime;
            widget.onChange(getTime);
          }
        },
        child: BlocBuilder<MonthPickerBloc, MonthPickerState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is GetedMonthPickerState) {
              return Container(
                margin: EdgeInsets.only(left: paddingL, right: paddingL),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: borderSide,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        thangTruoc();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: paddingM,
                            bottom: paddingM,
                            left: paddingL,
                            right: paddingL),
                        child: Icon(Icons.chevron_left,
                            size: 30, color: colorBlack),
                      ),
                    ),
                    Container(
                      child: Text(
                        tr('commission_11') + ' ${state.thang} - ${state.nam}',
                        style: style15,
                      ),
                    ),
                    Opacity(
                      opacity: curentMonth == 1 ? 0 : 1,
                      child: InkWell(
                        onTap: () {
                          curentMonth == 1 ? null : thangSau();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: paddingM,
                              bottom: paddingM,
                              left: paddingL,
                              right: paddingL),
                          child: Icon(
                            Icons.chevron_right,
                            size: 30,
                            color: colorBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Container(
              margin: EdgeInsets.only(left: paddingL, right: paddingL),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: borderSide,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      thangTruoc();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: paddingM,
                          bottom: paddingM,
                          left: paddingL,
                          right: paddingL),
                      child:
                          Icon(Icons.chevron_left, size: 30, color: colorBlack),
                    ),
                  ),
                  Container(
                    child: Text(
                      tr('commission_11') +
                          ' ${prevMonth.month} - ${prevMonth.year}',
                      style: style15,
                    ),
                  ),
                  Opacity(
                    opacity: curentMonth == 1 ? 0 : 1,
                    child: InkWell(
                      onTap: () {
                        curentMonth == 1 ? null : thangSau();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: paddingM,
                            bottom: paddingM,
                            left: paddingL,
                            right: paddingL),
                        child: Icon(
                          Icons.chevron_right,
                          size: 30,
                          color: colorBlack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
