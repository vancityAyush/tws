import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/AppConstant.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchAllFoods.dart';
import 'package:tws/apiService/apimanager.dart';
import 'package:tws/apiService/sharedprefrence.dart';

class AddFood extends StatefulWidget {
  final String mealId, id;

  AddFood({this.mealId, this.id});

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  String selectedValue, foodName;

  bool isSelected = true;

  final List<DropdownMenuItem> items = [];

  TextEditingController foodController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController carbController = TextEditingController();
  TextEditingController fatController = TextEditingController();

  bool _isLoad = false;

  void _trySubmit() async {
    if (foodController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter food", gravity: ToastGravity.BOTTOM);
    } else if (proteinController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter protein", gravity: ToastGravity.BOTTOM);
    } else if (carbController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter carbs", gravity: ToastGravity.BOTTOM);
    } else if (fatController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter fats", gravity: ToastGravity.BOTTOM);
    } else {
      setState(() {
        _isLoad = true;
      });
      await Provider.of<ApiManager>(context, listen: false).addFoodApi(
          foodController.text,
          proteinController.text,
          carbController.text,
          fatController.text,
          widget.mealId,
          widget.id);
      setState(() {
        _isLoad = false;
      });
    }
  }

  Widget _foodDropDown() {
    return new Container(
      margin: const EdgeInsets.only(left: 10.0, top: 2.0, right: 10.0),
      height: 50.0,
      /*decoration: new BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black)
      ),*/
      child: DropdownSearch(
        mode: Mode.MENU,
        hint: "Select Food",
        showSearchBox: true,
        onFind: (String filter) async {
          var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
          FormData formData = new FormData.fromMap({"key": key});
          var response = await Dio().post(
              "http://fitnessapp.frantic.in/TrainerRestApi/fetch_all_foods",
              queryParameters: {"filter": filter},
              data: formData);
          var models = ResponseFetchAllFoods.fromJson(response.data);
          return models.data;
        },
        onChanged: (Data data) {
          foodName = data.name;
          selectedValue = data.name;
          Provider.of<ApiManager>(context, listen: false)
              .addFoodToMealApi(data.id, widget.mealId, widget.id);
          if (selectedValue == selectedValue) {
            setState(() {
              isSelected = false;
            });
          }
        },
        itemAsString: (Data da) => da.name,
      ),
    );
  }

  @override
  void dispose() {
    foodController.dispose();
    proteinController.dispose();
    carbController.dispose();
    fatController.dispose();
    super.dispose();
  }

  final String loremIpsum = "Bread , Apple , Banana ,";

  @override
  void initState() {
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
              return (item.value == wordPair);
            }) ==
            -1) {
          items.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }
    });
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
        title: Text(
          "Add Food",
          style: TextStyle(
              fontSize: 17 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
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
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Food Name",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF2CB3BF)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: _foodDropDown(),
              ),

              /*SearchableDropdown.single(
                items: items,
                value: selectedValue,
                hint: "Select Food",
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                    if(selectedValue == selectedValue){
                      isSelected = false;
                    }
                    // print(selectedValue);
                  });
                },
                isExpanded: true,
              ),*/

              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: isSelected,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "OR",
                        style: TextStyle(
                          fontSize: 25 * MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextFormField(
                        controller: foodController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize:
                                  17 * MediaQuery.of(context).textScaleFactor,
                              color: Color(0XFF2CB3BF)),
                          labelText: "Enter food name",
                          labelStyle: TextStyle(color: Color(0XFF2CB3BF)),
                          // hintText: "Name/Business Name",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: proteinController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize:
                                  17 * MediaQuery.of(context).textScaleFactor,
                              color: Color(0XFF2CB3BF)),
                          labelText: "Enter protein",
                          labelStyle: TextStyle(color: Color(0XFF2CB3BF)),
                          // hintText: "Name/Business Name",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        controller: carbController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize:
                                  17 * MediaQuery.of(context).textScaleFactor,
                              color: Color(0XFF2CB3BF)),
                          labelText: "Enter carbs",
                          labelStyle: TextStyle(color: Color(0XFF2CB3BF)),
                          // hintText: "Name/Business Name",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        controller: fatController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize:
                                  17 * MediaQuery.of(context).textScaleFactor,
                              color: Color(0XFF2CB3BF)),
                          labelText: "Enter fats",
                          labelStyle: TextStyle(color: Color(0XFF2CB3BF)),
                          // hintText: "Name/Business Name",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFF363434)),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              if (_isLoad)
                CircularProgressIndicator()
              else
                GestureDetector(
                  onTap: _trySubmit,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.38,
                    height: 40,
                    child: Center(
                      child: Text(
                        "Add Food",
                        style: TextStyle(
                            fontSize:
                                21 * MediaQuery.of(context).textScaleFactor,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0XFF299FAB),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
