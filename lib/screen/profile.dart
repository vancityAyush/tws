import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchMembers.dart';
import 'package:tws/apiService/apiResponse/ResponseProfile.dart';
import 'package:tws/apiService/apimanager.dart';

import '../switchbutton.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> names = <String>[];
  final List<String> addMemberDesignation = <String>[];
  final List<String> addMemberExperience = <String>[];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];

  TextEditingController bioController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactDetailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController adhaarCardController = TextEditingController();

  Data data = new Data();

  TextEditingController nameController = TextEditingController();
  TextEditingController memberExperience = TextEditingController();
  TextEditingController memberDesignation = TextEditingController();
  bool _isLoad = false;
  void _addItemToList() {
    setState(() {
      names.insert(0, nameController.text);
      addMemberDesignation.insert(0, memberDesignation.text);
      addMemberExperience.insert(0, memberExperience.text);
      // print(names.toString());
      msgCount.insert(0, 0);
      nameController.clear();
      memberDesignation.clear();
      memberExperience.clear();
    });
  }

  File filename;
  File newFile;
  PlatformFile file;
  bool _isLoads = false;

  void onFileOpen() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      file = result.files.first;
      filename = File(file.path);
      setState(() {
        newFile = filename;
      });
    }
  }

  void _trySubmit() async {
    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter member name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (memberExperience.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter experience",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (memberDesignation.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter designation",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        _isLoad = true;
      });
      await Provider.of<ApiManager>(context, listen: false).addMemberApi(
          nameController.text, memberExperience.text, memberDesignation.text);
      setState(() {
        _isLoad = false;
      });
    }
  }

  void _deleteMemberApi(String id) async {
    setState(() {
      _isLoadsd = true;
    });
    await Provider.of<ApiManager>(context, listen: false).removeMemberApi(id);
    setState(() {
      _isLoadsd = false;
    });
  }

  bool _isLoadsd = false;
  String tag;
  bool isShopOpen = false;

  void _toggleShopHour() async {
    if (isShopOpen) {
      tag = "PUBLIC";
    } else {
      print("NO");
      tag = "PRIVATE";
    }

    setState(() {
      isShopOpen = !isShopOpen;
      Provider.of<ApiManager>(context, listen: false).privacyStatusApi(tag);
    });
  }

  void _editProfileApi() async {
    setState(() {
      _isLoads = true;
    });
    if (filename == null) {
      await Provider.of<ApiManager>(context, listen: false).editProfileApiImage(
          filename,
          bioController.text,
          addressController.text,
          adhaarCardController.text);
    } else {
      await Provider.of<ApiManager>(context, listen: false).editProfileApi(
          filename,
          bioController.text,
          addressController.text,
          adhaarCardController.text);
    }
    setState(() {
      _isLoads = false;
    });
  }

  void removeItem() {
    setState(() {
      for (int i = 0; i < names.length; i++) {
        names.removeAt(i);
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var _future =
          Provider.of<ApiManager>(context, listen: false).fetchProfileApi();
      _future.then((value) {
        setState(() {
          data = value.data;
          bioController.text = data.bio;
          emailController.text = data.email;
          addressController.text = data.address;
          contactDetailController.text = data.phone;
          adhaarCardController.text = data.aadhaarCard;
          if (data.privacyStatus == "PRIVATE") {
            isShopOpen = true;
          } else {
            isShopOpen = false;
          }
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0XFF2CB3BF),
        title: Text(
          "Edit profile",
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
        actions: [
          InkWell(
              onTap: () {
                _toggleShopHour();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SwitchActiveInactive(switched: isShopOpen),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/spalsh.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 7,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          onFileOpen();
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: file == null
                              ? data.image == null
                                  ? AssetImage("assets/images/spalsh.jpg")
                                  : NetworkImage(
                                      "http://fitnessapp.frantic.in/" +
                                          data.image)
                              : FileImage(filename),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: data.name == null
                          ? Text("")
                          : Text(
                              data.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            )),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Bio",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: bioController,
                      minLines: 1,
                      maxLines: 4,
                      autovalidateMode: AutovalidateMode.always,
                      style: TextStyle(color: Color(0XFF262626)),
                      decoration: InputDecoration(
                        fillColor: Color(0XFFF2F2F2),
                        filled: true,
                        border: InputBorder.none,
                        hintText: "Bio",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      ),
                      onSaved: (String value) {},
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.always,
                      style: TextStyle(color: Color(0XFF262626)),
                      decoration: InputDecoration(
                        fillColor: Color(0XFFF2F2F2),
                        filled: true,
                        border: InputBorder.none,
                        hintText: "email id",
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
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Contact Details",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: contactDetailController,
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Color(0XFF262626)),
                      decoration: InputDecoration(
                        fillColor: Color(0XFFF2F2F2),
                        filled: true,
                        border: InputBorder.none,
                        hintText: "Phone number",
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
                  ),

                  /* Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Text("Year of experience",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Color(0XFF262626)),
                      decoration: InputDecoration(fillColor: Color(0XFFF2F2F2), filled: true,
                        border: InputBorder.none,
                        hintText: "year of experience",
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
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Text("weight",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Color(0XFF262626)),
                      decoration: InputDecoration(fillColor: Color(0XFFF2F2F2), filled: true,
                        border: InputBorder.none,
                        hintText: "weight",
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
                  ),*/

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Address",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: addressController,
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Color(0XFF262626)),
                      decoration: InputDecoration(
                        fillColor: Color(0XFFF2F2F2),
                        filled: true,
                        border: InputBorder.none,
                        hintText: "address",
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
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Aadhaar Card Number",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: adhaarCardController,
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Color(0XFF262626)),
                      decoration: InputDecoration(
                        fillColor: Color(0XFFF2F2F2),
                        filled: true,
                        border: InputBorder.none,
                        hintText: "Aadhaar card number",
                      ),
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Add Member",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: TextFormField(
                            controller: nameController,
                            autovalidateMode: AutovalidateMode.always,
                            style: TextStyle(color: Color(0XFF262626)),
                            decoration: InputDecoration(
                                fillColor: Color(0XFFF2F2F2),
                                filled: true,
                                border: InputBorder.none,
                                hintText: "Member name",
                                hintStyle: TextStyle(fontSize: 13)),

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
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8, top: 8),
                          child: TextFormField(
                            controller: memberExperience,
                            autovalidateMode: AutovalidateMode.always,
                            style: TextStyle(color: Color(0XFF262626)),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                fillColor: Color(0XFFF2F2F2),
                                filled: true,
                                border: InputBorder.none,
                                hintText: "Member experience",
                                hintStyle: TextStyle(fontSize: 13)),
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8, top: 8, right: 8),
                          child: TextFormField(
                            controller: memberDesignation,
                            autovalidateMode: AutovalidateMode.always,
                            style: TextStyle(color: Color(0XFF262626)),
                            decoration: InputDecoration(
                                fillColor: Color(0XFFF2F2F2),
                                filled: true,
                                border: InputBorder.none,
                                hintText: "Member designation",
                                hintStyle: TextStyle(fontSize: 13)),
                            onSaved: (String value) {},
                          ),
                        ),
                      ),
                      if (_isLoad)
                        CircularProgressIndicator()
                      else
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(right: 8, top: 8),
                            child: RaisedButton(
                              color: Color(0XFFF2F2F2),
                              onPressed: () {
                                // _addItemToList();
                                _trySubmit();
                              },
                              child: Text(
                                "Add More",
                                style: TextStyle(
                                    fontSize: 15 *
                                        MediaQuery.of(context).textScaleFactor),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: Provider.of<ApiManager>(context).fetchMembersApi(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState == ConnectionState.none)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else if (snapshots.hasError) {
                        return Text("${snapshots.error}");
                      } else {
                        if (snapshots.hasData) {
                          ResponseFetchMembers response = snapshots.data;
                          List<DataMembers> data = response.data;
                          return ListView.builder(
                              itemCount: data.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0XFF2CB3BF))),
                                  child: ListTile(
                                    title: Text(
                                      data[index].name,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      data[index].designation,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0XFF262626)),
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (_isLoadsd)
                                          SizedBox(
                                              width: 18,
                                              height: 18,
                                              child:
                                                  CircularProgressIndicator())
                                        else
                                          GestureDetector(
                                              onTap: () {
                                                _deleteMemberApi(
                                                    data[index].id);
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                size: 28,
                                                color: Colors.red,
                                              )),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          data[index].experience,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Center(
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontFamily: "Proxima Nova",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20 *
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (_isLoads)
                    CircularProgressIndicator()
                  else
                    GestureDetector(
                      onTap: () {
                        _editProfileApi();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, left: 15, right: 15),
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
          ],
        ),
      ),
    );
  }
}
