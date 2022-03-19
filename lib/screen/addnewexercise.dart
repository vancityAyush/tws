import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchUnits.dart';
import 'package:tws/apiService/apimanager.dart';

class AddNewExerCise extends StatefulWidget {
  @override
  _AddNewExerCiseState createState() => _AddNewExerCiseState();
}

class _AddNewExerCiseState extends State<AddNewExerCise> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController youlinkController = TextEditingController();
  String selectType;
  bool tagVideo = false, tagYoutube = false;
  List<String> items = ['Video', 'Youtube Link'];

  String _mySelection;
  List<DataVideo> data = [];

  Future<String> getSWData() async {
    var future =
        await Provider.of<ApiManager>(context, listen: false).fetchUnitApi();
    setState(() {
      data = future.data;
    });
  }

  File filename;
  File newFile;
  PlatformFile file;

  void onFileOpen() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );
    if (result != null) {
      file = result.files.first;
      filename = File(file.path);
      // Provider.of<ApiManager>(context,listen: false).newSendMessageApi("msgBy", widget.sendToId, _enteredMessage,filename);
      setState(() {
        newFile = filename;
      });
    }
  }

  String dropdownValue = 'Only reps';

  bool _isLoad = false;

  void _trySubmitYoutube() async {
    setState(() {
      _isLoad = true;
    });
    await Provider.of<ApiManager>(context, listen: false).addNewExerciseYoutube(
        nameController.text,
        descriptionController.text,
        youlinkController.text,
        _mySelection);
    setState(() {
      _isLoad = false;
    });
  }

  void _trySubmit() async {
    setState(() {
      _isLoad = true;
    });
    await Provider.of<ApiManager>(context, listen: false).addNewExercise(
        filename,
        nameController.text,
        descriptionController.text,
        _mySelection);
    setState(() {
      _isLoad = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  var selectedValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0XFF2CB3BF),
        title: Text(
          "Add New Exercise",
          style: TextStyle(color: Colors.white),
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
        child: Column(
          children: [
            Image.asset(
              "assets/images/spalsh.jpg",
              width: MediaQuery.of(context).size.width,
              height: 210,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
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
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Exercise Name",
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
                    controller: nameController,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Color(0XFF262626)),
                    decoration: InputDecoration(
                      fillColor: Color(0XFFF2F2F2),
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Exercise name",
                    ),
                    onSaved: (String value) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 10),
                    child: Container(
                      color: Color(0XFFF2F2F2),
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: new DropdownButton(
                        isExpanded: true,
                        hint: Text("Select Video Type"),
                        items: items.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item),
                            value: item.toString(),
                          );
                        }).toList(),
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: (newVal) {
                          setState(() {
                            selectType = newVal;
                            if (selectType == "Video") {
                              tagVideo = true;
                              tagYoutube = false;
                            } else {
                              tagVideo = false;
                              tagYoutube = true;
                            }
                          });
                        },
                        value: selectType,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: tagVideo,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Exercise Videos",
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
                            Image.asset(
                              "assets/images/spalsh.jpg",
                              fit: BoxFit.cover,
                              width: 170,
                              height: 90,
                            ),

                            SizedBox(
                              width: 35,
                            ),

                            GestureDetector(
                              onTap: onFileOpen,
                              child: Text(
                                "Choose",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ),
                            // Icon(Icons.delete,size: 31,color: Colors.red,)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: tagYoutube,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Youtube Link",
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
                          controller: youlinkController,
                          autovalidateMode: AutovalidateMode.always,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                              fillColor: Color(0XFFF2F2F2),
                              filled: true,
                              border: InputBorder.none,
                              hintText: "Enter youtube link"),
                          onSaved: (String value) {},
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
                      "Description",
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
                    controller: descriptionController,
                    minLines: 1,
                    maxLines: 4,
                    autovalidateMode: AutovalidateMode.always,
                    style: TextStyle(color: Color(0XFF262626)),
                    decoration: InputDecoration(
                      fillColor: Color(0XFFF2F2F2),
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Add video description",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
                      "Select Unit",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, top: 12, bottom: 10),
                    child: Container(
                      color: Color(0XFFF2F2F2),
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: new DropdownButton(
                        isExpanded: true,
                        hint: Text("Select Unit"),
                        items: data.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item.name),
                            value: item.id.toString(),
                          );
                        }).toList(),
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: (newVal) {
                          setState(() {
                            _mySelection = newVal;
                          });
                        },
                        value: _mySelection,
                      ),
                      /*child: DropdownButton(
                        isExpanded: true,
                        items: data.map((item) {
                          return new DropdownMenuItem(child: Text(item.name),
                          value: item.id,);
                        }),
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
                          });
                        },
                        */ /*value: dropdownValue,
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
                          });
                        },
                        items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),*/ /*
                      ),*/
                    ),
                  ),
                  if (_isLoad)
                    CircularProgressIndicator()
                  else
                    GestureDetector(
                      onTap: () {
                        if (selectType == "Video") {
                          _trySubmit();
                        } else {
                          _trySubmitYoutube();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.only(
                            left: 22, right: 22, top: 9, bottom: 9),
                        decoration: BoxDecoration(
                            color: Color(0XFF2CB3BF),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                            fontSize:
                                18 * MediaQuery.of(context).textScaleFactor,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFFFFFFFF),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
