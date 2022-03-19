import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apimanager.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  File filename;
  File newFile;
  PlatformFile file;

  var _categoryName = "", _description = "";

  void onFileOpen() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );
    if (result != null) {
      file = result.files.first;
      filename = File(file.path);
      setState(() {
        newFile = filename;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  bool _isLoad = false;

  void _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      setState(() {
        _isLoad = true;
      });
      await Provider.of<ApiManager>(context, listen: false)
          .addCategoryApi(_categoryName, _description, filename);
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
            "Add Category",
            style: TextStyle(
                color: Colors.white,
                fontSize: 17 * MediaQuery.of(context).textScaleFactor,
                fontWeight: FontWeight.normal),
          ),
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
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(15),
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
                    topRight: Radius.circular(22),
                    topLeft: Radius.circular(22))),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Category Name",
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
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Color(0XFF262626)),
                    decoration: InputDecoration(
                      fillColor: Color(0XFFF2F2F2),
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Enter category",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter category name";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _categoryName = value;
                    },
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Category Description",
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
                    maxLines: 5,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Color(0XFF262626)),
                    decoration: InputDecoration(
                      fillColor: Color(0XFFF2F2F2),
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Enter description",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter description";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _description = value;
                    },
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upload Thumbnail",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
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
                          onPressed: () => onFileOpen(),
                          color: Color(0XFF2CB3BF),
                          child: Text(
                            "Upload",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                  if (_isLoad)
                    CircularProgressIndicator()
                  else
                    GestureDetector(
                      onTap: _trySubmit,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 40, bottom: 10, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: Center(
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                fontSize:
                                    21 * MediaQuery.of(context).textScaleFactor,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0XFF299FAB),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
