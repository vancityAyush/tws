import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apimanager.dart';
import 'package:tws/fragment/feedlist.dart';

class Feeds extends StatefulWidget {
  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  TextEditingController headingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController youtubeLinkController = TextEditingController();

  File filename;
  File newFile;
  PlatformFile file;

  void onFileOpen() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result != null) {
      file = result.files.first;
      filename = File(file.path);
      setState(() {
        newFile = filename;
      });
    }
  }

  bool statusImage = false;
  bool statusLink = false;
  String dropdownValue = 'Select Type';

  List<String> spinnerItems = ['Select Type', 'Image', 'Embedded Video'];

  var selectedValue = "";
  bool _isLoad = false;

  void _trySubmit() async {
    if (dropdownValue == "Select Type") {
      Fluttertoast.showToast(msg: "Select Type", gravity: ToastGravity.BOTTOM);
    } else if (headingController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter heading", gravity: ToastGravity.BOTTOM);
    } /*else if(descriptionController.text.isEmpty){
      Fluttertoast.showToast(msg: "Enter description",
          gravity: ToastGravity.BOTTOM);
    }*/
    else {
      setState(() {
        _isLoad = true;
      });
      await Provider.of<ApiManager>(context, listen: false).addFeedsApi(
          headingController.text,
          descriptionController.text,
          filename,
          youtubeLinkController.text,
          dropdownValue);
      setState(() {
        _isLoad = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0XFF2CB3BF),
        title: Text(
          "Feeds",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FeedList()));
                },
                child: Icon(
                  Icons.double_arrow,
                  size: 33,
                )),
          )
        ],
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                color: Color(0XFFF2F2F2),
                padding: EdgeInsets.only(left: 8, right: 8),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  onChanged: (String data) {
                    setState(() {
                      dropdownValue = data;
                      if (dropdownValue == "Image") {
                        statusLink = false;
                        statusImage = true;
                      } else {
                        statusLink = true;
                        statusImage = false;
                      }
                    });
                  },
                  items: spinnerItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: statusImage,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: file == null
                          ? Image.asset(
                              "assets/images/spalsh.jpg",
                              fit: BoxFit.cover,
                              width: 80,
                              height: 110,
                            )
                          : Image.file(
                              filename,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 110,
                            ),
                    )),
                    SizedBox(
                      width: 35,
                    ),
                    RaisedButton(
                        onPressed: onFileOpen,
                        color: Color(0XFF2CB3BF),
                        child: Text(
                          "Choose File",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
              Visibility(
                visible: statusLink,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "youtube Link",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 4,
                      controller: youtubeLinkController,
                      autovalidateMode: AutovalidateMode.always,
                      style: TextStyle(color: Color(0XFF262626)),
                      decoration: InputDecoration(
                        fillColor: Color(0XFFF2F2F2),
                        filled: true,
                        border: InputBorder.none,
                        hintText: "",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      ),
                      // decoration: const InputDecoration(
                      //   hintText: 'Bio',
                      //   labelText: 'Bio',
                      // ),
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Heading",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: headingController,
                autovalidateMode: AutovalidateMode.always,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Color(0XFF262626)),
                decoration: InputDecoration(
                  fillColor: Color(0XFFF2F2F2),
                  filled: true,
                  border: InputBorder.none,
                  hintText: "",
                ),
                // decoration: const InputDecoration(
                //   hintText: 'Bio',
                //   labelText: 'Bio',
                //
                // ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                keyboardType: TextInputType.text,
                controller: descriptionController,
                style: TextStyle(color: Color(0XFF262626)),
                decoration: InputDecoration(
                  fillColor: Color(0XFFF2F2F2),
                  filled: true,
                  border: InputBorder.none,
                  hintText: "",
                ),
                // decoration: const InputDecoration(
                //   hintText: 'Bio',
                //   labelText: 'Bio',
                //
                // ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              SizedBox(
                height: 15,
              ),
              if (_isLoad)
                CircularProgressIndicator()
              else
                GestureDetector(
                  onTap: _trySubmit,
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.only(
                        left: 22, right: 22, top: 12, bottom: 12),
                    decoration: BoxDecoration(
                        color: Color(0XFF2CB3BF),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                        fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFFFFFFFF),
                      ),
                    ),
                  ),
                )
            ],
          ),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(22), topLeft: Radius.circular(22))),
        ),
      ),
    );
  }
}
