import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../apiService/apimanager.dart';
import '../screen/createnewmealbycategory.dart';

class CreateNewdiet extends StatefulWidget {
  final String id, tagMeal;
  CreateNewdiet({this.id, this.tagMeal});

  @override
  _CreateNewdietState createState() => _CreateNewdietState();
}

class _CreateNewdietState extends State<CreateNewdiet> {
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

  DateTime selectedEndDate = DateTime.now();

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
          "CREATE DIET",
          style: TextStyle(
              fontSize: 18 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                margin:
                    EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
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
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Diet Title",
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
                      controller: dietController,
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
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "From",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF2CB3BF)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "To",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF2CB3BF)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateNewdiet()));
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.only(top: 8),
                              /*decoration:BoxDecoration(
                                        border:Border.all()),*/
                              child: RaisedButton(
                                onPressed: () =>
                                    _selectDate(context), // Refer step 3
                                child: selectedDate == null
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("From"))
                                    : Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
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
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 8),
                            child: RaisedButton(
                              onPressed: () =>
                                  _selectEndDate(context), // Refer step 3
                              child: selectedEndDate == null
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("To"))
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}',
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
                    GestureDetector(
                      onTap: _trySubmit,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0XFF2CB3BF),
                        child: Center(
                          child: Text(
                            "Create Diet",
                            style: TextStyle(
                              fontSize:
                                  19 * MediaQuery.of(context).textScaleFactor,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: Provider.of<ApiManager>(context).reviewDietListApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          // padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0XFF2CB3BF), width: 1),
                              borderRadius: BorderRadius.circular(6)),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CreateNewMealByCategory(
                                          id: snapshot.data['data'][index]
                                              ['id'],
                                          date: formatDate(
                                                  DateTime(
                                                      selectedDate.year,
                                                      selectedDate.month,
                                                      selectedDate.day),
                                                  [yyyy, '-', mm, '-', dd])
                                              .toString(),
                                          toDate: snapshot.data['data'][index]
                                              ['to_date'])))
                                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateNewMealByCategory(id:snapshot.data['data'][index]['id'],date:formatDate(DateTime(selectedDate.year,selectedDate.month,selectedDate.day), [yyyy, '-', mm, '-', dd]).toString(),toDate:snapshot.data['data'][index]['to_date'])))
                                  ;
                            },
                            title: Text(
                              snapshot.data['data'][index]['name'],
                              style: TextStyle(
                                  fontSize: 18 *
                                      MediaQuery.of(context).textScaleFactor,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF2CB3BF)),
                            ),
                            subtitle: Text(
                              '${snapshot.data['data'][index]['from_date']} to ${snapshot.data['data'][index]['to_date']}',
                              style: TextStyle(
                                  fontSize: 13 *
                                      MediaQuery.of(context).textScaleFactor,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF262626)),
                            ),
                            trailing: Container(
                              width: 53,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Color(0XFF2CB3BF),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.more_vert)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Text("");
                  }
                },
              )

              /*FutureBuilder(
                future: Provider.of<ApiManager>(context).fetchMealByUserIdApi(widget.id),
                builder: (context,snapshots){
                  if(snapshots.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),);
                  else if (snapshots.hasError) {
                    return Text("${snapshots.error}");}
                  else{
                    if(snapshots.hasData){
                      ResponseFetchMeal response = snapshots.data;
                      List<Data> data = response.data;
                      return data==null?
                      Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 25),
                        child: Text("No Meal added yet now"),
                      ):ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,i){
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 15,right: 15),
                                  height: 75,
                                  width: MediaQuery.of(context).size.width,
                                  color: Color(0XFFF2F2F2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(data[i].meal.name,style: TextStyle(
                                              fontSize: 19*MediaQuery.of(context).textScaleFactor,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600
                                          ),),

                                          Text(data[i].meal.note==null ? "":data[i].meal.note,style: TextStyle(
                                              fontSize: 16*MediaQuery.of(context).textScaleFactor,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600
                                          ),),
                                        ],
                                      ),

                                      SizedBox(width: 15,),

                                      Text(data[i].meal.mealTime,
                                        style: TextStyle(
                                            fontSize: 14*MediaQuery.of(context).textScaleFactor,
                                            color: Colors.black
                                        ),),

                                      Row(children: <Widget>[
                                        GestureDetector(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditMeal(maelName:data[i].meal.name,mealTime:data[i].meal.mealTime,id:data[i].meal.id,note:data[i].meal.note)));},
                                            child: Icon(Icons.edit,color: Color(0XFF484848),size: 25,)),

                                        SizedBox(width: 18,),

                                        GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                removeMealApi(data[i].meal.id);
                                              });
                                            },
                                            child: Icon(Icons.delete,color: Color(0XFF484848),size: 25,)),
                                      ],)

                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left:15,right: 15,top: 10,bottom: 10),
                                  margin: EdgeInsets.only(top:1,bottom: 20,right: 20,left: 20),
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
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:10.0),
                                                    child: Text("Calories",style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.normal,
                                                        color: Color(0XFF262626)
                                                    ),),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:10.0),
                                              child: Text("0 kcal",style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0XFF262626)
                                              ),),
                                            ),
                                          ),

                                        ],
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:10.0),
                                              child: Text(data[i].sum.protein == null ? "0":data[i].sum.protein.toString()+"gm",style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0XFF262626)
                                              ),),
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:10.0),
                                              child: Text(data[i].sum.carbs == null ? "0":data[i].sum.carbs.toString()+"gm",style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0XFF262626)
                                              ),),
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:10.0),
                                              child: Text(data[i].sum.fats == null ? "0":data[i].sum.fats.toString()+"gm",style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0XFF262626)
                                              ),),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 10,),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                          Row(
                                            children: [

                                              CircleAvatar(
                                                radius: 8,
                                                backgroundColor: Color(0XFFFC9C84),
                                              ),

                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left:10.0),
                                                  child: Text("Protein",style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.normal,
                                                      color: Color(0XFF262626)
                                                  ),),
                                                ),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            children: [

                                              CircleAvatar(
                                                radius: 8,
                                                backgroundColor: Color(0XFFF27AB4),
                                              ),

                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left:10.0),
                                                  child: Text("Carbs",style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.normal,
                                                      color: Color(0XFF262626)
                                                  ),),
                                                ),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            children: [

                                              CircleAvatar(
                                                radius: 8,
                                                backgroundColor: Color(0XFFFB7B84),
                                              ),

                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left:10.0),
                                                  child: Text("Fats",style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.normal,
                                                      color: Color(0XFF262626)
                                                  ),),
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                                ListView.builder(itemCount: data[i].foods.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,index){
                                      return Container(
                                        padding: EdgeInsets.only(left:15,right: 15,top: 10,),
                                        margin: EdgeInsets.only(top:10,bottom: 20,right: 20,left: 20),
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
                                          borderRadius: BorderRadius.circular(20),),
                                        child: ListTile(
                                          trailing: GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  removeFoodApi(data[i].foods[index].id,data[i].meal.id);
                                                });
                                              },
                                              child: Icon(Icons.delete,size: 28,)),
                                          leading: Icon(Icons.rotate_90_degrees_ccw_outlined,color: Colors.green,),
                                          title: Text(data[i].foods[index].name,style: TextStyle(
                                            fontSize: 15*MediaQuery.of(context).textScaleFactor,
                                            color: Colors.black,
                                          ),),
                                          subtitle: Text(data[i].foods[index].protein,
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                color: Color(0XFF484848)
                                            ),),
                                        ),
                                      );
                                    }),

                                SizedBox(height: 15,),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddFood(mealId:data[i].meal.id)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 25),
                                      child: Text("+ Add Food",
                                        style: TextStyle(
                                            fontSize: 15*MediaQuery.of(context).textScaleFactor,
                                            color: Color(0XFF2CB3BF),
                                            fontWeight: FontWeight.w600
                                        ),),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 25,),

                              ],
                            );
                          });
                    }else{
                      return Center(child: Text("",
                        style: TextStyle(
                            fontFamily: "Proxima Nova",
                            fontWeight: FontWeight.w600,
                            fontSize: 20*MediaQuery.of(context).textScaleFactor
                        ),),);
                    }
                  }
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchMealDiet.dart';
import 'package:tws/fragment/addfood.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apimanager.dart';
import 'package:tws/fragment/editmeal.dart';
import 'package:tws/screen/createmeal.dart';

class CreateNewdiet extends StatefulWidget {

  final String id,tagMeal;
  CreateNewdiet({this.id,this.tagMeal});

  @override
  _CreateNewdietState createState() => _CreateNewdietState();
}

class _CreateNewdietState extends State<CreateNewdiet> {

  String tag = "";
  String createTag = "";
  bool _isLoad = false;
  bool _isLoadFood = false,_isLoadMeal;

  void removeFoodApi(String id,String mealId) async{
    setState(() {
      _isLoadFood = true;
    });
    await Provider.of<ApiManager>(context,listen: false).removeFoodApi(id,mealId);

    setState(() {
      _isLoadFood = false;
    });

  }

  void removeMealApi(String id) async{
    setState(() {
      _isLoadMeal = true;
    });
    await Provider.of<ApiManager>(context,listen: false).removeMealApi(id);

    setState(() {
      _isLoadMeal = false;
    });
  }

  void _trySubmit()async{
    if(dietController.text.isEmpty){
      Fluttertoast.showToast(msg: "Enter diet",
          gravity: ToastGravity.BOTTOM);
    }else{
      setState(() {
        _isLoad = true;
      });

      await Provider.of<ApiManager>(context,listen: false).createNewDietApi(dietController.text, selectedDate.toString(), selectedEndDate.toString());

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

  void _addItemToList(){
    setState(() {
      names.insert(0,"");
      msgCount.insert(0, 0);
    });}

  void removeItem(){
    setState(() {
      for(int i=0;i<names.length;i++){
        names.removeAt(i);}});}

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),);

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  DateTime selectedEndDate = DateTime.now();

  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),);

    if (picked != null && picked != selectedEndDate)
      setState(() {
        selectedEndDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    dietController.dispose();
    super.dispose();}

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
            ),),
        backgroundColor: Color(0XFF2CB3BF),
        title: Text("CREATE DIET",style: TextStyle(
            fontSize: 18*MediaQuery.of(context).textScaleFactor,
            color: Colors.white
        ),),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(top:20,bottom: 20,right: 20,left: 20),
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
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: <Widget>[

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Diet Title",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),),
                        ),

                        SizedBox(height: 7,),

                        TextFormField(
                          controller: dietController,
                          autovalidateMode: AutovalidateMode.always,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(fillColor: Color(0XFFF2F2F2), filled: true,
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

                        SizedBox(height: 10,),

                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Text("From",style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF2CB3BF)
                                  ),),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("To",style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF2CB3BF)
                                  ),),
                                ),
                              ),
                            ),

                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: (){
                                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateNewdiet()));
                                },
                                child: Container(
                                  height:50,
                                  margin: EdgeInsets.only(top: 8),
                                  */
/*decoration:BoxDecoration(
                                            border:Border.all()),*/ /*

                                  child: RaisedButton(
                                    onPressed: () => _selectDate(context), // Refer step 3
                                    child: selectedDate == null?Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("From")):Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                        style: TextStyle(color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize:13
                                        ),
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                              ),),

                            SizedBox(width: 20,),

                            Expanded(
                              flex: 1,
                              child: Container(
                                height:50,
                                margin: EdgeInsets.only(top: 8),
                                child: RaisedButton(
                                  onPressed: () => _selectEndDate(context), // Refer step 3
                                  child:selectedEndDate==null?Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("To")):Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}',
                                      style: TextStyle(color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize:13
                                      ),
                                    ),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),

                  if(widget.tagMeal == null)
                    Text("")
                  else
                    FutureBuilder(
                      future: Provider.of<ApiManager>(context).fetchMealByUserIdApi(widget.id),
                      builder: (context,snapshots){
                        if(snapshots.connectionState == ConnectionState.waiting)
                          return Center(
                            child: CircularProgressIndicator(),);
                        else if (snapshots.hasError) {
                          return Text("${snapshots.error}");}
                        else{
                          if(snapshots.hasData){
                            ResponseFetchMeal response = snapshots.data;
                            List<Data> data = response.data;
                            return data==null?
                            Padding(
                              padding: const EdgeInsets.only(top: 15,bottom: 25),
                              child: Text("No Meal added yet now"),
                            ):ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context,i){
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 15,right: 15),
                                        height: 75,
                                        width: MediaQuery.of(context).size.width,
                                        color: Color(0XFFF2F2F2),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(data[i].meal.name,style: TextStyle(
                                                    fontSize: 19*MediaQuery.of(context).textScaleFactor,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600
                                                ),),

                                                Text(data[i].meal.note==null ? "":data[i].meal.note,style: TextStyle(
                                                    fontSize: 16*MediaQuery.of(context).textScaleFactor,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ],
                                            ),

                                            SizedBox(width: 15,),

                                            Text(data[i].meal.mealTime,
                                              style: TextStyle(
                                                  fontSize: 14*MediaQuery.of(context).textScaleFactor,
                                                  color: Colors.black
                                              ),),

                                            Row(children: <Widget>[
                                              GestureDetector(
                                                  onTap: (){
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditMeal(maelName:data[i].meal.name,mealTime:data[i].meal.mealTime,id:data[i].meal.id,note:data[i].meal.note)));},
                                                  child: Icon(Icons.edit,color: Color(0XFF484848),size: 25,)),

                                              SizedBox(width: 18,),

                                              GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      removeMealApi(data[i].meal.id);
                                                    });
                                                  },
                                                  child: Icon(Icons.delete,color: Color(0XFF484848),size: 25,)),
                                            ],)

                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left:15,right: 15,top: 10,bottom: 10),
                                        margin: EdgeInsets.only(top:1,bottom: 20,right: 20,left: 20),
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
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left:10.0),
                                                          child: Text("Calories",style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.normal,
                                                              color: Color(0XFF262626)
                                                          ),),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),

                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:10.0),
                                                    child: Text("0 kcal",style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0XFF262626)
                                                    ),),
                                                  ),
                                                ),

                                              ],
                                            ),

                                            SizedBox(
                                              height: 10,
                                            ),

                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:10.0),
                                                    child: Text(data[i].sum.protein == null ? "0":data[i].sum.protein.toString()+"gm",style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.normal,
                                                        color: Color(0XFF262626)
                                                    ),),
                                                  ),
                                                ),

                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:10.0),
                                                    child: Text(data[i].sum.carbs == null ? "0":data[i].sum.carbs.toString()+"gm",style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.normal,
                                                        color: Color(0XFF262626)
                                                    ),),
                                                  ),
                                                ),

                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:10.0),
                                                    child: Text(data[i].sum.fats == null ? "0":data[i].sum.fats.toString()+"gm",style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.normal,
                                                        color: Color(0XFF262626)
                                                    ),),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 10,),

                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[

                                                Row(
                                                  children: [

                                                    CircleAvatar(
                                                      radius: 8,
                                                      backgroundColor: Color(0XFFFC9C84),
                                                    ),

                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left:10.0),
                                                        child: Text("Protein",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.normal,
                                                            color: Color(0XFF262626)
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Row(
                                                  children: [

                                                    CircleAvatar(
                                                      radius: 8,
                                                      backgroundColor: Color(0XFFF27AB4),
                                                    ),

                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left:10.0),
                                                        child: Text("Carbs",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.normal,
                                                            color: Color(0XFF262626)
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Row(
                                                  children: [

                                                    CircleAvatar(
                                                      radius: 8,
                                                      backgroundColor: Color(0XFFFB7B84),
                                                    ),

                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left:10.0),
                                                        child: Text("Fats",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.normal,
                                                            color: Color(0XFF262626)
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),


                                          ],
                                        ),
                                      ),
                                      ListView.builder(itemCount: data[i].foods.length,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context,index){
                                            return Container(
                                              padding: EdgeInsets.only(left:15,right: 15,top: 10,),
                                              margin: EdgeInsets.only(top:10,bottom: 20,right: 20,left: 20),
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
                                                borderRadius: BorderRadius.circular(20),),
                                              child: ListTile(
                                                trailing: GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        removeFoodApi(data[i].foods[index].id,data[i].meal.id);
                                                      });
                                                    },
                                                    child: Icon(Icons.delete,size: 28,)),
                                                leading: Icon(Icons.rotate_90_degrees_ccw_outlined,color: Colors.green,),
                                                title: Text(data[i].foods[index].name,style: TextStyle(
                                                  fontSize: 15*MediaQuery.of(context).textScaleFactor,
                                                  color: Colors.black,
                                                ),),
                                                subtitle: Text(data[i].foods[index].protein,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.normal,
                                                      color: Color(0XFF484848)
                                                  ),),
                                              ),
                                            );
                                          }),

                                      SizedBox(height: 15,),

                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddFood(mealId:data[i].meal.id)));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 25),
                                            child: Text("+ Add Food",
                                              style: TextStyle(
                                                  fontSize: 15*MediaQuery.of(context).textScaleFactor,
                                                  color: Color(0XFF2CB3BF),
                                                  fontWeight: FontWeight.w600
                                              ),),
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 25,),

                                    ],
                                  );
                                });
                          }else{
                            return Center(child: Text("",
                              style: TextStyle(
                                  fontFamily: "Proxima Nova",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20*MediaQuery.of(context).textScaleFactor
                              ),),);
                          }
                        }
                      },
                    ),
                ],
              ),
            ),
          ),

          if(widget.tagMeal == null)
            if(_isLoad)
              Positioned(bottom:0,left: 0,right: 0,child: CircularProgressIndicator())
            else
              if(tag=="")
                Positioned(
                    bottom: 0,
                    child: GestureDetector(
                      onTap: _trySubmit*/
/*(){
                  _addItemToList();
                }*/ /*
,
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
            )
        ],
      ),
    );
  }
}*/
