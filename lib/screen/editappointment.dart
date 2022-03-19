import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchAppointment.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchClients.dart';
import 'package:tws/apiService/apimanager.dart';

class EditAppointmentScreen extends StatefulWidget {
  DataFetchAppointment data;

  EditAppointmentScreen({this.data});

  @override
  _EditAppointmentScreenState createState() => _EditAppointmentScreenState();
}

class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
  bool _isLoad = false;
  void _trySubmit() async {
    if (dropdownValue == "Meeting Type") {
      Fluttertoast.showToast(msg: "Select Type", gravity: ToastGravity.BOTTOM);
    } else if (dropdownValueUser == "Select User") {
      Fluttertoast.showToast(msg: "Select User", gravity: ToastGravity.BOTTOM);
    } else if (descriptionController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter description", gravity: ToastGravity.BOTTOM);
    } else {
      setState(() {
        _isLoad = true;
      });
      await Provider.of<ApiManager>(context, listen: false).editAppointmentApi(
          dropdownValue,
          selectedDate.toString(),
          _time.toString(),
          _timeEnd.toString(),
          dropdownValueUser,
          descriptionController.text,
          meetingLinkController.text,
          widget.data.id);
      setState(() {
        _isLoad = false;
      });
    }
  }

  bool statusOnline = false;
  bool statusOffline = false;

  TimeOfDay _time = TimeOfDay(hour: 00, minute: 00);

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (newTime != null) {
      setState(() {
        _time = newTime;
        print(_time.toString());
      });
    }
  }

  TimeOfDay _timeEnd = TimeOfDay(hour: 00, minute: 00);

  void _selectEndTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _timeEnd,
    );

    if (newTime != null) {
      setState(() {
        _timeEnd = newTime;
        print(_timeEnd.toString());
      });
    }
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController meetingLinkController = TextEditingController();

  String dropdownValue = 'Meeting Type';

  List<String> spinnerItems = ['Meeting Type', 'Online', 'Offline'];

  void fetchData() {
    setState(() {
      meetingLinkController.text = widget.data.meetLink;
      descriptionController.text = widget.data.description;
      dropdownValueUser = widget.data.selectedUser;
      print("User" + widget.data.selectedUser);
    });
  }

  String dropdownValueUser;
  List<String> spinnerItemsUser = ['Select User', 'Dharmendra', 'Rohit'];

  List<DataFetchClients> data = [];

  var selectedValueUser = "";

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var future =
          Provider.of<ApiManager>(context, listen: false).fetchClientsApi();
      future.then((value) {
        setState(() {
          data = value.data;
        });
      });
    });

    fetchData();

    super.initState();
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
        centerTitle: false,
        title: Text(
          "Edit Appointment",
          style: TextStyle(
              fontSize: 20 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
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
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 12, bottom: 10),
                child: Container(
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
                        if (dropdownValue == "Online") {
                          statusOffline = false;
                          statusOnline = true;
                        } else {
                          statusOffline = true;
                          statusOnline = false;
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
              ),
              Visibility(
                visible: statusOnline,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Meeting Link",
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
                        controller: meetingLinkController,
                        minLines: 1,
                        maxLines: 4,
                        autovalidateMode: AutovalidateMode.always,
                        style: TextStyle(color: Color(0XFF262626)),
                        decoration: InputDecoration(
                          fillColor: Color(0XFFF2F2F2),
                          filled: true,
                          border: InputBorder.none,
                          hintText: "",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
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
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Appointment Date",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 300,
                    height: 50,
                    margin: EdgeInsets.only(top: 8),
                    child: RaisedButton(
                      onPressed: () => _selectDate(context), // Refer step 3
                      child: selectedDate == null
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Appointment Date"))
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Appointment Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                            ),
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                      right: 10,
                      top: 0,
                      bottom: 0,
                      child: Icon(Icons.arrow_drop_down))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Timings",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 8),
                      /*decoration:BoxDecoration(
                              border:Border.all()),*/
                      child: RaisedButton(
                        onPressed: () => _selectTime(), // Refer step 3
                        child: _time == null
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Start Time"))
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Start Time: ${_time.hour}:${_time.minute}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                              ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 8),
                      child: RaisedButton(
                        onPressed: () => _selectEndTime(), // Refer step 3
                        child: _timeEnd == null
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text("End Time"))
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'End Time: ${_timeEnd.hour}:${_timeEnd.minute}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                              ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 12, bottom: 10),
                child: Container(
                  color: Color(0XFFF2F2F2),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValueUser,
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
                        dropdownValueUser = data;
                      });
                    },
                    items: data.map<DropdownMenuItem<String>>(
                        (DataFetchClients value) {
                      return DropdownMenuItem<String>(
                        value: value.name,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Description",
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
                  controller: descriptionController,
                  minLines: 1,
                  maxLines: 4,
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
              ),
              if (_isLoad)
                CircularProgressIndicator()
              else
                GestureDetector(
                  onTap: _trySubmit,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 20, bottom: 10, left: 10, right: 10),
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
    );
  }
}
