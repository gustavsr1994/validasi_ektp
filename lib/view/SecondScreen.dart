import 'package:app_validasi_ektp/assets/style.dart';
import 'package:app_validasi_ektp/model/biodata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
  SecondScreen();
}

class _SecondScreenState extends State<SecondScreen> {
  BiodataController biodataController = Get.find();
  String statusEKtp = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String message = _checkValidateNIK(biodataController);
    statusEKtp = message;
    Fluttertoast.showToast(
        msg: message,
        fontSize: 17,
        textColor: colorBlueDark,
        backgroundColor: colorAccent,
        toastLength: Toast.LENGTH_LONG);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'My Biodata',
          style: fontTitle,
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 4 - 20,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Status E KTP : ' + statusEKtp,
                  style: fontEditText,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: colorBlueSky, style: BorderStyle.solid, width: 2),
                borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil().setWidth(50))),
              ),
              child: Container(
                padding: EdgeInsets.all(ScreenUtil().setHeight(15)),
                margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      title: Text('Name'),
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setHeight(15)),
                          child: Text(
                            biodataController.name,
                            style: fontEditText,
                          ),
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text('NIK'),
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setHeight(15)),
                          child: Text(
                            biodataController.nik,
                            style: fontEditText,
                          ),
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Birth Date'),
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setHeight(15)),
                          child: Text(
                            DateFormat('dd-MMM-yyyy')
                                .format(biodataController.birthDate),
                            style: fontEditText,
                          ),
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Sex'),
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setHeight(15)),
                          child: Text(
                            biodataController.sex,
                            style: fontEditText,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _checkValidateNIK(BiodataController data) {
    String nik = data.nik.toString();
    String birthDate = DateFormat('yyyy-MM-dd').format(data.birthDate);
    List<String> resultBirtDate = birthDate.split('-');
    String sex = data.sex;
    int len = nik.length;
    if (len != 16) {
      return "eKTP invalid.";
    } else {
      String date = nik.substring(6, 8);
      int dates = int.parse(date);
      String month = nik.substring(8, 10);
      String year = nik.substring(10, 12);
      if (dates > 40) {
        if ((dates-40) == int.parse(resultBirtDate[2]) &&
            month == resultBirtDate[1] &&
            year == resultBirtDate[0].substring(2,4)) {
          if (sex == "Wanita") {
            return "eKTP Valid";
          }
        } else {
          return "eKTP invalid.";
        }
      } else {
        if (date == resultBirtDate[2] &&
            month == resultBirtDate[1] &&
            year == resultBirtDate[0].substring(2, 4)) {
          if (sex == "Pria") {
            return "eKTP Valid";
          }
        } else {
          return "eKTP invalid.";
        }
      }
    }
  }
}
