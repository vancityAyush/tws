import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchMealDiet.dart';
import 'package:tws/apiService/apimanager.dart';
import 'package:tws/fragment/addfood.dart';
import 'package:tws/fragment/editmeal.dart';
import 'package:tws/screen/createmeal.dart';

class CreateNewMealByCategory extends StatefulWidget {
  final String id, date, toDate;
  CreateNewMealByCategory({this.id, this.date, this.toDate});

  @override
  _CreateNewMealByCategoryState createState() =>
      _CreateNewMealByCategoryState();
}

class _CreateNewMealByCategoryState extends State<CreateNewMealByCategory> {
  double addCalories = 0;
  String tag = "";
  String createTag = "";
  bool _isLoad = false;
  bool _isLoadFood = false, _isLoadMeal;

  void removeFoodApi(String id, String mealId) async {
    setState(() {
      _isLoadFood = true;
    });

    await Provider.of<ApiManager>(context, listen: false)
        .removeFoodApi(id, mealId);

    setState(() {
      _isLoadFood = false;
    });
  }

  void removeMealApi(String id) async {
    setState(() {
      _isLoadMeal = true;
    });
    await Provider.of<ApiManager>(context, listen: false).removeMealApi(id);

    setState(() {
      _isLoadMeal = false;
    });
  }

  void _trySubmit() async {
    if (dietController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter diet", gravity: ToastGravity.BOTTOM);
    } else {
      setState(() {
        _isLoad = true;
      });

      await Provider.of<ApiManager>(context, listen: false).createNewDietApi(
          dietController.text,
          selectedDate.toString(),
          selectedEndDate.toString());

      tag = "CreateMeal";
      dietController.clear();
      setState(() {
        _isLoad = false;
      });
    }
  }

  TextEditingController dietController = TextEditingController();
  final List<String> names = <String>[];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];

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

  bool newDate = true;
  DateTime selectedEndDate = DateTime.now();
  DateTime dateTime, dateTimeEndDate;

  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
    );

    if (picked != null && picked != selectedEndDate)
      setState(() {
        selectedEndDate = picked;
      });
  }

  @override
  void initState() {
    if (widget.toDate == null) {
    } else {
      dateTime = DateTime.parse(widget.date);
      dateTimeEndDate = DateTime.parse(widget.toDate);
      newDate = dateTime.isAfter(dateTimeEndDate);
      print("DateTimesssss " + newDate.toString());
    }
    super.initState();
  }

  @override
  void dispose() {
    dietController.dispose();
    super.dispose();
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
          "CREATE MEAL",
          style: TextStyle(
              fontSize: 18 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: FutureBuilder(
                future: Provider.of<ApiManager>(context)
                    .fetchMealByUserIdApi(widget.id),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else if (snapshots.hasError) {
                    return Text("${snapshots.error}");
                  } else {
                    if (snapshots.hasData) {
                      ResponseFetchMeal response = snapshots.data;
                      List<Data> data = response.data;
                      return data == null
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 25),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text("No Meal added yet now"))),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                if (data[i].sum.fats == null) {
                                  addCalories = 0.0;
                                } else {
                                  addCalories =
                                      (double.parse(data[i].sum.fats) * 9.0) +
                                          (double.parse(data[i].sum.carbs) *
                                              4.0) +
                                          (double.parse(data[i].sum.protein) *
                                              4.0);
                                }
                                // print("ad"+addCalories.toString());
                                return Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      height: 75,
                                      width: MediaQuery.of(context).size.width,
                                      color: Color(0XFFF2F2F2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                data[i].meal.name,
                                                style: TextStyle(
                                                    fontSize: 19 *
                                                        MediaQuery.of(context)
                                                            .textScaleFactor,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                data[i].meal.note == null
                                                    ? ""
                                                    : data[i].meal.note,
                                                style: TextStyle(
                                                    fontSize: 16 *
                                                        MediaQuery.of(context)
                                                            .textScaleFactor,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            data[i].meal.mealTime,
                                            style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                                color: Colors.black),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator
                                                            .of(context)
                                                        .push(MaterialPageRoute(
                                                            builder: (context) =>
                                                                EditMeal(
                                                                    maelName: data[
                                                                            i]
                                                                        .meal
                                                                        .name,
                                                                    mealTime: data[
                                                                            i]
                                                                        .meal
                                                                        .mealTime,
                                                                    id: data[
                                                                            i]
                                                                        .meal
                                                                        .id,
                                                                    note: data[
                                                                            i]
                                                                        .meal
                                                                        .note)));
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Color(0XFF484848),
                                                    size: 25,
                                                  )),
                                              SizedBox(
                                                width: 18,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      removeMealApi(
                                                          data[i].meal.id);
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Color(0XFF484848),
                                                    size: 25,
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      margin: EdgeInsets.only(
                                          top: 1,
                                          bottom: 20,
                                          right: 20,
                                          left: 20),
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
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.border_top),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        child: Text(
                                                          "Calories",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Color(
                                                                  0XFF262626)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Text(
                                                    addCalories.toString() +
                                                        " cal",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0XFF262626)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Text(
                                                    data[i].sum.protein == null
                                                        ? "0"
                                                        : data[i]
                                                                .sum
                                                                .protein
                                                                .toString() +
                                                            "gm",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Color(0XFF262626)),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Text(
                                                    data[i].sum.carbs == null
                                                        ? "0"
                                                        : data[i]
                                                                .sum
                                                                .carbs
                                                                .toString() +
                                                            "gm",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Color(0XFF262626)),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Text(
                                                    data[i].sum.fats == null
                                                        ? "0"
                                                        : data[i]
                                                                .sum
                                                                .fats
                                                                .toString() +
                                                            "gm",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Color(0XFF262626)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 8,
                                                    backgroundColor:
                                                        Color(0XFFFC9C84),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Text(
                                                        "Protein",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Color(
                                                                0XFF262626)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 8,
                                                    backgroundColor:
                                                        Color(0XFFF27AB4),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Text(
                                                        "Carbs",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Color(
                                                                0XFF262626)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 8,
                                                      backgroundColor:
                                                          Color(0XFFFB7B84)),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Text(
                                                        "Fats",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Color(
                                                                0XFF262626)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                        itemCount: data[i].foods.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                            ),
                                            margin: EdgeInsets.only(
                                                top: 10,
                                                bottom: 20,
                                                right: 20,
                                                left: 20),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              // color: Colors.white,
                                              color: data[i]
                                                          .foods[index]
                                                          .isTaken ==
                                                      false
                                                  ? data[i]
                                                              .foods[index]
                                                              .created_by ==
                                                          "USER"
                                                      ? Color(0XFF2CB3BF)
                                                      : Colors.white
                                                  : Color(0XFFCDE9FF),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset:
                                                      Offset(0.0, 1.0), //(x,y)
                                                  blurRadius: 6.0,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ListTile(
                                              trailing: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      removeFoodApi(
                                                          data[i]
                                                              .foods[index]
                                                              .id,
                                                          data[i].meal.id);
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 28,
                                                  )),
                                              leading: Icon(
                                                Icons
                                                    .rotate_90_degrees_ccw_outlined,
                                                color: Colors.green,
                                              ),
                                              title: Text(
                                                data[i].foods[index].name,
                                                style: TextStyle(
                                                  fontSize: 15 *
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              subtitle: Text(
                                                "C - " +
                                                    data[i].foods[index].carbs +
                                                    "  , P - " +
                                                    data[i]
                                                        .foods[index]
                                                        .protein +
                                                    "  , F - " +
                                                    data[i].foods[index].fats,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0XFF484848)),
                                              ),
                                            ),
                                          );
                                        }),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => AddFood(
                                                      mealId: data[i].meal.id,
                                                      id: widget.id)));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 25),
                                          child: Text(
                                            "+ Add Food",
                                            style: TextStyle(
                                                fontSize: 15 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                                color: Color(0XFF2CB3BF),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                );
                              });
                    } else {
                      return Center(
                        child: Text(
                          "",
                          style: TextStyle(
                              fontFamily: "Proxima Nova",
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  20 * MediaQuery.of(context).textScaleFactor),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
          if (newDate == false)
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    // _addItemToList();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => CreateMeal(id: widget.id)));
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0XFF2CB3BF),
                    child: Center(
                      child: Text(
                        "Create New Meal",
                        style: TextStyle(
                          fontSize: 19 * MediaQuery.of(context).textScaleFactor,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ))

          /*if(widget.tagMeal == null)
            if(_isLoad)
              Positioned(bottom:0,left: 0,right: 0,child: CircularProgressIndicator())
            else
              if(tag=="")
                Positioned(
                    bottom: 0,
                    child: GestureDetector(
                      onTap:(){
                        // _addItemToList();
                        },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0XFF2CB3BF),
                        child: Center(
                          child: Text("Create Diet",style: TextStyle(
                            fontSize: 19*MediaQuery.of(context).textScaleFactor,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                      ),
                    ))
              else
                Positioned(
                    bottom: 0,
                    child: GestureDetector(
                      onTap: (){
                        // _addItemToList();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateMeal()));
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0XFF2CB3BF),
                        child: Center(
                          child: Text("Create New Meal",style: TextStyle(
                            fontSize: 19*MediaQuery.of(context).textScaleFactor,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                      ),
                    ))
          else
            Positioned(
                bottom: 0,
                child: GestureDetector(
                  onTap: (){
                    // _addItemToList();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateMeal()));
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0XFF2CB3BF),
                    child: Center(
                      child: Text("Create New Meal",style: TextStyle(
                        fontSize: 19*MediaQuery.of(context).textScaleFactor,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                  ),
                )
            )*/
        ],
      ),
    );
  }
}
