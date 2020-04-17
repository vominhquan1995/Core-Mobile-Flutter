import 'dart:io';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/detail_product/widget/button_custom.dart';
import 'package:Core/widgets/detail_product/widget/placeholder.dart';
import 'package:Core/widgets/search_results/widget/app_bar_custom_simple.dart';
import 'package:Core/widgets/shared/image-custom/image-custom.dart';
import 'package:Core/widgets/upgrade_account/bloc/upgrade_account_bloc.dart';
import 'package:Core/widgets/upgrade_account/bloc_address/address_bloc.dart';
import 'package:Core/widgets/upgrade_account/bloc_upload_image/upload_image_bloc.dart';
import 'package:Core/widgets/upgrade_account/bloc_upload_image/upload_image_event.dart';
import 'package:Core/widgets/upgrade_account/bloc_upload_image/upload_image_state.dart';
import 'package:Core/widgets/upgrade_account/model/address_model.dart';
import 'package:Core/widgets/upgrade_account/model/request_upgrade_model.dart';
import 'package:Core/widgets/upgrade_account/service/upgrade_service.dart';
import 'package:Core/widgets/upgrade_account/widgets/image_upload_custom.dart';
import 'package:Core/widgets/upgrade_account/widgets/modal_request_success.dart';
import 'package:Core/widgets/upgrade_account/widgets/select_address.dart';
import 'package:Core/widgets/upgrade_account/widgets/widget_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_picker/image_picker.dart';

@immutable
class FormCreateRequest extends StatefulWidget {
  UpgradeAccountBloc bloc;
  UploadImageBloc blocImage;
  AddressBloc blocAdd;
  FormCreateRequest({Key key, this.bloc, this.blocImage, this.blocAdd})
      : super(key: key);
  @override
  _FormCreateRequestState createState() => _FormCreateRequestState();
}

class _FormCreateRequestState extends State<FormCreateRequest> {
  UpgradeAccountService service;
  Province provinceSelected;
  District districtSelected;
  // Ward wardSelected;
  //define controler textinput
  String pathImage;
  TextEditingController txtCode = new TextEditingController();
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtSubAdd = new TextEditingController();
  TextEditingController txtMainAdd = new TextEditingController();
  //focus input
  FocusNode fTxtCode = FocusNode();
  FocusNode fTxtName = FocusNode();
  FocusNode fTxtSubAdd = FocusNode();
  final _form = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  bool sendingRequest;
  @override
  void initState() {
    super.initState();
    service = UpgradeAccountService(BlocProvider.of<ErrorhandleBloc>(context));
    setState(() {
      sendingRequest = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: new AppBarCustomSimple(title: tr('upgrade_salon_1')),
      body: Form(
        key: _form,
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(child: SizedBox(height: paddingL)),
                SliverToBoxAdapter(
                  child: Html(
                    defaultTextStyle: style15,
                    padding: EdgeInsets.symmetric(horizontal: paddingL),
                    data: tr('upgrade_salon_2'),
                  ),
                ),
                SliverToBoxAdapter(child: Divider()),
                SliverToBoxAdapter(child: SizedBox(height: paddingXS)),
                SliverToBoxAdapter(
                    child: RowForm(
                        title: tr('upgrade_salon_3'),
                        child: FormCustomQrScan(
                          txtCode: txtCode,
                          onSubmit: (key) {
                            _fieldFocusChange(context, fTxtName, fTxtName);
                          },
                        ))),
                SliverToBoxAdapter(child: SizedBox(height: paddingXS)),
                SliverToBoxAdapter(
                  child: RowForm(
                      title: tr('upgrade_salon_6'),
                      child: BlocBuilder(
                          bloc: widget.blocImage,
                          builder: (BuildContext context,
                              BlocUploadImageState state) {
                            if (state is InitialBlocUploadImageState) {
                              return BoxUploadImage(onTap: () {
                                pickImage();
                              });
                            }
                            if (state is ErrorBlocUploadImageState) {
                              return BoxUploadImage(
                                  onTap: () {
                                    pickImage();
                                  },
                                  isError: true);
                            }
                            if (state is SuccessUploadImageState) {
                              pathImage = state.image;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      pickImage();
                                    },
                                    child: Container(
                                      height: heightUploadImage,
                                      width: MediaQuery.of(context).size.width,
                                      child: HinhAnh(
                                        image: state.image,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: paddingL),
                                  Text(
                                    tr('upgrade_salon_30'),
                                    style: style15.copyWith(
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )
                                ],
                              );
                            }
                            return LinearProgressIndicator();
                          })),
                ),
                SliverToBoxAdapter(child: SizedBox(height: paddingXS)),
                SliverToBoxAdapter(
                  child: RowForm(
                    title: tr('upgrade_salon_9'),
                    child: TextFiledCustom(
                      txtCtr: txtName,
                      focus: fTxtName,
                      onSubmit: (key) {
                        _fieldFocusChange(context, fTxtName, fTxtSubAdd);
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: paddingXS)),
                SliverToBoxAdapter(
                    child: RowForm(
                  title: tr('upgrade_salon_10'),
                  child: TextFiledCustom(
                      txtCtr: txtSubAdd,
                      focus: fTxtSubAdd,
                      onSubmit: (key) {
                        _fieldFocusChange(context, fTxtName, null);
                      }),
                )),
                SliverToBoxAdapter(child: SizedBox(height: paddingXS)),
                SliverToBoxAdapter(
                    child: RowForm(
                  title: tr('upgrade_salon_11'),
                  child: ButtonSelectAddress(
                      onTap: () {
                        SelectAddress().onPick(context, widget.blocAdd,
                            (Province province, District district, Ward ward) {
                          provinceSelected = province;
                          districtSelected = district;
                          // wardSelected = ward;
                          txtMainAdd.text =
                              '${provinceSelected.fullName} - ${districtSelected.fullName}';
                        });
                      },
                      ctr: txtMainAdd),
                )),
                SliverToBoxAdapter(child: SizedBox(height: paddingXXS)),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: paddingXXS),
                  sliver: SliverToBoxAdapter(
                    child: buildActionBottom(),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: paddingXXS)),
                SliverToBoxAdapter(child: SizedBox(height: paddingXXS)),
                SliverToBoxAdapter(child: SizedBox(height: paddingXXS)),
              ],
            )),
      ),
      // bottomNavigationBar: buildActionBottom(),
    );
  }

  buildActionBottom() {
    if (!sendingRequest) {
      return ButtonCustomDetail(
        text: tr('upgrade_salon_13'),
        onClick: () {
          if (pathImage == null) {
            globalKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(tr('upgrade_salon_29')),
              duration: Duration(seconds: 1),
            ));
          } else if (!_form.currentState.validate()) {
            globalKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(tr('upgrade_salon_12')),
              duration: Duration(seconds: 1),
            ));
          } else {
            _sendRequest();
          }
        },
        bgImage: true,
      );
    } else {
      return Container(
        decoration:
            BoxDecoration(border: Border.all(color: colorGrey_3, width: 1)),
        child: PlaceholderBottomButton(),
      );
    }
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    if (nextFocus != null) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  _sendRequest() {
    try {
      RequestUpgrade model = RequestUpgrade(
          maGioiThieu: txtCode.text,
          tinhId: provinceSelected.id,
          tinhName: provinceSelected.fullName,
          quanId: districtSelected.id,
          quanName: districtSelected.fullName,
          // phuongId: wardSelected.id,
          // phuongName: wardSelected.fullName,
          phuongId: "",
          phuongName: "",
          tenShop: txtName.text,
          hinhAnh: pathImage,
          quocGiaId: "",
          diaChiShop: txtSubAdd.text,
          quocGiaName: "",
          tienTeId: "");
      // //loading
      setState(() {
        sendingRequest = true;
      });
      return service.insertRequest(model).then((result) {
        setState(() {
          sendingRequest = false;
        });
        showModalSuccess();
        //open popup
      }).catchError((onError) {
        setState(() {
          sendingRequest = false;
        });
        try {
          int code = int.parse(onError.response.data['code'].toString());
          if (code == 101) {
            globalKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(tr('upgrade_salon_31')),
              duration: Duration(seconds: 1),
            ));
            widget.bloc.add(CheckRequestAccount());
          } else if (code == 103) {
            //code valid
            globalKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(tr('upgrade_salon_4')),
              duration: Duration(seconds: 1),
            ));
          } else {
            globalKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(tr('upgrade_salon_32')),
              duration: Duration(seconds: 1),
            ));
          }
        } catch (e) {
          globalKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(tr('upgrade_salon_33')),
            duration: Duration(seconds: 1),
          ));
        }
      });
    } catch (e) {
      globalKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(tr('upgrade_salon_33')),
        duration: Duration(seconds: 1),
      ));
    }
  }

  showModalSuccess() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext _) {
          return ModalRequestSuccess();
        }).then((data) {
      widget.bloc.add(CheckRequestAccount());
    });
  }

  Future<Null> pickImage() async {
    File image;
    try {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      _handleError(e);
    }
    if (image != null) {
      widget.blocImage.add(UploadImage(file: image));
    }
  }

  _handleError(dynamic e) {
    if (e?.code.toString().contains('access_denied')) {
      globalKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(tr('upgrade_salon_44')),
        duration: Duration(seconds: 1),
      ));
    }
  }
}
