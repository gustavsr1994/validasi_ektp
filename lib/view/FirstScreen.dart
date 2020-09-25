import 'dart:io';

import 'package:app_validasi_ektp/assets/style.dart';
import 'package:app_validasi_ektp/model/biodata.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _imageFile;
  List _listGender = ["Pria", "Wanita"]; //Array gender
  String _valGender;
  FocusNode _nikFocus = new FocusNode();
  FocusNode _nameFocus = new FocusNode();
  FocusNode _birthDateFocus = new FocusNode();
  FocusNode _sexFocus = new FocusNode();
  TextEditingController _nikController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();

  final controller = Get.put(BiodataController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: colorBlueDark,
          title: Text(
            'Input Biodata',
            style: fontTitle,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.arrow_forward),
        backgroundColor: colorBlueDark,
        hoverColor: colorBlueSky,
        label: Text('Validasi Data', style: fontButton),
        onPressed: () {
          _checkValidate(_formKey, controller);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(ScreenUtil().setHeight(5)),
                child: Center(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(ScreenUtil().setHeight(5)),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                focusNode: _nikFocus,
                                controller: _nikController,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  return _checkNIK(value);
                                },
                                onFieldSubmitted: (value) {
                                  controller.nik = value;
                                  _fieldFocusChange(
                                      context, _nikFocus, _nameFocus);
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    labelText: 'NIK *',
                                    hintStyle: fontEditText,
                                    errorStyle: fontError),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(ScreenUtil().setHeight(5)),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                focusNode: _nameFocus,
                                controller: _nameController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (_checkNull(value)) {
                                    return textBlankField;
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  controller.name = value;
                                  _fieldFocusChange(
                                      context, _nameFocus, _birthDateFocus);
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    labelText: 'Name *',
                                    hintStyle: fontEditText,
                                    errorStyle: fontError),
                              ),
                            ),
                            Container(
                                margin:
                                    EdgeInsets.all(ScreenUtil().setWidth(5)),
                                child: DateTimeField(
                                  validator: (value) {
                                    if (_checkNull(value)) {
                                      return textBlankField;
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(17)),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      labelText: 'Birth Date *',
                                      hintStyle: fontEditText,
                                      errorStyle: fontError),
                                  format: DateFormat('dd - MMM - yyyy'),
                                  textInputAction: TextInputAction.next,
                                  focusNode: _birthDateFocus,
                                  onFieldSubmitted: (term) {
                                    // _checkValidate(_formKey, controller);
                                    _fieldFocusChange(
                                        context, _birthDateFocus, _sexFocus);
                                  },
                                  onChanged: (value) {
                                    controller.birthDate = value;
                                  },
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1980),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate:
                                          DateTime(DateTime.now().year + 1),
                                      builder:
                                          (BuildContext context, Widget child) {
                                        return Theme(
                                          data: ThemeData.light(),
                                          child: child,
                                        );
                                      },
                                    );
                                  },
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(7),
                                  ScreenUtil().setWidth(7),
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setWidth(5)),
                              child: Text("Jenis Kelamin", style: fontEditText),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(10),
                                  ScreenUtil().setWidth(5),
                                  ScreenUtil().setWidth(5),
                                  ScreenUtil().setWidth(5)),
                              child: DropdownButton(
                                hint: Text("Pilih Jenis Kelamin",
                                    style: fontEditText),
                                style: fontEditText,
                                value: _valGender,
                                focusNode: _sexFocus,
                                items: _listGender.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    controller.sex = value;
                                    _valGender = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ))))
          ],
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String _checkNIK(String nik) {
    if (_checkNull(nik)) {
      return textBlankField;
    } else {
      int len = nik.toString().length;
      if (len != 16) {
        return "eKTP invalid.";
      } else {
        controller.nik = nik;
      }
    }
  }

  bool _checkNull(var value) {
    if (value == null || value == "") {
      return true;
    } else {
      return false;
    }
  }

  _checkValidate(GlobalKey<FormState> _formKey, BiodataController controller) {
    // BiodataController ctrl = Get.find();
    if (_formKey.currentState.validate() || _valGender != null) {
      controller.name = _nameController.text;
      print('Success Insert');
    } else {
      Fluttertoast.showToast(
          msg: "Please, choice your sex",
          fontSize: 17,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
          textColor: colorBlueSky,
          backgroundColor: colorError);
      print('Failed Insert');
    }
  }
}
