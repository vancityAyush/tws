import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchExerciseByUserId.dart';
import 'package:tws/apiService/apimanager.dart';
import 'package:tws/fragment/filter.dart';

import 'newaddsetworkouttemplate.dart';

class AddExerCise extends StatefulWidget {
  @override
  _AddExerCiseState createState() => _AddExerCiseState();
}

class _AddExerCiseState extends State<AddExerCise> {
  bool _isLoad = false;

  void _trySubmit(String tag) async {
    setState(() {
      _isLoad = true;
    });

    await Provider.of<ApiManager>(context, listen: false)
        .addExerciseToClientWorkout(tag, addId, addName);

    setState(() {
      _isLoad = true;
    });
  }

  bool isPresent(String name) {
    return addName.contains(name);
  }

  Set addName = new Set();
  bool isSelected = false;
  Set addId = new Set();
  String nameColor;
  String tag = "";
  List<int> indexList = [0];
  final List<String> names = <String>[];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];
  bool status = false;
  List<int> newBool = new List();
  int currentSelectedIndex = 0;

  void _addItemToList() {
    setState(() {
      names.insert(0, "");
      msgCount.insert(0, 0);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0XFF2CB3BF),
        title: Text(
          "Add Exercise",
          style: TextStyle(
              fontSize: 16 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      setState(() {
                        status = true;
                      });
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    )),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FilterScreen()));
                    },
                    child: Container(
                        width: 23,
                        height: 23,
                        child: Image.asset(
                          "assets/images/filtered.png",
                          width: 23,
                          height: 23,
                          color: Colors.white,
                        )))
              ],
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Visibility(
                    visible: status,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        enabled: false,
                        onSaved: (value) {},
                        keyboardType: TextInputType.text,
                        maxLength: 25,
                        maxLines: 1,
                        onChanged: (String value) {},
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: InputBorder.none,
                          hintText: 'Search here',
                          filled: true,
                          counterText: "",
                          prefixIcon: Icon(Icons.search),
                          fillColor: Color(0xFFEBF0F3),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.white12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.white12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.white12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.white12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: Provider.of<ApiManager>(context)
                        .fetchExercisesByUserId(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState == ConnectionState.none)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else if (snapshots.hasError) {
                        return Text("${snapshots.error}");
                      } else {
                        if (snapshots.hasData) {
                          ResponseFetchExerciseByUserId response =
                              snapshots.data;
                          List<Data> data = response.data;
                          return data.length == null
                              ? Text("No Exercise Added")
                              : ListView.builder(
                                  itemCount: data.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      tileColor:
                                          isPresent(data[index].name) == true
                                              ? Color(0XFFCDE9FF)
                                              : Colors.white,
                                      onTap: () async {
                                        if (addName.isEmpty) {
                                          setState(() {
                                            addName.add(data[index].name);
                                            addId.add(data[index].id);
                                            print(addName.toList());
                                            nameColor = data[index].name;
                                            print(addName);
                                          });
                                        } else {
                                          for (var name in addName) {
                                            if (name == data[index].name) {
                                              setState(() {
                                                addName
                                                    .remove(data[index].name);
                                                addId.remove(data[index].id);
                                                print(addName.toList());
                                                print(isPresent(
                                                    data[index].name));
                                                nameColor = data[index].name;
                                              });
                                              break;
                                            } else {
                                              setState(() {
                                                addName.add(data[index].name);
                                                print(addName.toList());
                                                addId.add(data[index].id);
                                                nameColor = data[index].name;
                                              });
                                            }
                                          }
                                        }
                                      },
                                      leading: CircleAvatar(
                                        radius: 25,
                                        child: Icon(
                                          isPresent(data[index].name) == true
                                              ? Icons.check
                                              : Icons.clear,
                                          size: 35,
                                          color: Colors.purple,
                                        ),
                                        backgroundColor:
                                            isPresent(data[index].name) == true
                                                ? Colors.white
                                                : Colors.lightBlueAccent,
                                      ),
                                      title: Text(
                                        data[index].name,
                                        style: TextStyle(
                                            fontSize: 15 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            color: Colors.black87),
                                      ),
                                      subtitle: Text(
                                        data[index].selectedUnit,
                                        style: TextStyle(
                                            fontSize: 12 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            color: Color(0XFF808080)),
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
                ],
              ),
            ),
            Positioned(
                right: 20,
                bottom: 20,
                child: Column(
                  children: <Widget>[
                    if (addName.length >= 2)
                      GestureDetector(
                        onTap: () async {
                          tag = "SUPERSET";
                          _trySubmit(tag);
                        },
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.black87,
                          child: Icon(
                            Icons.all_inclusive_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    if (addName.length >= 1)
                      GestureDetector(
                        onTap: () {
                          tag = "NORMAL";
                          _trySubmit(tag);
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewAddWorkoutTemplate()));
                        },
                        child: CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.lightBlue,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            )),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        tag = "NORMAL";
                        // _trySubmit(tag);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewAddWorkoutTemplate(
                                exerciseSuperset: "NORMAL")));
                      },
                      child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.redAccent,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
