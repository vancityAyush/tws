import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchMembership.dart';
import 'package:tws/apiService/apiResponse/ResponsePlans.dart';
import 'package:tws/apiService/apimanager.dart';

class MemberShipPackageEdit extends StatefulWidget {
  final String month, price, id;

  MemberShipPackageEdit({this.month, this.price, this.id});

  @override
  _MemberShipPackageEditState createState() => _MemberShipPackageEditState();
}

class _MemberShipPackageEditState extends State<MemberShipPackageEdit> {
  List<Data> data1 = [];
  List<DataMembership> dataMemberShip = [];
  TextEditingController priceController = TextEditingController();

  Future<String> fetchPlans() async {
    var future =
        await Provider.of<ApiManager>(context, listen: false).fetchPlansApi();
    setState(() {
      data1 = future.data;
    });
  }

  var selectedValue;
  bool _isLoad = false;
  void _trySubmit() async {
    setState(() {
      _isLoad = true;
    });
    await Provider.of<ApiManager>(context, listen: false)
        .editMemberShipPackageApi(
            selectedValue, priceController.text, widget.id);
    setState(() {
      _isLoad = false;
    });
    priceController.clear();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      priceController.text = widget.price;
      selectedValue = widget.month;
    });
    super.initState();
    this.fetchPlans();
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
        centerTitle: true,
        title: Text(
          "Membership Package",
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
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Month",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                Container(
                  color: Color(0XFFF2F2F2),
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  margin: EdgeInsets.only(top: 10),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedValue,
                    hint: Text("Select month"),
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
                        selectedValue = data;
                      });
                    },
                    items: data1.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value.name,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Price",
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
                  controller: priceController,
                  autovalidateMode: AutovalidateMode.always,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Color(0XFF262626)),
                  decoration: InputDecoration(
                    fillColor: Color(0XFFF2F2F2),
                    filled: true,
                    border: InputBorder.none,
                    hintText: "Enter price",
                  ),
                  onSaved: (String value) {},
                ),
                if (_isLoad)
                  CircularProgressIndicator()
                else
                  GestureDetector(
                    onTap: _trySubmit,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: Center(
                        child: Text(
                          "Edit",
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
      ),
    );
  }
}
