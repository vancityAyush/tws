import 'package:dropdown_search/dropdown_search.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/AppConstant.dart';
import 'package:tws/apiService/apimanager.dart';
import 'package:tws/apiService/sharedprefrence.dart';

import 'addexercise.dart';

class NewAddWorkoutTemplate extends StatefulWidget {

  String exerciseSuperset;

  NewAddWorkoutTemplate({this.exerciseSuperset});

  @override
  _NewAddWorkoutTemplateState createState() => _NewAddWorkoutTemplateState();
}

class _NewAddWorkoutTemplateState extends State<NewAddWorkoutTemplate> {

  var newTag;
  int newIndex = 0;
  final List<String> names = <String>[];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];
  bool status =false;
  bool isLoadFour = false;
  bool isLoadOne = false;
  bool isLoadThree = false;
  bool isLoadFive = false;
  bool isLoadTwo = false;
  bool isLoadSeven = false;
  bool isLoadSix = false;
  TextEditingController controllerTime = new TextEditingController();
  TextEditingController controllerReps = new TextEditingController();
  TextEditingController controllerWeightThree = new TextEditingController();
  TextEditingController controllerRepsThree = new TextEditingController();
  TextEditingController controllerkm = new TextEditingController();
  TextEditingController controllerLevelFive = new TextEditingController();
  TextEditingController controllerBreath = new TextEditingController();
  TextEditingController controllerTimesFive = new TextEditingController();
  TextEditingController controllerbreathSeven = new TextEditingController();
  TextEditingController controllerRepsSeven = new TextEditingController();
  TextEditingController controllerOne  = TextEditingController();
  TextEditingController controllerTwo  = TextEditingController();
  TextEditingController controllerThree  = TextEditingController();
  TextEditingController controllerFour  = TextEditingController();
  TextEditingController controllerFive  = TextEditingController();
  TextEditingController controllerSix  = TextEditingController();
  TextEditingController controllerSeven  = TextEditingController();

  TextEditingController controllerOneS  = TextEditingController();
  TextEditingController controllerTwoS  = TextEditingController();
  TextEditingController controllerThreeS  = TextEditingController();
  TextEditingController controllerFourS  = TextEditingController();
  TextEditingController controllerFiveS  = TextEditingController();
  TextEditingController controllerSixS  = TextEditingController();
  TextEditingController controllerSevenS  = TextEditingController();
  TextEditingController trademilController  = TextEditingController();
  TextEditingController cyclingController  = TextEditingController();
  TextEditingController crossController  = TextEditingController();
  TextEditingController totalLevelController = new TextEditingController();
  TextEditingController totalTimeController = new TextEditingController();
  TextEditingController timeControllerCycling = new TextEditingController();
  String intensityCycling,setType = "Normal";
  String intensityTrademil="Running";
  bool _isLoad = false,_isLoadCross = false,_isLoadCycling = false;

  Duration resultingDuration = Duration(minutes: 30);

  void _trySubmitTrademill() async{
    var date = await SharedPrefManager.getPrefrenceString(AppConstant.DATE);
    setState(() {
      _isLoad = true;
    });

    await Provider.of<ApiManager>(context,listen: false).beforeExerciseApi(date.toString(), date.toString(), "Trademil", trademilController.text, intensityTrademil);
    setState(() {
      _isLoad = false;
    });
    Navigator.of(context).pop();
  }

  void _trySubmitCycling() async{
    var date = await SharedPrefManager.getPrefrenceString(AppConstant.DATE);
    setState(() {
      _isLoadCycling = true;
    });
    await Provider.of<ApiManager>(context,listen: false).beforeExerciseApi(date.toString(), date.toString(), "Cylcling", cyclingController.text, intensityCycling);
    setState(() {
      _isLoadCycling = false;
    });

    Navigator.of(context).pop();
  }


  void _trySubmitcrossFit() async{
    var date = await SharedPrefManager.getPrefrenceString(AppConstant.DATE);
    setState(() {
      _isLoadCross = true;
    });
    await Provider.of<ApiManager>(context,listen: false).beforeExerciseApi(date.toString(), date.toString(), "Crossfit", totalTimeController.text, totalLevelController.text);
    setState(() {
      _isLoadCross = false;
    });
    Navigator.of(context).pop();
  }


  void _addItemToList(){
    setState(() {
      names.insert(0,"");
      msgCount.insert(0, 0);
    });}

  void removeItem(){
    setState(() {
      for(int i=0;i<names.length;i++){
        names.removeAt(i);
      }
    });
  }

  showAlertDialog(BuildContext context,name,id) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("CANCEL",style: TextStyle(
        color:Color(0XFF37B6C2),
          fontSize: 15
      ),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("REMOVE",style: TextStyle(
          color:Color(0XFF37B6C2),
        fontSize: 15
      ),),
      onPressed:  () async{
        setState(() {
           Provider.of<ApiManager>(context,listen: false).removeExerCiseApi(id);
          Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),),

      title: Text("Remove Exercise?",style: TextStyle(
        fontSize: 20,
        color: Color(0XFF262626),
        fontWeight: FontWeight.w500,),),
      content: Text("This remove '$name' and all of its sets from your workout.You can not undo this action.",),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showPopupMenu(String id,String name) async {
    await showMenu(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      color: Colors.black87,
      context: context,
      position: RelativeRect.fromLTRB(300, 270, 0, 100),
      items: [
        PopupMenuItem<String>(child: const Text('Create superset',style: TextStyle(
              color: Colors.white
            ),), value: 'Create superset'),
        /*PopupMenuItem<String>(
            child: const Text('Replace exercise',
            style: TextStyle(
                color: Colors.white
            ),), value: 'Replace exercise'),*/
        PopupMenuItem<String>(child: GestureDetector(
              onTap: (){
                setState(() {
                  Navigator.pop(context);
                  showAlertDialog(context,name,id);
                });
              },
              child: const Text('Remove exercise',
              style: TextStyle(
                  color: Colors.white
              ),),
            ), value: 'Remove exercise'),

        PopupMenuItem<String>(
            child: const Text('Add Timer',
              style: TextStyle(
                  color: Colors.white
              ),), value: 'Add Timer'),

      ],
      elevation: 8.0,
    );}

    String setTypeSelect;


  void _numberMenu() async {
    showDialog(
        context: context,
        builder: (ctx) =>
            StatefulBuilder(
              builder: (BuildContext contex,StateSetter setState){
                return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Select Set Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),

                                    SizedBox(height: 25,),

                                    new DropdownButton<String>(
                                      isExpanded: true,
                                      items: <String>['NORMAL','WARMUP', 'DROP', 'FAILURE'].map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      value: "NORMAL",
                                      onChanged: (value) {
                                        setState(() {
                                          setType = value.toString();
                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Positioned(
                                    right: 10,
                                    top: 10,
                                    child: GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Icon(Icons.cancel))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                );
              },
            ));
    /*await showMenu(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      color: Colors.black87,
      context: context,
      position: RelativeRect.fromLTRB(100, 400, 100, 400),
      items: [
        PopupMenuItem<String>(
            child: const Text('Warm up',style: TextStyle(
                color: Colors.white
            ),), value: 'WARMUP'),
        PopupMenuItem<String>(
            child: const Text('Drop set',
              style: TextStyle(
                  color: Colors.white
              ),), value: 'DROPSET'),
        PopupMenuItem<String>(
            child: const Text('Failure',
              style: TextStyle(
                  color: Colors.white
              ),), value: 'FAILURE')
      ],
      elevation: 8.0,
    );*/}

    String title;

    void getData() async{
      var titles = await SharedPrefManager.getPrefrenceString(AppConstant.WORKOUTTITLE);
      setState(() {
        title = titles;
      });
    }

    var nameOne;

    @override
  void initState() {
      getData();
    controllerOne.text = nameOne;
    controllerTwo.text;
    controllerThree.text;
    controllerFour.text;
    controllerFive.text;
    controllerSix.text;
    controllerSeven.text;
    controllerOneS.text;
    controllerTwoS.text;
    controllerThreeS.text;
    controllerFourS.text;
    controllerFiveS.text;
    controllerSixS.text;
    controllerSevenS.text;
    super.initState();
  }

    @override
    void dispose() {
    controllerTime.dispose();
    totalLevelController.dispose();
    totalTimeController.dispose();
    trademilController.dispose();
    crossController.dispose();
    cyclingController.dispose();
    trademilController.dispose();
    controllerLevelFive.dispose();
    controllerTimesFive.dispose();
    controllerBreath.dispose();
    controllerbreathSeven.dispose();
    controllerRepsSeven.dispose();
    controllerReps.dispose();
    controllerkm.dispose();
    controllerRepsThree.dispose();
    controllerWeightThree.dispose();
    controllerOne.dispose();
    controllerTwo.dispose();
    controllerThree.dispose();
    controllerFour.dispose();
    controllerFive.dispose();
    controllerSix.dispose();
    controllerSeven.dispose();
    controllerOneS.dispose();
    controllerTwoS.dispose();
    controllerThreeS.dispose();
    controllerFourS.dispose();
    controllerFiveS.dispose();
    controllerSixS.dispose();
    controllerSevenS.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),)),
        backgroundColor: Color(0XFF2CB3BF),
        title: Text("New Workout Template",style: TextStyle(
            fontSize: 16*MediaQuery.of(context).textScaleFactor,
            color: Colors.white
        ),),
      ),body: SingleChildScrollView(
        child: FutureBuilder(
          future: Provider.of<ApiManager>(context).fetchCleintWorkoutDetailsApiApi(),
          builder: (context,snapshots){
            if(snapshots.connectionState == ConnectionState.none)
              return Center(
                child: CircularProgressIndicator(),);
            else if (snapshots.hasError) {
              return Text("${snapshots.error}");}
            else{
              print(""+widget.exerciseSuperset);
              if(snapshots.hasData){
                return Column(
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(top:8,bottom: 0,right: 20,left: 20),
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
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(title.toString(),style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                              ),),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    return showDialog(
                                        context: context,
                                        builder: (ctx) =>
                                            StatefulBuilder(
                                              builder: (BuildContext contex,StateSetter setState){
                                                return Dialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(7.0)
                                                    ),
                                                    child: Stack(
                                                      alignment: Alignment.topCenter,
                                                      children: [
                                                        Container(
                                                          height: 300,
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                            child: Stack(
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text('Trademil', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                                                    SizedBox(height: 25,),

                                                                    GestureDetector(
                                                                      onTap: ()async{
                                                                        resultingDuration = await showDurationPicker(
                                                                          context: context,
                                                                          initialTime: resultingDuration,
                                                                        );
                                                                        setState(() {
                                                                          resultingDuration = resultingDuration;
                                                                        });
                                                                      },
                                                                      child: Card(
                                                                        elevation: 3,
                                                                        child: Container(
                                                                          width: double.infinity,
                                                                          height: 50,
                                                                          padding: EdgeInsets.all(10),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(7.0),
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                    color: Colors.grey[300],
                                                                                    offset: Offset(0.0, 1.0),
                                                                                    blurRadius: 6.0,
                                                                                  ),
                                                                              ]
                                                                          ),
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text('Duration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                                                              Text('${resultingDuration.inMinutes} mins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 8,),
                                                                    // TextFormField(
                                                                    //   controller: trademilController,
                                                                    //   autovalidateMode: AutovalidateMode.always,
                                                                    //   keyboardType: TextInputType.number,
                                                                    //   style: TextStyle(color: Color(0XFF262626)),
                                                                    //   decoration: InputDecoration(fillColor: Color(0XFFF2F2F2), filled: true,
                                                                    //     border: InputBorder.none,
                                                                    //     hintText: "Time in minutes",
                                                                    //   ),
                                                                    //   // decoration: const InputDecoration(
                                                                    //   //   hintText: 'Bio',
                                                                    //   //   labelText: 'Bio',
                                                                    //   //
                                                                    //   // ),
                                                                    //   onSaved: (String value) {
                                                                    //     // This optional block of code can be used to run
                                                                    //     // code when the user saves the form.
                                                                    //   },
                                                                    // ),

                                                                    SizedBox(height: 8,),

                                                                    Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text('Intensity', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),)),

                                                                    new DropdownButton<String>(
                                                                      isExpanded: true,
                                                                      items: <String>['Running', 'Walking', 'Jogging'].map((String value) {
                                                                        return new DropdownMenuItem<String>(
                                                                          value: value,
                                                                          child: new Text(value),
                                                                        );
                                                                      }).toList(),
                                                                      value: intensityTrademil,
                                                                      onChanged: (value) {
                                                                        setState(() {
                                                                          intensityTrademil = value.toString();
                                                                        });
                                                                      },
                                                                    ),

                                                                    if(_isLoad == true)
                                                                      CircularProgressIndicator()
                                                                    else
                                                                      GestureDetector(
                                                                        onTap: () {
                                                                          _trySubmitTrademill();
                                                                        },
                                                                        child: Container(
                                                                          margin: EdgeInsets.only(
                                                                              top: 20, bottom: 10, left: 10, right: 10),
                                                                          height: 43,
                                                                          child: Center(
                                                                            child: Text("SUBMIT", style: TextStyle(
                                                                                fontSize: 21 * MediaQuery
                                                                                    .of(context)
                                                                                    .textScaleFactor,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.normal
                                                                            ),),
                                                                          ),
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(20),
                                                                            color: Color(0XFF299FAB),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                                Positioned(
                                                                    right: 10,
                                                                    top: 10,
                                                                    child: GestureDetector(
                                                                        onTap: (){
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: Icon(Icons.cancel))),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                );
                                              },
                                            ));
                                    },
                                  child: Column(
                                    children: [

                                      CircleAvatar(radius: 26,
                                        backgroundColor: Colors.greenAccent,
                                        child: Icon(Icons.directions_walk,color: Colors.white,),),

                                      SizedBox(height: 10,),

                                      Text("Trademil",style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black87
                                      ),),
                                    ],
                                  ),
                                ),
                              ),

                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    return showDialog(
                                        context: context,
                                        builder: (ctx) => StatefulBuilder(
                                          builder: (BuildContext kk,StateSetter setState){
                                            return Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(7.0)
                                                ),
                                                child: Stack(
                                                  overflow: Overflow.visible,
                                                  alignment: Alignment.topCenter,
                                                  children: [
                                                    Container(
                                                      height: 310,
                                                      child: Padding(
                                                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                        child: Stack(
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text('Cycling', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                                                SizedBox(height: 25,),

                                                                SizedBox(height: 8,),

                                                                GestureDetector(
                                                                  onTap: ()async{
                                                                    resultingDuration = await showDurationPicker(
                                                                      context: context,
                                                                      initialTime: resultingDuration,
                                                                    );
                                                                    setState(() {
                                                                      resultingDuration = resultingDuration;
                                                                    });
                                                                  },
                                                                  child: Card(
                                                                    elevation: 3,
                                                                    child: Container(
                                                                      width: double.infinity,
                                                                      height: 50,
                                                                      padding: EdgeInsets.all(10),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius: BorderRadius.circular(7.0),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.grey[300],
                                                                              offset: Offset(0.0, 1.0),
                                                                              blurRadius: 6.0,
                                                                            ),
                                                                          ]
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text('Duration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                                                          Text('${resultingDuration.inMinutes} mins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                SizedBox(height: 20,),

                                                                Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text('Intensity', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),)),
                                                                new DropdownButton<String>(
                                                                  isExpanded: true,
                                                                  items: <String>['SLOW', 'MEDIUM', 'FAST'].map((String value) {
                                                                    return new DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: new Text(value,style: TextStyle(
                                                                          color: Colors.black
                                                                      ),),
                                                                    );
                                                                  }).toList(),
                                                                  value: intensityCycling,
                                                                  onChanged: (value) {
                                                                    setState(() {
                                                                      intensityCycling = value.toString();
                                                                    });
                                                                  },
                                                                ),

                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _trySubmitCycling();
                                                                  },
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: 20, bottom: 10, left: 10, right: 10),
                                                                    height: 43,
                                                                    child: Center(
                                                                      child: Text("SUBMIT", style: TextStyle(
                                                                          fontSize: 21 * MediaQuery
                                                                              .of(context)
                                                                              .textScaleFactor,
                                                                          color: Colors.white,
                                                                          fontWeight: FontWeight.normal
                                                                      ),),
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(20),
                                                                      color: Color(0XFF299FAB),
                                                                    ),
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                            Positioned(
                                                                right: 10,
                                                                top: 10,
                                                                child: GestureDetector(
                                                                    onTap: (){
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: Icon(Icons.cancel)))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            );
                                          },
                                        ));
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(radius: 26,
                                        backgroundColor: Color(0XFFFCDF9D),
                                        child: Icon(Icons.accessible_forward_rounded,color: Colors.white,),
                                      ),

                                      SizedBox(height: 10,),

                                      Text("Cycling",style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black87
                                      ),),

                                    ],
                                  ),
                                ),
                              ),

                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    return showDialog(
                                        context: context,
                                        builder: (ctx) => Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(7.0)
                                            ),
                                            child: Stack(
                                              overflow: Overflow.visible,
                                              alignment: Alignment.topCenter,
                                              children: [
                                                Container(
                                                  height: 330,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                    child: Stack(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text('Cross', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                                            SizedBox(height: 25,),
                                                            Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text('Total Level', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),)),
                                                            SizedBox(height: 8,),
                                                            TextFormField(
                                                              controller: totalLevelController,
                                                              autovalidateMode: AutovalidateMode.always,
                                                              keyboardType: TextInputType.number,
                                                              style: TextStyle(color: Color(0XFF262626)),
                                                              decoration: InputDecoration(fillColor: Color(0XFFF2F2F2), filled: true,
                                                                border: InputBorder.none,
                                                                hintText: "Level",
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
                                                            SizedBox(height: 15,),

                                                            Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text('Total Time', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),)),
                                                            SizedBox(height: 8,),

                                                            TextFormField(
                                                              controller: totalTimeController,
                                                              autovalidateMode: AutovalidateMode.always,
                                                              keyboardType: TextInputType.number,
                                                              style: TextStyle(color: Color(0XFF262626)),
                                                              decoration: InputDecoration(fillColor: Color(0XFFF2F2F2), filled: true,
                                                                border: InputBorder.none,
                                                                hintText: "Time"),
                                                              onSaved: (String value) {},
                                                            ),


                                                            if(_isLoadCross)
                                                              CircularProgressIndicator()
                                                            else
                                                            GestureDetector(
                                                              onTap: () {
                                                                _trySubmitcrossFit();
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets.only(
                                                                    top: 20, bottom: 10, left: 10, right: 10),
                                                                height: 43,
                                                                child: Center(
                                                                  child: Text("SUBMIT", style: TextStyle(
                                                                      fontSize: 21 * MediaQuery
                                                                          .of(context)
                                                                          .textScaleFactor,
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.normal
                                                                  ),),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  color: Color(0XFF299FAB),
                                                                ),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                        Positioned(
                                                            right: 10,
                                                            top: 10,
                                                            child: GestureDetector(
                                                                onTap: (){
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Icon(Icons.cancel)))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(radius: 26,
                                        backgroundColor: Colors.lightBlue,
                                        child: Icon(Icons.motorcycle_outlined,color: Colors.white,),
                                      ),

                                      SizedBox(height: 10,),

                                      Text("Cross",style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black87
                                      ),)

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),],),),

                      ListView.builder(
                        itemCount: snapshots.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          var linkedId = snapshots.data['data'][index]['exercise']['linked_id'].toString();
                          var outputs = linkedId.substring(linkedId.length - 1);
                          print("linkedId"+linkedId);
                          return snapshots.data['data'][index]['exercise']['linked_id'] == null ?
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    if(snapshots.data['data'][index]['exercise_data'] == false)
                                      Visibility(
                                          visible: false,
                                          child: Text("k"))
                                    else
                                    Text(snapshots.data['data'][index]['exercise']['exercise_name'],style: TextStyle(
                                        color: Color(0XFF2CB3BF),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),

                                    if(snapshots.data['data'][index]['exercise_data'] == false)
                                      Visibility(
                                        visible: false,
                                          child: Text("k"))
                                    else
                                    GestureDetector(
                                        onTap:(){
                                          setState(() {
                                            _showPopupMenu(snapshots.data['data'][index]['exercise']['id'],snapshots.data['data'][index]['exercise']['exercise_name']);
                                          });
                                        },child: Image.asset("assets/images/menu.png",width: 20,height: 30,color: Color(0XFF2CB3BF),)),],),),

                              if(snapshots.data['data'][index]['exercise_data'] == false)
                                Visibility(visible: false,child: Text(""))
                              else
                              if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "1")
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                child: Row(
                                  children: [
                                    Expanded(child: Center(
                                      child: Text("SET",style: TextStyle(
                                          color: Color(0XFF5F5F5F),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12
                                      ),),
                                    ),),

                                    Expanded(child: Center(
                                      child: Text("PREVIOUS",style: TextStyle(
                                          color: Color(0XFF5F5F5F),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12
                                      ),),
                                    ),),

                                    Expanded(child: Center(
                                      child: Text("REPS",style: TextStyle(
                                          color: Color(0XFF5F5F5F),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12
                                      ),),
                                    ),),

                                  ],
                                ),
                              )
                              else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "2")
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                  child: Row(
                                    children: [
                                      Expanded(child: Center(
                                        child: Text("SET",style: TextStyle(
                                            color: Color(0XFF5F5F5F),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12
                                        ),),
                                      ),),

                                      Expanded(child: Center(
                                        child: Text("PREVIOUS",style: TextStyle(
                                            color: Color(0XFF5F5F5F),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12
                                        ),),
                                      ),),

                                      Expanded(child: Center(
                                        child: Text("Weight",style: TextStyle(
                                            color: Color(0XFF5F5F5F),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12
                                        ),),
                                      ),),

                                      Expanded(child: Center(
                                        child: Text("REPS",style: TextStyle(
                                            color: Color(0XFF5F5F5F),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12
                                        ),),
                                      ),),

                                    ],
                                  ),
                                )
                              else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "3")
                                Padding(
                                    padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                    child: Row(
                                      children: [
                                        Expanded(child: Center(
                                          child: Text("SET",style: TextStyle(
                                              color: Color(0XFF5F5F5F),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12
                                          ),),
                                        ),),

                                        Expanded(child: Center(
                                          child: Text("PREVIOUS",style: TextStyle(
                                              color: Color(0XFF5F5F5F),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12
                                          ),),
                                        ),),

                                        Expanded(child: Center(
                                          child: Text("KM",style: TextStyle(
                                              color: Color(0XFF5F5F5F),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12
                                          ),),
                                        ),),
                                      ],
                                    ),
                                  )
                                else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "4")
                                  Padding(
                                      padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                      child: Row(
                                        children: [

                                          Expanded(child: Center(
                                            child: Text("SET",style: TextStyle(
                                                color: Color(0XFF5F5F5F),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12
                                            ),),
                                          ),),

                                          Expanded(child: Center(
                                            child: Text("PREVIOUS",style: TextStyle(
                                                color: Color(0XFF5F5F5F),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12
                                            ),),
                                          ),),

                                          Expanded(child: Center(
                                            child: Text("Time",style: TextStyle(
                                                color: Color(0XFF5F5F5F),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12
                                            ),),
                                          ),),

                                          // Expanded(child: Text("REPS",style: TextStyle(
                                          //     color: Color(0XFF5F5F5F),
                                          //     fontWeight: FontWeight.normal,
                                          //     fontSize: 12
                                          // ),),),

                                        ],
                                      ),
                                    )
                                  else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "5")
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                        child: Row(
                                          children: [

                                            Expanded(child: Center(
                                              child: Text("SET",style: TextStyle(
                                                  color: Color(0XFF5F5F5F),
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12
                                              ),),
                                            ),),

                                            Expanded(child: Text("PREVIOUS",style: TextStyle(
                                                color: Color(0XFF5F5F5F),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12
                                            ),),),

                                            Expanded(child: Center(
                                              child: Text("Level",style: TextStyle(
                                                  color: Color(0XFF5F5F5F),
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12
                                              ),),
                                            ),),

                                            Expanded(child: Center(
                                              child: Text("Time",style: TextStyle(
                                                  color: Color(0XFF5F5F5F),
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12
                                              ),),
                                            ),),

                                          ],
                                        ),
                                      )
                                    else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "6")
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                          child: Row(
                                            children: [
                                              Expanded(child: Center(
                                                child: Text("SET",style: TextStyle(
                                                    color: Color(0XFF5F5F5F),
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 12
                                                ),),
                                              ),),

                                              Expanded(child: Center(
                                                child: Text("PREVIOUS",style: TextStyle(
                                                    color: Color(0XFF5F5F5F),
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 12
                                                ),),
                                              ),),

                                              Expanded(child: Center(
                                                child: Text("Breath",style: TextStyle(
                                                    color: Color(0XFF5F5F5F),
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 12
                                                ),),
                                              ),),
                                            ],
                                          ),
                                        )
                                      else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "7")
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                            child: Row(
                                              children: [

                                                Expanded(child: Center(
                                                  child: Text("SET",style: TextStyle(
                                                      color: Color(0XFF5F5F5F),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),),
                                                ),),

                                                Expanded(child: Text("PREVIOUS",style: TextStyle(
                                                    color: Color(0XFF5F5F5F),
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 12
                                                ),),),

                                                Expanded(child: Center(
                                                  child: Text("Breath",style: TextStyle(
                                                      color: Color(0XFF5F5F5F),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),),
                                                ),),

                                                Expanded(child: Center(
                                                  child: Text("Reps",style: TextStyle(
                                                      color: Color(0XFF5F5F5F),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),),),),
                                              ],
                                            ),
                                          ),

                              if(snapshots.data['data'][index]['exercise_data']== false)
                                Visibility(visible: false,
                                    child: Text(""))
                              else
                              if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "1")
                                Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshots.data['data'][index]['sets'].length,
                                        itemBuilder: (context,inde){
                                          newIndex = inde + 1;
                                          return Row(
                                            children: [
                                              Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap:(){
                                                            _numberMenu();
                                                          },
                                                          child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: Color(0XFF2CB3BF),
                                                                fontWeight: FontWeight.bold
                                                            ),),
                                                        ),
                                                      ),
                                                    ],
                                                  )),

                                              Expanded(
                                                  child: Center(
                                                    child: Text("_",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Color(0XFF2CB3BF),
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                  )),

                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                    margin: EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Color(0xFFEBF0F3)
                                                    ),
                                                    child: TextFormField(
                                                      controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['reps'].toString(),
                                                      textAlign: TextAlign.center,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,),
                                                      onChanged: (value){
                                                        newTag = "reps";
                                                        Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),

                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: 1,
                                        itemBuilder: (context,index){
                                          return Row(
                                            children: [
                                              Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap:(){
                                                            _numberMenu();
                                                          },
                                                          child: Text("Select Type",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Color(0XFF2CB3BF),
                                                                fontWeight: FontWeight.bold
                                                            ),),
                                                        ),
                                                      ),
                                                    ],
                                                  )),

                                              Expanded(
                                                  child: Center(
                                                    child: Text("_",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Color(0XFF2CB3BF),
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                  )),

                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                    margin: EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: TextFormField(
                                                      controller: controllerReps,
                                                      autovalidateMode: AutovalidateMode.always,
                                                      keyboardType: TextInputType.number,
                                                      style: TextStyle(color: Color(0XFF262626)),
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                        border: InputBorder.none,
                                                        hintText: '',
                                                        filled: true,
                                                        counterText: "",
                                                        fillColor: Color(0xFFEBF0F3),
                                                        enabledBorder : OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                        errorBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                        focusedErrorBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                      ),
                                                      onSaved: (String value) {
                                                      },
                                                    ),
                                                  ),
                                                ),),

                                            ],
                                          );
                                        }),

                                    SizedBox(
                                      height: 15,),

                                    GestureDetector(
                                      onTap: ()async{
                                        setState(() {
                                          isLoadOne = true;
                                        });
                                        await Provider.of<ApiManager>(context,listen: false).addToSetApi("reps",snapshots.data['data'][index]['exercise']['id'],controllerReps.text,setType);
                                        controllerReps.clear();
                                        setState(() {
                                          isLoadOne = false;
                                        });
                                      },
                                      child: Text("ADD SET",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0XFF2CB3BF),
                                        ),),
                                    ),
                                  ],
                                )
                              else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "2")
                                Column(
                                  children: [

                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshots.data['data'][index]['sets'].length,
                                        itemBuilder: (context,inde){
                                          newIndex = inde + 1;
                                          return Row(
                                            children: [
                                              Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap:(){
                                                            _numberMenu();
                                                          },
                                                          child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: Color(0XFF2CB3BF),
                                                                fontWeight: FontWeight.bold
                                                            ),),
                                                        ),
                                                      ),
                                                    ],
                                                  )),

                                              Expanded(
                                                  child: Center(
                                                    child: Text("_",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Color(0XFF2CB3BF),
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                  )),

                                              Expanded(
                                                child: Center(
                                                  child: Container(

                                                    margin: EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Color(0xFFEBF0F3)
                                                    ),
                                                    child: TextFormField(
                                                      controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['kg'].toString(),
                                                      textAlign: TextAlign.center,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,),
                                                      onChanged: (value){
                                                        newTag = "kg";
                                                        Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                    margin: EdgeInsets.all(7),

                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Color(0xFFEBF0F3)
                                                    ),
                                                    child: TextFormField(
                                                      controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['reps'].toString(),
                                                      textAlign: TextAlign.center,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,),
                                                      onChanged: (value){
                                                        newTag = "reps";
                                                        Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          );
                                        }),

                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: 1,
                                        itemBuilder: (context,index){
                                          return Row(
                                            children: [
                                              Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap:(){
                                                            _numberMenu();
                                                          },
                                                          child: Text("Select Type",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Color(0XFF2CB3BF),
                                                                fontWeight: FontWeight.bold
                                                            ),),
                                                        ),
                                                      ),
                                                      // Positioned(
                                                      //   child: PopupMenuButton(
                                                      //     icon: Icon(
                                                      //       Icons.ac_unit_outlined,color: Colors.black87,
                                                      //     ),
                                                      //     itemBuilder: (BuildContext context){
                                                      //
                                                      //     },
                                                      //   ),
                                                      // )
                                                    ],
                                                  )),

                                              Expanded(
                                                  child: Center(
                                                    child: Text("_",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Color(0XFF2CB3BF),
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                  )),

                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                    margin: EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: TextFormField(
                                                      controller: controllerWeightThree,
                                                      autovalidateMode: AutovalidateMode.always,
                                                      keyboardType: TextInputType.number,
                                                      style: TextStyle(color: Color(0XFF262626)),
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                        border: InputBorder.none,
                                                        hintText: '',
                                                        filled: true,
                                                        counterText: "",
                                                        fillColor: Color(0xFFEBF0F3),
                                                        enabledBorder : OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                        errorBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                        focusedErrorBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                      ),
                                                      onSaved: (String value) {},
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                    margin: EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: TextFormField(
                                                      controller: controllerRepsThree,
                                                      autovalidateMode: AutovalidateMode.always,
                                                      keyboardType: TextInputType.number,
                                                      style: TextStyle(color: Color(0XFF262626)),
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                        border: InputBorder.none,
                                                        hintText: '',
                                                        filled: true,
                                                        counterText: "",
                                                        fillColor: Color(0xFFEBF0F3),
                                                        enabledBorder : OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                        errorBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                        focusedErrorBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                          borderSide: BorderSide(color: Colors.white12),
                                                        ),
                                                      ),
                                                      onSaved: (String value) {
                                                      },
                                                    ),
                                                  ),
                                                ),),
                                            ],
                                          );
                                        }),

                                    SizedBox(
                                      height: 15,
                                    ),

                                    if(isLoadTwo)
                                      CircularProgressIndicator()
                                    else
                                    GestureDetector(
                                      onTap: () async{
                                        setState(() {
                                          isLoadTwo = true;
                                        });
                                        await Provider.of<ApiManager>(context,listen: false).addToSetTwoControllerApi("weightwithreps",snapshots.data['data'][index]['exercise']['id'],controllerRepsThree.text,controllerWeightThree.text,setType);
                                        controllerWeightThree.clear();
                                        controllerRepsThree.clear();
                                        setState(() {
                                          isLoadTwo = false;
                                        });
                                      },
                                      child: Text("ADD SET",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0XFF2CB3BF),
                                        ),),
                                    ),
                                  ],
                                )
                              else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "3")
                                Column(
                                    children: [

                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshots.data['data'][index]['sets'].length,
                                          itemBuilder: (context,inde){
                                            newIndex = inde + 1;
                                            return Row(
                                              children: [
                                                Expanded(
                                                    child: Stack(
                                                      children: [
                                                        Center(
                                                          child: GestureDetector(
                                                            onTap:(){
                                                              _numberMenu();
                                                            },
                                                            child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Color(0XFF2CB3BF),
                                                                  fontWeight: FontWeight.bold
                                                              ),),
                                                          ),
                                                        ),
                                                      ],
                                                    )),

                                                Expanded(
                                                    child: Center(
                                                      child: Text("_",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Color(0XFF2CB3BF),
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                    )),

                                                Expanded(
                                                  child: Center(
                                                    child: Container(

                                                      margin: EdgeInsets.all(7),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Color(0xFFEBF0F3)
                                                      ),
                                                      child: TextFormField(
                                                        controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['km'].toString(),
                                                        textAlign: TextAlign.center,
                                                        decoration: InputDecoration(
                                                          border: InputBorder.none,),
                                                        onChanged: (value){
                                                          newTag = "km";
                                                          Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            );
                                          }),

                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: 1,
                                          itemBuilder: (context,index){
                                            return Row(
                                              children: [
                                                Expanded(
                                                    child: Stack(
                                                      children: [
                                                        Center(
                                                          child: GestureDetector(
                                                            onTap:(){
                                                              _numberMenu();
                                                            },
                                                            child: Text("Select Type",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color(0XFF2CB3BF),
                                                                  fontWeight: FontWeight.bold
                                                              ),),
                                                          ),
                                                        ),
                                                      ],
                                                    )),

                                                Expanded(
                                                    child: Center(
                                                      child: Text("_",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Color(0XFF2CB3BF),
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                    )),

                                                Expanded(
                                                  child: Center(
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10)),
                                                      child: TextFormField(
                                                        controller: controllerkm,
                                                        autovalidateMode: AutovalidateMode.always,
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(color: Color(0XFF262626)),
                                                        decoration: const InputDecoration(
                                                          contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                          border: InputBorder.none,
                                                          hintText: '',
                                                          filled: true,
                                                          counterText: "",
                                                          fillColor: Color(0xFFEBF0F3),
                                                          enabledBorder : OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                            borderSide: BorderSide(color: Colors.white12),
                                                          ),
                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                            borderSide: BorderSide(color: Colors.white12),
                                                          ),
                                                          focusedErrorBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                            borderSide: BorderSide(color: Colors.white12),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                            borderSide: BorderSide(color: Colors.white12),
                                                          ),
                                                        ),
                                                        onSaved: (String value) {
                                                        },
                                                      ),
                                                    ),
                                                  ),),

                                              ],
                                            );
                                          }),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      if(isLoadThree)
                                        CircularProgressIndicator()
                                      else
                                      GestureDetector(
                                        onTap: () async{
                                          setState(() {
                                            isLoadThree = true;
                                          });
                                          await Provider.of<ApiManager>(context,listen: false).addToSetApi("km",snapshots.data['data'][index]['exercise']['id'],controllerkm.text,setType);
                                          controllerkm.clear();
                                          setState(() {
                                            isLoadThree = false;
                                          });
                                        },
                                        child: Text("ADD SET",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF2CB3BF),
                                          ),),
                                      ),
                                    ],
                                  )
                                else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "4")

                                  Column(
                                      children: [

                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: snapshots.data['data'][index]['sets'].length,
                                            itemBuilder: (context,inde){
                                              newIndex = inde + 1;
                                              return Row(
                                                children: [
                                                  Expanded(
                                                      child: Stack(
                                                        children: [
                                                          Center(
                                                            child: GestureDetector(
                                                              onTap:(){
                                                                _numberMenu();
                                                              },
                                                              child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Color(0XFF2CB3BF),
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                            ),
                                                          ),
                                                        ],
                                                      )),

                                                  Expanded(
                                                      child: Center(
                                                        child: Text("_",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: Color(0XFF2CB3BF),
                                                              fontWeight: FontWeight.bold
                                                          ),),
                                                      )),

                                                  Expanded(
                                                    child: Center(
                                                      child: Container(

                                                        margin: EdgeInsets.all(7),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: Color(0xFFEBF0F3)
                                                        ),
                                                        child: TextFormField(
                                                          controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['time'].toString(),
                                                          textAlign: TextAlign.center,
                                                          decoration: InputDecoration(
                                                            border: InputBorder.none,),
                                                          onChanged: (value){
                                                            newTag = "time";
                                                            Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              );
                                            }),

                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: 1,
                                            itemBuilder: (context,index){
                                              return Row(
                                                children: [
                                                  Expanded(
                                                      child: Stack(
                                                        children: [
                                                          Center(
                                                            child: GestureDetector(
                                                              onTap:(){
                                                                _numberMenu();
                                                              },
                                                              child: Text("Select Type",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Color(0XFF2CB3BF),
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                            ),
                                                          ),
                                                        ],
                                                      )),

                                                  Expanded(
                                                      child: Center(
                                                        child: Text("_",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: Color(0XFF2CB3BF),
                                                              fontWeight: FontWeight.bold
                                                          ),),
                                                      )),

                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        margin: EdgeInsets.all(7),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: TextFormField(
                                                          controller: controllerTime,
                                                          autovalidateMode: AutovalidateMode.always,
                                                          keyboardType: TextInputType.number,
                                                          style: TextStyle(color: Color(0XFF262626)),
                                                          decoration: const InputDecoration(
                                                            contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                            border: InputBorder.none,
                                                            hintText: '',
                                                            filled: true,
                                                            counterText: "",
                                                            fillColor: Color(0xFFEBF0F3),
                                                            enabledBorder : OutlineInputBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                              borderSide: BorderSide(color: Colors.white12),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                              borderSide: BorderSide(color: Colors.white12),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                              borderSide: BorderSide(color: Colors.white12),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                              borderSide: BorderSide(color: Colors.white12),
                                                            ),
                                                          ),
                                                          onSaved: (String value) {
                                                          },
                                                        ),
                                                      ),
                                                    ),),

                                                ],
                                              );
                                            }),

                                        SizedBox(height: 15,),

                                        if(isLoadFour)
                                          CircularProgressIndicator()
                                        else
                                        GestureDetector(
                                          onTap: () async{
                                            setState(() {
                                              isLoadFour = true;
                                            });
                                            await Provider.of<ApiManager>(context,listen: false).addToSetApi("time",snapshots.data['data'][index]['exercise']['id'],controllerTime.text,setType);
                                            controllerTime.clear();
                                            setState(() {
                                              isLoadFour = false;
                                            });
                                          },
                                          child: Text("ADD SET",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0XFF2CB3BF),
                                            ),),
                                        ),

                                      ],
                                    )
                                  else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "5")
                                      Column(
                                        children: [

                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: snapshots.data['data'][index]['sets'].length,
                                              itemBuilder: (context,inde){
                                                newIndex = inde + 1;
                                                return Row(
                                                  children: [
                                                    Expanded(
                                                        child: Stack(
                                                          children: [
                                                            Center(
                                                              child: GestureDetector(
                                                                onTap:(){
                                                                  _numberMenu();
                                                                },
                                                                child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                  style: TextStyle(
                                                                      fontSize: 17,
                                                                      color: Color(0XFF2CB3BF),
                                                                      fontWeight: FontWeight.bold
                                                                  ),),
                                                              ),
                                                            ),
                                                          ],
                                                        )),

                                                    Expanded(
                                                        child: Center(
                                                          child: Text("_",
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: Color(0XFF2CB3BF),
                                                                fontWeight: FontWeight.bold
                                                            ),),
                                                        )),

                                                    Expanded(
                                                      child: Center(
                                                        child: Container(

                                                          margin: EdgeInsets.all(7),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                              color: Color(0xFFEBF0F3)
                                                          ),
                                                          child: TextFormField(
                                                            controller: TextEditingController()..text =  snapshots.data['data'][index]['sets'][inde]['level'].toString() ,
                                                            textAlign: TextAlign.center,
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,),
                                                            onChanged: (value){
                                                              newTag = "level";
                                                              Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    Expanded(
                                                      child: Center(
                                                        child: Container(
                                                          margin: EdgeInsets.all(7),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                              color: Color(0xFFEBF0F3)
                                                          ),
                                                          child: TextFormField(
                                                            controller: TextEditingController()..text =  snapshots.data['data'][index]['sets'][inde]['time'].toString() ,
                                                            textAlign: TextAlign.center,
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,),
                                                            onChanged: (value){
                                                              newTag = "time";
                                                              Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                );
                                              }),

                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: 1,
                                              itemBuilder: (context,index){
                                                return Row(
                                                  children: [
                                                    Expanded(
                                                        child: Stack(
                                                          children: [
                                                            Center(
                                                              child: GestureDetector(
                                                                onTap:(){
                                                                  _numberMenu();
                                                                },
                                                                child: Text("Select Type",
                                                                  style: TextStyle(
                                                                      fontSize: 13,
                                                                      color: Color(0XFF2CB3BF),
                                                                      fontWeight: FontWeight.bold
                                                                  ),),
                                                              ),
                                                            ),
                                                          ],
                                                        )),

                                                    Expanded(
                                                        child: Center(
                                                          child: Text("_",
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: Color(0XFF2CB3BF),
                                                                fontWeight: FontWeight.bold
                                                            ),),
                                                        )),

                                                    Expanded(
                                                      child: Center(
                                                        child: Container(
                                                          margin: EdgeInsets.all(7),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: TextFormField(
                                                            controller: controllerLevelFive,
                                                            autovalidateMode: AutovalidateMode.always,
                                                            keyboardType: TextInputType.number,
                                                            style: TextStyle(color: Color(0XFF262626)),
                                                            decoration: const InputDecoration(
                                                              contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                              border: InputBorder.none,
                                                              hintText: '',
                                                              filled: true,
                                                              counterText: "",
                                                              fillColor: Color(0xFFEBF0F3),
                                                              enabledBorder : OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                              errorBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                              focusedErrorBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                            ),
                                                            onSaved: (String value) {},
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    Expanded(
                                                      child: Center(
                                                        child: Container(
                                                          margin: EdgeInsets.all(7),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: TextFormField(
                                                            controller: controllerTimesFive,
                                                            autovalidateMode: AutovalidateMode.always,
                                                            keyboardType: TextInputType.number,
                                                            style: TextStyle(color: Color(0XFF262626)),
                                                            decoration: const InputDecoration(
                                                              contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                              border: InputBorder.none,
                                                              hintText: '',
                                                              filled: true,
                                                              counterText: "",
                                                              fillColor: Color(0xFFEBF0F3),
                                                              enabledBorder : OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                              errorBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                              focusedErrorBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),),

                                                  ],
                                                );
                                              }),

                                          SizedBox(height: 15,),

                                          if(isLoadFive)
                                            CircularProgressIndicator()
                                          else
                                          GestureDetector(
                                            onTap: () async{
                                              setState(() {
                                                isLoadFive = true;
                                              });
                                              await Provider.of<ApiManager>(context,listen: false).addToSetTwoControllerApi("level",snapshots.data['data'][index]['exercise']['id'],controllerLevelFive.text,controllerTimesFive.text,setType);
                                              controllerLevelFive.clear();
                                              controllerTimesFive.clear();
                                              setState(() {
                                                isLoadFive = false;
                                              });
                                            },
                                            child: Text("ADD SET",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF2CB3BF),
                                              ),),
                                          )
                                        ],
                                      )
                                    else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "6")
                                        Column(
                                          children: [
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: snapshots.data['data'][index]['sets'].length,
                                                itemBuilder: (context,inde){
                                                  newIndex = inde + 1;
                                                  return Row(
                                                    children: [
                                                      Expanded(
                                                          child: Stack(
                                                            children: [
                                                              Center(
                                                                child: GestureDetector(
                                                                  onTap:(){
                                                                    _numberMenu();
                                                                  },
                                                                  child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        color: Color(0XFF2CB3BF),
                                                                        fontWeight: FontWeight.bold
                                                                    ),),
                                                                ),
                                                              ),
                                                            ],
                                                          )),

                                                      Expanded(
                                                          child: Center(
                                                            child: Text("_",
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Color(0XFF2CB3BF),
                                                                  fontWeight: FontWeight.bold
                                                              ),),
                                                          )),

                                                      Expanded(
                                                        child: Center(
                                                          child: Container(

                                                            margin: EdgeInsets.all(7),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: Color(0xFFEBF0F3)
                                                            ),
                                                            child: TextFormField(
                                                              controller: TextEditingController()..text =  snapshots.data['data'][index]['sets'][inde]['breath'].toString() ,
                                                              textAlign: TextAlign.center,
                                                              decoration: InputDecoration(
                                                                border: InputBorder.none,),
                                                              onChanged: (value){
                                                                newTag = "breath";
                                                                Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  );
                                                }),

                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: 1,
                                                itemBuilder: (context,index){
                                                  return Row(
                                                    children: [
                                                      Expanded(
                                                          child: Stack(
                                                            children: [
                                                              Center(
                                                                child: GestureDetector(
                                                                  onTap:(){
                                                                    _numberMenu();
                                                                  },
                                                                  child: Text("1",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        color: Color(0XFF2CB3BF),
                                                                        fontWeight: FontWeight.bold
                                                                    ),),
                                                                ),
                                                              ),
                                                            ],
                                                          )),

                                                      Expanded(
                                                          child: Center(
                                                            child: Text("_",
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Color(0XFF2CB3BF),
                                                                  fontWeight: FontWeight.bold
                                                              ),),
                                                          )),

                                                      /*Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        margin: EdgeInsets.all(7),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: TextFormField(
                                                          autovalidateMode: AutovalidateMode.always,
                                                          keyboardType: TextInputType.number,
                                                          style: TextStyle(color: Color(0XFF262626)),
                                                          decoration: const InputDecoration(
                                                            contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                            border: InputBorder.none,
                                                            hintText: '',
                                                            filled: true,
                                                            counterText: "",
                                                            fillColor: Color(0xFFEBF0F3),
                                                            enabledBorder : OutlineInputBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                              borderSide: BorderSide(color: Colors.white12),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                              borderSide: BorderSide(color: Colors.white12),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                              borderSide: BorderSide(color: Colors.white12),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                              borderSide: BorderSide(color: Colors.white12),
                                                            ),
                                                          ),
                                                          onSaved: (String value) {},
                                                        ),
                                                      ),
                                                    ),
                                                  ),*/

                                                      Expanded(
                                                        child: Center(
                                                          child: Container(
                                                            margin: EdgeInsets.all(7),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: TextFormField(
                                                              controller: controllerBreath,
                                                              autovalidateMode: AutovalidateMode.always,
                                                              keyboardType: TextInputType.number,
                                                              style: TextStyle(color: Color(0XFF262626)),
                                                              decoration: const InputDecoration(
                                                                contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                border: InputBorder.none,
                                                                hintText: '',
                                                                filled: true,
                                                                counterText: "",
                                                                fillColor: Color(0xFFEBF0F3),
                                                                enabledBorder : OutlineInputBorder(
                                                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                  borderSide: BorderSide(color: Colors.white12),
                                                                ),
                                                                errorBorder: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                  borderSide: BorderSide(color: Colors.white12),
                                                                ),
                                                                focusedErrorBorder: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                  borderSide: BorderSide(color: Colors.white12),
                                                                ),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                  borderSide: BorderSide(color: Colors.white12),
                                                                ),
                                                              ),
                                                              onSaved: (String value) {
                                                              },
                                                            ),
                                                          ),
                                                        ),),

                                                      /*Expanded(
                                                    child: Icon(Icons.lock,size: 18,
                                                      color: Colors.grey,),
                                                  )*/

                                                    ],
                                                  );
                                                }),
                                            SizedBox(
                                              height: 15,
                                            ),

                                            if(isLoadSix)
                                              CircularProgressIndicator()
                                            else
                                            GestureDetector(
                                              onTap: () async{

                                                setState(() {
                                                  isLoadSix = true;});

                                                await Provider.of<ApiManager>(context,listen: false).addToSetApi("breath",snapshots.data['data'][index]['exercise']['id'],controllerBreath.text,setType);
                                                controllerBreath.clear();

                                                setState(() {
                                                  isLoadSix = false;
                                                });

                                              },
                                              child: Text("ADD SET",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0XFF2CB3BF),
                                                ),),
                                            ),

                                          ],
                                        )
                                      else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "7")
                                          Column(
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount: snapshots.data['data'][index]['sets'].length,
                                                  itemBuilder: (context,inde){
                                                    newIndex = inde + 1;
                                                    return Row(
                                                      children: [
                                                        Expanded(
                                                            child: Stack(
                                                              children: [
                                                                Center(
                                                                  child: GestureDetector(
                                                                    onTap:(){
                                                                      _numberMenu();
                                                                    },
                                                                    child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                      style: TextStyle(
                                                                          fontSize: 17,
                                                                          color: Color(0XFF2CB3BF),
                                                                          fontWeight: FontWeight.bold
                                                                      ),),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),

                                                        Expanded(
                                                            child: Center(
                                                              child: Text("_",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Color(0XFF2CB3BF),
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                            )),

                                                        Expanded(
                                                          child: Center(
                                                            child: Container(
                                                              margin: EdgeInsets.all(7),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: Color(0xFFEBF0F3)
                                                              ),
                                                              child: TextFormField(
                                                                controller: TextEditingController()..text =  snapshots.data['data'][index]['sets'][inde]['breath'].toString() ,
                                                                textAlign: TextAlign.center,
                                                                decoration: InputDecoration(
                                                                  border: InputBorder.none,),
                                                                onChanged: (value){
                                                                  newTag = "breath";
                                                                  Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Expanded(
                                                          child: Center(
                                                            child: Container(
                                                              margin: EdgeInsets.all(7),

                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: Color(0xFFEBF0F3)
                                                              ),
                                                              child: TextFormField(
                                                                controller: TextEditingController()..text =  snapshots.data['data'][index]['sets'][inde]['reps'].toString() ,
                                                                textAlign: TextAlign.center,
                                                                decoration: InputDecoration(
                                                                  border: InputBorder.none,),
                                                                onChanged: (value){
                                                                  newTag = "reps";
                                                                  Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    );
                                                  }),

                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount: 1,
                                                  itemBuilder: (context,index){
                                                    return Row(
                                                      children: [
                                                        Expanded(
                                                            child: Stack(
                                                              children: [
                                                                Center(
                                                                  child: GestureDetector(
                                                                    onTap:(){
                                                                      _numberMenu();
                                                                    },
                                                                    child: Text("Select Type",
                                                                      style: TextStyle(
                                                                          fontSize: 13,
                                                                          color: Color(0XFF2CB3BF),
                                                                          fontWeight: FontWeight.bold
                                                                      ),),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),

                                                        Expanded(
                                                            child: Center(
                                                              child: Text("_",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Color(0XFF2CB3BF),
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                            )),

                                                        Expanded(
                                                          child: Center(
                                                            child: Container(
                                                              margin: EdgeInsets.all(7),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: TextFormField(
                                                                controller: controllerbreathSeven,
                                                                autovalidateMode: AutovalidateMode.always,
                                                                keyboardType: TextInputType.number,
                                                                style: TextStyle(color: Color(0XFF262626)),
                                                                decoration: const InputDecoration(
                                                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                  border: InputBorder.none,
                                                                  hintText: '',
                                                                  filled: true,
                                                                  counterText: "",
                                                                  fillColor: Color(0xFFEBF0F3),
                                                                  enabledBorder : OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  errorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                ),
                                                                onSaved: (String value) {},
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Expanded(
                                                          child: Center(
                                                            child: Container(
                                                              margin: EdgeInsets.all(7),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: TextFormField(
                                                                controller: controllerRepsSeven,
                                                                keyboardType: TextInputType.number,
                                                                style: TextStyle(color: Color(0XFF262626)),
                                                                decoration: const InputDecoration(
                                                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                  border: InputBorder.none,
                                                                  hintText: '',
                                                                  filled: true,
                                                                  counterText: "",
                                                                  fillColor: Color(0xFFEBF0F3),
                                                                  enabledBorder : OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  errorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                ),
                                                                onSaved: (String value) {
                                                                },
                                                              ),
                                                            ),
                                                          ),),

                                                        /*Expanded(
                                                      child: Icon(Icons.lock,size: 18,
                                                        color: Colors.grey,),
                                                    )*/

                                                      ],
                                                    );
                                                  }),

                                              SizedBox(
                                                height: 15,),

                                              GestureDetector(
                                                onTap: () async{
                                                  setState(() {
                                                    isLoadSeven = true;
                                                  });
                                                  await Provider.of<ApiManager>(context,listen: false).addToSetTwoControllerApi("breathwithreps",snapshots.data['data'][index]['exercise']['id'],controllerRepsSeven.text,controllerbreathSeven.text,setType);
                                                  controllerbreathSeven.clear();
                                                  controllerRepsSeven.clear();
                                                  setState(() {
                                                    isLoadSeven = false;
                                                  });
                                                },
                                                child: Text("ADD SET",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0XFF2CB3BF),
                                                  ),),
                                              ),
                                            ],
                                          ),
                            ],
                          ):
                          Stack(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshots.data['data'][index]['exercise']['exercise_name'],style: TextStyle(
                                                  color: Color(0XFF2CB3BF),
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14
                                              ),),

                                              GestureDetector(
                                                  onTap:(){
                                                    setState(() {
                                                      _showPopupMenu(snapshots.data['data'][index]['exercise']['id'],snapshots.data['data'][index]['exercise']['exercise_name']);
                                                    });
                                                  },child: Image.asset("assets/images/menu.png",width: 20,height: 30,color: Color(0XFF2CB3BF),)),
                                            ],
                                          ),),
                                        if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "1")
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                            child: Row(
                                              children: [
                                                Expanded(child: Center(
                                                  child: Text("SET",style: TextStyle(
                                                      color: Color(0XFF5F5F5F),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),),
                                                ),),
                                                Expanded(child: Center(
                                                  child: Text("PREVIOUS",style: TextStyle(
                                                      color: Color(0XFF5F5F5F),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),),
                                                ),),

                                                Expanded(child: Center(
                                                  child: Text("REPS",style: TextStyle(
                                                      color: Color(0XFF5F5F5F),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),),
                                                ),),

                                              ],
                                            ),
                                          )
                                        else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "2")
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                            child: Row(
                                              children: [
                                                Expanded(child: Center(
                                                  child: Text("SET",style: TextStyle(
                                                      color: Color(0XFF5F5F5F),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),),
                                                ),),

                                                Expanded(child: Center(
                                                  child: Text("PREVIOUS",style: TextStyle(
                                                      color: Color(0XFF5F5F5F),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),),
                                                ),),

                                                Expanded(child: Center(
                                                  child: Text("Weight",style: TextStyle(
                                                      color: Color(0XFF5F5F5F),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),),
                                                ),),

                                                Expanded(child: Center(
                                                  child: Text("REPS",style: TextStyle(
                                                      color: Color(0XFF5F5F5F),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),),
                                                ),),

                                              ],
                                            ),
                                          )
                                        else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "3")
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                              child: Row(
                                                children: [
                                                  Expanded(child: Center(
                                                    child: Text("SET",style: TextStyle(
                                                        color: Color(0XFF5F5F5F),
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 12
                                                    ),),
                                                  ),),

                                                  Expanded(child: Center(
                                                    child: Text("PREVIOUS",style: TextStyle(
                                                        color: Color(0XFF5F5F5F),
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 12
                                                    ),),
                                                  ),),

                                                  Expanded(child: Center(
                                                    child: Text("KM",style: TextStyle(
                                                        color: Color(0XFF5F5F5F),
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 12
                                                    ),),
                                                  ),),
                                                ],
                                              ),
                                            )
                                          else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "4")
                                              Padding(
                                                padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                                child: Row(
                                                  children: [
                                                    Expanded(child: Center(
                                                      child: Text("SET",style: TextStyle(
                                                          color: Color(0XFF5F5F5F),
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 12
                                                      ),),
                                                    ),),

                                                    Expanded(child: Center(
                                                      child: Text("PREVIOUS",style: TextStyle(
                                                          color: Color(0XFF5F5F5F),
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 12
                                                      ),),
                                                    ),),

                                                    Expanded(child: Center(
                                                      child: Text("Time",style: TextStyle(
                                                          color: Color(0XFF5F5F5F),
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 12
                                                      ),),
                                                    ),),

                                                    // Expanded(child: Text("REPS",style: TextStyle(
                                                    //     color: Color(0XFF5F5F5F),
                                                    //     fontWeight: FontWeight.normal,
                                                    //     fontSize: 12
                                                    // ),),),

                                                  ],
                                                ),
                                              )
                                            else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "5")
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                                  child: Row(
                                                    children: [

                                                      Expanded(child: Center(
                                                        child: Text("SET",style: TextStyle(
                                                            color: Color(0XFF5F5F5F),
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 12
                                                        ),),
                                                      ),),

                                                      Expanded(child: Text("PREVIOUS",style: TextStyle(
                                                          color: Color(0XFF5F5F5F),
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 12
                                                      ),),),

                                                      Expanded(child: Center(
                                                        child: Text("Level",style: TextStyle(
                                                            color: Color(0XFF5F5F5F),
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 12
                                                        ),),
                                                      ),),

                                                      Expanded(child: Center(
                                                        child: Text("Time",style: TextStyle(
                                                            color: Color(0XFF5F5F5F),
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 12
                                                        ),),
                                                      ),),

                                                    ],
                                                  ),
                                                )
                                              else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "6")
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                                    child: Row(
                                                      children: [

                                                        Expanded(child: Center(
                                                          child: Text("SET",style: TextStyle(
                                                              color: Color(0XFF5F5F5F),
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 12
                                                          ),),
                                                        ),),

                                                        Expanded(child: Center(
                                                          child: Text("PREVIOUS",style: TextStyle(
                                                              color: Color(0XFF5F5F5F),
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 12
                                                          ),),
                                                        ),),

                                                        Expanded(child: Center(
                                                          child: Text("Breath",style: TextStyle(
                                                              color: Color(0XFF5F5F5F),
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 12
                                                          ),),
                                                        ),),
                                                      ],
                                                    ),
                                                  )
                                                else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "7")
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                                                      child: Row(
                                                        children: [

                                                          Expanded(child: Center(
                                                            child: Text("SET",style: TextStyle(
                                                                color: Color(0XFF5F5F5F),
                                                                fontWeight: FontWeight.normal,
                                                                fontSize: 12
                                                            ),),
                                                          ),),

                                                          Expanded(child: Text("PREVIOUS",style: TextStyle(
                                                              color: Color(0XFF5F5F5F),
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 12
                                                          ),),),

                                                          Expanded(child: Center(
                                                            child: Text("Breath",style: TextStyle(
                                                                color: Color(0XFF5F5F5F),
                                                                fontWeight: FontWeight.normal,
                                                                fontSize: 12
                                                            ),),
                                                          ),),

                                                          Expanded(child: Center(
                                                            child: Text("Reps",style: TextStyle(
                                                                color: Color(0XFF5F5F5F),
                                                                fontWeight: FontWeight.normal,
                                                                fontSize: 12
                                                            ),),),),
                                                        ],
                                                      ),
                                                    ),

                                        if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "1")
                                          Column(
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount: snapshots.data['data'][index]['sets'].length,
                                                  itemBuilder: (context,inde){
                                                    newIndex = inde + 1;
                                                    return Row(
                                                      children: [
                                                        Expanded(
                                                            child: Stack(
                                                              children: [
                                                                Center(
                                                                  child: GestureDetector(
                                                                    onTap:(){
                                                                      _numberMenu();},
                                                                    child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                      style: TextStyle(
                                                                          fontSize: 17,
                                                                          color: Color(0XFF2CB3BF),
                                                                          fontWeight: FontWeight.bold
                                                                      ),),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),

                                                        Expanded(
                                                            child: Center(
                                                              child: Text("_",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Color(0XFF2CB3BF),
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                            )),

                                                        Expanded(
                                                          child: Center(
                                                            child: Container(
                                                              margin: EdgeInsets.all(7),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: Color(0xFFEBF0F3)
                                                              ),
                                                              child: TextFormField(
                                                                controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['reps'].toString(),
                                                                textAlign: TextAlign.center,
                                                                decoration: InputDecoration(
                                                                  border: InputBorder.none,),
                                                                onChanged: (value){
                                                                  newTag = "reps";
                                                                  Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),

                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount: 1,
                                                  itemBuilder: (context,index){
                                                    return Row(
                                                      children: [
                                                        Expanded(
                                                            child: Stack(
                                                              children: [
                                                                Center(
                                                                  child: GestureDetector(
                                                                    onTap:(){
                                                                      _numberMenu();
                                                                    },
                                                                    child: Text("Select Type",
                                                                      style: TextStyle(
                                                                          fontSize: 13,
                                                                          color: Color(0XFF2CB3BF),
                                                                          fontWeight: FontWeight.bold
                                                                      ),),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),

                                                        Expanded(
                                                            child: Center(
                                                              child: Text("_",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Color(0XFF2CB3BF),
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                            )),

                                                        Expanded(
                                                          child: Center(
                                                            child: Container(
                                                              margin: EdgeInsets.all(7),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: TextFormField(
                                                                controller: controllerReps,
                                                                autovalidateMode: AutovalidateMode.always,
                                                                keyboardType: TextInputType.number,
                                                                style: TextStyle(color: Color(0XFF262626)),
                                                                decoration: const InputDecoration(
                                                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                  border: InputBorder.none,
                                                                  hintText: '',
                                                                  filled: true,
                                                                  counterText: "",
                                                                  fillColor: Color(0xFFEBF0F3),
                                                                  enabledBorder : OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  errorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                ),
                                                                onSaved: (String value) {
                                                                },
                                                              ),
                                                            ),
                                                          ),),

                                                      ],
                                                    );
                                                  }),

                                              SizedBox(
                                                height: 15,),

                                              GestureDetector(
                                                onTap: ()async{
                                                  setState(() {
                                                    isLoadOne = true;
                                                  });
                                                  await Provider.of<ApiManager>(context,listen: false).addToSetApi("reps",snapshots.data['data'][index]['exercise']['id'],controllerReps.text,setType);
                                                  controllerReps.clear();
                                                  setState(() {
                                                    isLoadOne = false;
                                                  });
                                                },
                                                child: Text("ADD SET",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0XFF2CB3BF),
                                                  ),),
                                              ),
                                            ],
                                          )
                                        else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "2")
                                          Column(
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount: snapshots.data['data'][index]['sets'].length,
                                                  itemBuilder: (context,inde){
                                                    newIndex = inde + 1;
                                                    return Row(
                                                      children: [
                                                        Expanded(
                                                            child: Stack(
                                                              children: [
                                                                Center(
                                                                  child: GestureDetector(
                                                                    onTap:(){
                                                                      _numberMenu();
                                                                    },
                                                                    child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                      style: TextStyle(
                                                                          fontSize: 17,
                                                                          color: Color(0XFF2CB3BF),
                                                                          fontWeight: FontWeight.bold
                                                                      ),),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),

                                                        Expanded(
                                                            child: Center(
                                                              child: Text("_",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Color(0XFF2CB3BF),
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                            )),

                                                        Expanded(
                                                          child: Center(
                                                            child: Container(

                                                              margin: EdgeInsets.all(7),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: Color(0xFFEBF0F3)
                                                              ),
                                                              child: TextFormField(
                                                                controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['kg'].toString(),
                                                                textAlign: TextAlign.center,
                                                                decoration: InputDecoration(
                                                                  border: InputBorder.none,),
                                                                onChanged: (value){
                                                                  newTag = "kg";
                                                                  Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Expanded(
                                                          child: Center(
                                                            child: Container(

                                                              margin: EdgeInsets.all(7),

                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: Color(0xFFEBF0F3)
                                                              ),
                                                              child: TextFormField(
                                                                controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['reps'].toString(),
                                                                textAlign: TextAlign.center,
                                                                decoration: InputDecoration(
                                                                  border: InputBorder.none,),
                                                                onChanged: (value){
                                                                  newTag = "reps";
                                                                  Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    );
                                                  }),

                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount: 1,
                                                  itemBuilder: (context,index){
                                                    return Row(
                                                      children: [
                                                        Expanded(
                                                            child: Stack(
                                                              children: [
                                                                Center(
                                                                  child: GestureDetector(
                                                                    onTap:(){
                                                                      _numberMenu();
                                                                    },
                                                                    child: Text("Select Type",
                                                                      style: TextStyle(
                                                                          fontSize: 13,
                                                                          color: Color(0XFF2CB3BF),
                                                                          fontWeight: FontWeight.bold
                                                                      ),),
                                                                  ),
                                                                ),
                                                                // Positioned(
                                                                //   child: PopupMenuButton(
                                                                //     icon: Icon(
                                                                //       Icons.ac_unit_outlined,color: Colors.black87,
                                                                //     ),
                                                                //     itemBuilder: (BuildContext context){
                                                                //
                                                                //     },
                                                                //   ),
                                                                // )
                                                              ],
                                                            )),

                                                        Expanded(
                                                            child: Center(
                                                              child: Text("_",
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Color(0XFF2CB3BF),
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                            )),

                                                        Expanded(
                                                          child: Center(
                                                            child: Container(
                                                              margin: EdgeInsets.all(7),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: TextFormField(
                                                                controller: controllerWeightThree,
                                                                autovalidateMode: AutovalidateMode.always,
                                                                keyboardType: TextInputType.number,
                                                                style: TextStyle(color: Color(0XFF262626)),
                                                                decoration: const InputDecoration(
                                                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                  border: InputBorder.none,
                                                                  hintText: '',
                                                                  filled: true,
                                                                  counterText: "",
                                                                  fillColor: Color(0xFFEBF0F3),
                                                                  enabledBorder : OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  errorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                ),
                                                                onSaved: (String value) {},
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Expanded(
                                                          child: Center(
                                                            child: Container(
                                                              margin: EdgeInsets.all(7),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: TextFormField(
                                                                controller: controllerRepsThree,
                                                                autovalidateMode: AutovalidateMode.always,
                                                                keyboardType: TextInputType.number,
                                                                style: TextStyle(color: Color(0XFF262626)),
                                                                decoration: const InputDecoration(
                                                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                  border: InputBorder.none,
                                                                  hintText: '',
                                                                  filled: true,
                                                                  counterText: "",
                                                                  fillColor: Color(0xFFEBF0F3),
                                                                  enabledBorder : OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  errorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                    borderSide: BorderSide(color: Colors.white12),
                                                                  ),
                                                                ),
                                                                onSaved: (String value) {
                                                                },
                                                              ),
                                                            ),
                                                          ),),
                                                      ],
                                                    );
                                                  }),

                                              SizedBox(
                                                height: 15,
                                              ),

                                              if(isLoadTwo)
                                                CircularProgressIndicator()
                                              else
                                                GestureDetector(
                                                  onTap: () async{
                                                    setState(() {
                                                      isLoadTwo = true;
                                                    });
                                                    await Provider.of<ApiManager>(context,listen: false).addToSetTwoControllerApi("weightwithreps",snapshots.data['data'][index]['exercise']['id'],controllerRepsThree.text,controllerWeightThree.text,setType);
                                                    controllerWeightThree.clear();
                                                    controllerRepsThree.clear();
                                                    setState(() {
                                                      isLoadTwo = false;
                                                    });
                                                  },
                                                  child: Text("ADD SET",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0XFF2CB3BF),
                                                    ),),
                                                ),
                                            ],
                                          )
                                        else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "3")
                                            Column(
                                              children: [

                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount: snapshots.data['data'][index]['sets'].length,
                                                    itemBuilder: (context,inde){
                                                      newIndex = inde + 1;
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                              child: Stack(
                                                                children: [
                                                                  Center(
                                                                    child: GestureDetector(
                                                                      onTap:(){
                                                                        _numberMenu();
                                                                      },
                                                                      child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                        style: TextStyle(
                                                                            fontSize: 17,
                                                                            color: Color(0XFF2CB3BF),
                                                                            fontWeight: FontWeight.bold
                                                                        ),),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),

                                                          Expanded(
                                                              child: Center(
                                                                child: Text("_",
                                                                  style: TextStyle(
                                                                      fontSize: 17,
                                                                      color: Color(0XFF2CB3BF),
                                                                      fontWeight: FontWeight.bold
                                                                  ),),
                                                              )),

                                                          Expanded(
                                                            child: Center(
                                                              child: Container(

                                                                margin: EdgeInsets.all(7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    color: Color(0xFFEBF0F3)
                                                                ),
                                                                child: TextFormField(
                                                                  controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['km'].toString(),
                                                                  textAlign: TextAlign.center,
                                                                  decoration: InputDecoration(
                                                                    border: InputBorder.none,),
                                                                  onChanged: (value){
                                                                    newTag = "km";
                                                                    Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      );
                                                    }),

                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount: 1,
                                                    itemBuilder: (context,index){
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                              child: Stack(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 40,
                                                                    child: DropdownSearch(
                                                                      popupShape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(20)
                                                                      ),
                                                                      mode: Mode.MENU,
                                                                      showSelectedItem: false,
                                                                      // popupElevation: 5,
                                                                      dropdownSearchDecoration: const InputDecoration(
                                                                        hintText: "Set Type",
                                                                        // counterText: setTypeSelect,
                                                                        helperStyle:  TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 10
                                                                        ),
                                                                        hintStyle: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 10
                                                                        ),
                                                                        contentPadding: EdgeInsets.fromLTRB(1, 12, 0, 0),
                                                                        border: OutlineInputBorder(),
                                                                      ),
                                                                      showSearchBox:false,

                                                                      onFind: (String filter) async{
                                                                        return ['NORMAL','WARMUP','DROP','FAILURE'];},
                                                                      onChanged: (String data) {
                                                                        print(data);
                                                                        // setState(() {
                                                                        setTypeSelect = data.toString();
                                                                        // });
                                                                      },
                                                                      itemAsString: (String da) => da,
                                                                    ),
                                                                  )
                                                                ],
                                                              )),

                                                          Expanded(
                                                              child: Center(
                                                                child: Text("_",
                                                                  style: TextStyle(
                                                                      fontSize: 17,
                                                                      color: Color(0XFF2CB3BF),
                                                                      fontWeight: FontWeight.bold
                                                                  ),),
                                                              )),

                                                          Expanded(
                                                            child: Center(
                                                              child: Container(
                                                                margin: EdgeInsets.all(7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10)),
                                                                child: TextFormField(
                                                                  controller: controllerkm,
                                                                  autovalidateMode: AutovalidateMode.always,
                                                                  keyboardType: TextInputType.number,
                                                                  style: TextStyle(color: Color(0XFF262626)),
                                                                  decoration: const InputDecoration(
                                                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                    border: InputBorder.none,
                                                                    hintText: '',
                                                                    filled: true,
                                                                    counterText: "",
                                                                    fillColor: Color(0xFFEBF0F3),
                                                                    enabledBorder : OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    errorBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                  ),
                                                                  onSaved: (String value) {
                                                                  },
                                                                ),
                                                              ),
                                                            ),),

                                                        ],
                                                      );
                                                    }),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                if(isLoadThree)
                                                  CircularProgressIndicator()
                                                else
                                                  GestureDetector(
                                                    onTap: () async{
                                                      setState(() {
                                                        isLoadThree = true;
                                                      });
                                                      await Provider.of<ApiManager>(context,listen: false).addToSetApi("km",snapshots.data['data'][index]['exercise']['id'],controllerkm.text,setType);
                                                      controllerkm.clear();
                                                      setState(() {
                                                        isLoadThree = false;
                                                      });
                                                    },
                                                    child: Text("ADD SET",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0XFF2CB3BF),
                                                      ),),
                                                  ),
                                              ],
                                            )
                                          else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "4")
                                              Column(
                                                children: [

                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemCount: snapshots.data['data'][index]['sets'].length,
                                                      itemBuilder: (context,inde){
                                                        newIndex = inde + 1;
                                                        return Row(
                                                          children: [
                                                            Expanded(
                                                                child: Stack(
                                                                  children: [
                                                                    Center(
                                                                      child: GestureDetector(
                                                                        onTap:(){
                                                                          _numberMenu();
                                                                        },
                                                                        child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: Color(0XFF2CB3BF),
                                                                              fontWeight: FontWeight.bold
                                                                          ),),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),

                                                            Expanded(
                                                                child: Center(
                                                                  child: Text("_",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        color: Color(0XFF2CB3BF),
                                                                        fontWeight: FontWeight.bold
                                                                    ),),
                                                                )),

                                                            Expanded(
                                                              child: Center(
                                                                child: Container(

                                                                  margin: EdgeInsets.all(7),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      color: Color(0xFFEBF0F3)
                                                                  ),
                                                                  child: TextFormField(
                                                                    controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['time'].toString(),
                                                                    textAlign: TextAlign.center,
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder.none,),
                                                                    onChanged: (value){
                                                                      newTag = "time";
                                                                      Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                          ],
                                                        );
                                                      }),

                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemCount: 1,
                                                      itemBuilder: (context,index){
                                                        return Row(
                                                          children: [
                                                            Expanded(
                                                                child: Stack(
                                                                  children: [
                                                                    Center(
                                                                      child: GestureDetector(
                                                                        onTap:(){
                                                                          _numberMenu();
                                                                        },
                                                                        child: Text("1",
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: Color(0XFF2CB3BF),
                                                                              fontWeight: FontWeight.bold
                                                                          ),),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),

                                                            Expanded(
                                                                child: Center(
                                                                  child: Text("_",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        color: Color(0XFF2CB3BF),
                                                                        fontWeight: FontWeight.bold
                                                                    ),),
                                                                )),

                                                            Expanded(
                                                              child: Center(
                                                                child: Container(
                                                                  margin: EdgeInsets.all(7),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                  child: TextFormField(
                                                                    controller: controllerTime,
                                                                    autovalidateMode: AutovalidateMode.always,
                                                                    keyboardType: TextInputType.number,
                                                                    style: TextStyle(color: Color(0XFF262626)),
                                                                    decoration: const InputDecoration(
                                                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                      border: InputBorder.none,
                                                                      hintText: '',
                                                                      filled: true,
                                                                      counterText: "",
                                                                      fillColor: Color(0xFFEBF0F3),
                                                                      enabledBorder : OutlineInputBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                        borderSide: BorderSide(color: Colors.white12),
                                                                      ),
                                                                      errorBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                        borderSide: BorderSide(color: Colors.white12),
                                                                      ),
                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                        borderSide: BorderSide(color: Colors.white12),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                        borderSide: BorderSide(color: Colors.white12),
                                                                      ),
                                                                    ),
                                                                    onSaved: (String value) {
                                                                    },
                                                                  ),
                                                                ),
                                                              ),),

                                                          ],
                                                        );
                                                      }),

                                                  SizedBox(height: 15,),

                                                  if(isLoadFour)
                                                    CircularProgressIndicator()
                                                  else
                                                    GestureDetector(
                                                      onTap: () async{
                                                        setState(() {
                                                          isLoadFour = true;
                                                        });
                                                        await Provider.of<ApiManager>(context,listen: false).addToSetApi("time",snapshots.data['data'][index]['exercise']['id'],controllerTime.text,setType);
                                                        controllerTime.clear();
                                                        setState(() {
                                                          isLoadFour = false;
                                                        });
                                                      },
                                                      child: Text("ADD SET",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w600,
                                                          color: Color(0XFF2CB3BF),
                                                        ),),
                                                    ),

                                                ],
                                              )
                                            else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "5")
                                                Column(
                                                  children: [
                                                    ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: snapshots.data['data'][index]['sets'].length,
                                                        itemBuilder: (context,inde){
                                                          newIndex = inde + 1;
                                                          return Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Stack(
                                                                    children: [
                                                                      Center(
                                                                        child: GestureDetector(
                                                                          onTap:(){
                                                                            _numberMenu();
                                                                          },
                                                                          child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                            style: TextStyle(
                                                                                fontSize: 17,
                                                                                color: Color(0XFF2CB3BF),
                                                                                fontWeight: FontWeight.bold
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),

                                                              Expanded(
                                                                  child: Center(
                                                                    child: Text("_",
                                                                      style: TextStyle(
                                                                          fontSize: 17,
                                                                          color: Color(0XFF2CB3BF),
                                                                          fontWeight: FontWeight.bold
                                                                      ),),
                                                                  )),

                                                              Expanded(
                                                                child: Center(
                                                                  child: Container(

                                                                    margin: EdgeInsets.all(7),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        color: Color(0xFFEBF0F3)
                                                                    ),
                                                                    child: TextFormField(
                                                                      controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['level'].toString(),
                                                                      textAlign: TextAlign.center,
                                                                      decoration: InputDecoration(
                                                                        border: InputBorder.none,),
                                                                      onChanged: (value){
                                                                        newTag = "level";
                                                                        Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              Expanded(
                                                                child: Center(
                                                                  child: Container(

                                                                    margin: EdgeInsets.all(7),

                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        color: Color(0xFFEBF0F3)
                                                                    ),
                                                                    child: TextFormField(
                                                                      controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['time'].toString(),
                                                                      textAlign: TextAlign.center,
                                                                      decoration: InputDecoration(
                                                                        border: InputBorder.none,),
                                                                      onChanged: (value){
                                                                        newTag = "time";
                                                                        Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                            ],
                                                          );
                                                        }),

                                                    ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: 1,
                                                        itemBuilder: (context,index){
                                                          return Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Stack(
                                                                    children: [
                                                                      Center(
                                                                        child: GestureDetector(
                                                                          onTap:(){
                                                                            _numberMenu();
                                                                          },
                                                                          child: Text("Select Type",
                                                                            style: TextStyle(
                                                                                fontSize: 13,
                                                                                color: Color(0XFF2CB3BF),
                                                                                fontWeight: FontWeight.bold
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),

                                                              Expanded(
                                                                  child: Center(
                                                                    child: Text("_",
                                                                      style: TextStyle(
                                                                          fontSize: 17,
                                                                          color: Color(0XFF2CB3BF),
                                                                          fontWeight: FontWeight.bold
                                                                      ),),
                                                                  )),

                                                              Expanded(
                                                                child: Center(
                                                                  child: Container(
                                                                    margin: EdgeInsets.all(7),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10)
                                                                    ),
                                                                    child: TextFormField(
                                                                      controller: controllerLevelFive,
                                                                      autovalidateMode: AutovalidateMode.always,
                                                                      keyboardType: TextInputType.number,
                                                                      style: TextStyle(color: Color(0XFF262626)),
                                                                      decoration: const InputDecoration(
                                                                        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                        border: InputBorder.none,
                                                                        hintText: '',
                                                                        filled: true,
                                                                        counterText: "",
                                                                        fillColor: Color(0xFFEBF0F3),
                                                                        enabledBorder : OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                        errorBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                        focusedErrorBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                      ),
                                                                      onSaved: (String value) {},
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              Expanded(
                                                                child: Center(
                                                                  child: Container(
                                                                    margin: EdgeInsets.all(7),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10)
                                                                    ),
                                                                    child: TextFormField(
                                                                      controller: controllerTimesFive,
                                                                      autovalidateMode: AutovalidateMode.always,
                                                                      keyboardType: TextInputType.number,
                                                                      style: TextStyle(color: Color(0XFF262626)),
                                                                      decoration: const InputDecoration(
                                                                        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                        border: InputBorder.none,
                                                                        hintText: '',
                                                                        filled: true,
                                                                        counterText: "",
                                                                        fillColor: Color(0xFFEBF0F3),
                                                                        enabledBorder : OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                        errorBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                        focusedErrorBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),),

                                                            ],
                                                          );
                                                        }),

                                                    SizedBox(height: 15,),

                                                    if(isLoadFive)
                                                      CircularProgressIndicator()
                                                    else
                                                      GestureDetector(
                                                        onTap: () async{
                                                          setState(() {
                                                            isLoadFive = true;
                                                          });
                                                          await Provider.of<ApiManager>(context,listen: false).addToSetTwoControllerApi("level",snapshots.data['data'][index]['exercise']['id'],controllerLevelFive.text,controllerTimesFive.text,setType);
                                                          controllerLevelFive.clear();
                                                          controllerTimesFive.clear();
                                                          setState(() {
                                                            isLoadFive = false;
                                                          });
                                                        },
                                                        child: Text("ADD SET",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(0XFF2CB3BF),
                                                          ),),
                                                      )
                                                  ],
                                                )
                                              else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "6")
                                                  Column(
                                                    children: [
                                                      ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemCount: snapshots.data['data'][index]['sets'].length,
                                                          itemBuilder: (context,inde){
                                                            newIndex = inde + 1;
                                                            return Row(
                                                              children: [
                                                                Expanded(
                                                                    child: Stack(
                                                                      children: [
                                                                        Center(
                                                                          child: GestureDetector(
                                                                            onTap:(){
                                                                              _numberMenu();
                                                                            },
                                                                            child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                              style: TextStyle(
                                                                                  fontSize: 17,
                                                                                  color: Color(0XFF2CB3BF),
                                                                                  fontWeight: FontWeight.bold
                                                                              ),),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )),

                                                                Expanded(
                                                                    child: Center(
                                                                      child: Text("_",
                                                                        style: TextStyle(
                                                                            fontSize: 17,
                                                                            color: Color(0XFF2CB3BF),
                                                                            fontWeight: FontWeight.bold
                                                                        ),),
                                                                    )),

                                                                Expanded(
                                                                  child: Center(
                                                                    child: Container(

                                                                      margin: EdgeInsets.all(7),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          color: Color(0xFFEBF0F3)
                                                                      ),
                                                                      child: TextFormField(
                                                                        controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['breath'].toString(),
                                                                        textAlign: TextAlign.center,
                                                                        decoration: InputDecoration(
                                                                          border: InputBorder.none,),
                                                                        onChanged: (value){
                                                                          newTag = "breath";
                                                                          Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                              ],
                                                            );
                                                          }),

                                                      ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemCount: 1,
                                                          itemBuilder: (context,index){
                                                            return Row(
                                                              children: [
                                                                Expanded(
                                                                    child: Stack(
                                                                      children: [
                                                                        Center(
                                                                          child: GestureDetector(
                                                                            onTap:(){
                                                                              _numberMenu();
                                                                            },
                                                                            child: Text("1",
                                                                              style: TextStyle(
                                                                                  fontSize: 17,
                                                                                  color: Color(0XFF2CB3BF),
                                                                                  fontWeight: FontWeight.bold
                                                                              ),),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )),

                                                                Expanded(
                                                                    child: Center(
                                                                      child: Text("_",
                                                                        style: TextStyle(
                                                                            fontSize: 17,
                                                                            color: Color(0XFF2CB3BF),
                                                                            fontWeight: FontWeight.bold
                                                                        ),),
                                                                    )),

                                                                /*Expanded(
                                                      child: Center(
                                                        child: Container(
                                                          margin: EdgeInsets.all(7),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: TextFormField(
                                                            autovalidateMode: AutovalidateMode.always,
                                                            keyboardType: TextInputType.number,
                                                            style: TextStyle(color: Color(0XFF262626)),
                                                            decoration: const InputDecoration(
                                                              contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                              border: InputBorder.none,
                                                              hintText: '',
                                                              filled: true,
                                                              counterText: "",
                                                              fillColor: Color(0xFFEBF0F3),
                                                              enabledBorder : OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                              errorBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                              focusedErrorBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                borderSide: BorderSide(color: Colors.white12),
                                                              ),
                                                            ),
                                                            onSaved: (String value) {},
                                                          ),
                                                        ),
                                                      ),
                                                    ),*/

                                                                Expanded(
                                                                  child: Center(
                                                                    child: Container(
                                                                      margin: EdgeInsets.all(7),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10)
                                                                      ),
                                                                      child: TextFormField(
                                                                        controller: controllerBreath,
                                                                        autovalidateMode: AutovalidateMode.always,
                                                                        keyboardType: TextInputType.number,
                                                                        style: TextStyle(color: Color(0XFF262626)),
                                                                        decoration: const InputDecoration(
                                                                          contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                          border: InputBorder.none,
                                                                          hintText: '',
                                                                          filled: true,
                                                                          counterText: "",
                                                                          fillColor: Color(0xFFEBF0F3),
                                                                          enabledBorder : OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                          errorBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                          focusedErrorBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                          focusedBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                        ),
                                                                        onSaved: (String value) {
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),),

                                                                /*Expanded(
                                                      child: Icon(Icons.lock,size: 18,
                                                        color: Colors.grey,),
                                                    )*/

                                                              ],
                                                            );
                                                          }),
                                                      SizedBox(
                                                        height: 15,
                                                      ),

                                                      if(isLoadSix)
                                                        CircularProgressIndicator()
                                                      else
                                                        GestureDetector(
                                                          onTap: () async{

                                                            setState(() {
                                                              isLoadSix = true;});

                                                            await Provider.of<ApiManager>(context,listen: false).addToSetApi("breath",snapshots.data['data'][index]['exercise']['id'],controllerBreath.text,setType);
                                                            controllerBreath.clear();

                                                            setState(() {
                                                              isLoadSix = false;
                                                            });

                                                          },
                                                          child: Text("ADD SET",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                              color: Color(0XFF2CB3BF),
                                                            ),),
                                                        ),

                                                    ],
                                                  )
                                                else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "7")
                                                    Column(
                                                      children: [
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: snapshots.data['data'][index]['sets'].length,
                                                            itemBuilder: (context,inde){
                                                              newIndex = inde + 1;
                                                              return Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Stack(
                                                                        children: [
                                                                          Center(
                                                                            child: GestureDetector(
                                                                              onTap:(){
                                                                                _numberMenu();
                                                                              },
                                                                              child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                                style: TextStyle(
                                                                                    fontSize: 17,
                                                                                    color: Color(0XFF2CB3BF),
                                                                                    fontWeight: FontWeight.bold
                                                                                ),),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),

                                                                  Expanded(
                                                                      child: Center(
                                                                        child: Text("_",
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: Color(0XFF2CB3BF),
                                                                              fontWeight: FontWeight.bold
                                                                          ),),
                                                                      )),

                                                                  Expanded(
                                                                    child: Center(
                                                                      child: Container(

                                                                        margin: EdgeInsets.all(7),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            color: Color(0xFFEBF0F3)
                                                                        ),
                                                                        child: TextFormField(
                                                                          controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['breath'].toString(),
                                                                          textAlign: TextAlign.center,
                                                                          decoration: InputDecoration(
                                                                            border: InputBorder.none,),
                                                                          onChanged: (value){
                                                                            newTag = "breath";
                                                                            Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  Expanded(
                                                                    child: Center(
                                                                      child: Container(

                                                                        margin: EdgeInsets.all(7),

                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            color: Color(0xFFEBF0F3)
                                                                        ),
                                                                        child: TextFormField(
                                                                          controller: TextEditingController()..text = snapshots.data['data'][index]['sets'][inde]['reps'].toString(),
                                                                          textAlign: TextAlign.center,
                                                                          decoration: InputDecoration(
                                                                            border: InputBorder.none,),
                                                                          onChanged: (value){
                                                                            newTag = "reps";
                                                                            Provider.of<ApiManager>(context,listen: false).editToSetApi(newTag, value, snapshots.data['data'][index]['sets'][inde]['id']);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              );
                                                            }),

                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: 1,
                                                            itemBuilder: (context,index){
                                                              return Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Stack(
                                                                        children: [
                                                                          Center(
                                                                            child: GestureDetector(
                                                                              onTap:(){
                                                                                _numberMenu();
                                                                              },
                                                                              child: Text("Select Type",
                                                                                style: TextStyle(
                                                                                    fontSize: 13,
                                                                                    color: Color(0XFF2CB3BF),
                                                                                    fontWeight: FontWeight.bold
                                                                                ),),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),

                                                                  Expanded(
                                                                      child: Center(
                                                                        child: Text("_",
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: Color(0XFF2CB3BF),
                                                                              fontWeight: FontWeight.bold
                                                                          ),),
                                                                      )),

                                                                  Expanded(
                                                                    child: Center(
                                                                      child: Container(
                                                                        margin: EdgeInsets.all(7),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10)
                                                                        ),
                                                                        child: TextFormField(
                                                                          controller: controllerbreathSeven,
                                                                          autovalidateMode: AutovalidateMode.always,
                                                                          keyboardType: TextInputType.number,
                                                                          style: TextStyle(color: Color(0XFF262626)),
                                                                          decoration: const InputDecoration(
                                                                            contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                            border: InputBorder.none,
                                                                            hintText: '',
                                                                            filled: true,
                                                                            counterText: "",
                                                                            fillColor: Color(0xFFEBF0F3),
                                                                            enabledBorder : OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                            errorBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                            focusedErrorBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                          ),
                                                                          onSaved: (String value) {},
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  Expanded(
                                                                    child: Center(
                                                                      child: Container(
                                                                        margin: EdgeInsets.all(7),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10)
                                                                        ),
                                                                        child: TextFormField(
                                                                          controller: controllerRepsSeven,
                                                                          keyboardType: TextInputType.number,
                                                                          style: TextStyle(color: Color(0XFF262626)),
                                                                          decoration: const InputDecoration(
                                                                            contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                            border: InputBorder.none,
                                                                            hintText: '',
                                                                            filled: true,
                                                                            counterText: "",
                                                                            fillColor: Color(0xFFEBF0F3),
                                                                            enabledBorder : OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                            errorBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                            focusedErrorBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                          ),
                                                                          onSaved: (String value) {
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),),

                                                                  /*Expanded(
                                                        child: Icon(Icons.lock,size: 18,
                                                          color: Colors.grey,),
                                                      )*/

                                                                ],
                                                              );
                                                            }),

                                                        SizedBox(
                                                          height: 15,),

                                                        GestureDetector(
                                                          onTap: () async{
                                                            setState(() {
                                                              isLoadSeven = true;
                                                            });
                                                            await Provider.of<ApiManager>(context,listen: false).addToSetTwoControllerApi("breathwithreps",snapshots.data['data'][index]['exercise']['id'],controllerRepsSeven.text,controllerbreathSeven.text,setType);
                                                            controllerbreathSeven.clear();
                                                            controllerRepsSeven.clear();
                                                            setState(() {
                                                              isLoadSeven = false;
                                                            });
                                                          },
                                                          child: Text("ADD SET",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                              color: Color(0XFF2CB3BF),
                                                            ),),
                                                        ),
                                                      ],
                                                    ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),

                              Positioned(left: 0,child: Container(width: 10,
                                margin: EdgeInsets.only(top: 8,bottom: 8),
                                color: outputs == "1" ? Colors.green: outputs == "2"?Colors.black:outputs == "3"?Colors.cyan:outputs == "4"?Colors.blueGrey:outputs == "5"?Colors.deepOrange:outputs == "6"?Colors.blue:outputs == "7"?Colors.brown:outputs == "8"?Colors.purple:outputs == "9"?Colors.indigo:Colors.indigoAccent,
                                child: Row(
                                  children: [
                                    // Container(width: 10,color: Colors.lightGreen,),
                                    Expanded(child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Visibility(
                                                visible: false,
                                                child: Text(snapshots.data['data'][index]['exercise']['exercise_name'],style: TextStyle(
                                                    color: Color(0XFF2CB3BF),
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 14
                                                ),),
                                              ),

                                              GestureDetector(
                                                  onTap:(){
                                                    setState(() {
                                                      _showPopupMenu(snapshots.data['data'][index]['exercise']['id'],snapshots.data['data'][index]['exercise']['exercise_name']);
                                                    });
                                                  },child: Image.asset("assets/images/menu.png",width: 20,height: 30,color: Color(0XFF2CB3BF),)),
                                            ],
                                          ),
                                        ),
                                        if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "1")
                                          Text("")
                                        else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "2")
                                          Text("")
                                        else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "3")
                                          Text("")
                                          else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "4")
                                              Text("")
                                            else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "5")
                                                Text("")
                                              else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "6")
                                                  Text("")
                                                else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "7")
                                                    Text(""),

                                        if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "1")
                                          Opacity(
                                            opacity: 0.0,
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount: snapshots.data['data'][index]['sets'].length,
                                                    itemBuilder: (context,inde){
                                                      newIndex = inde + 1;
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                              child: Stack(
                                                                children: [
                                                                  Center(
                                                                    child: GestureDetector(
                                                                      onTap:(){
                                                                        _numberMenu();
                                                                      },
                                                                      child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                        style: TextStyle(
                                                                            fontSize: 17,
                                                                            color: Color(0XFF2CB3BF),
                                                                            fontWeight: FontWeight.bold
                                                                        ),),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),

                                                          Expanded(
                                                              child: Center(
                                                                child: Text("_",
                                                                  style: TextStyle(
                                                                      fontSize: 17,
                                                                      color: Color(0XFF2CB3BF),
                                                                      fontWeight: FontWeight.bold
                                                                  ),),
                                                              )),

                                                          Expanded(
                                                            child: Center(
                                                              child: Container(

                                                                margin: EdgeInsets.all(7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    color: Color(0xFFEBF0F3)
                                                                ),
                                                                child: Text(snapshots.data['data'][index]['sets'][inde]['reps'].toString(),
                                                                  style: TextStyle(color: Color(0XFF262626)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      );
                                                    }),

                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount: 1,
                                                    itemBuilder: (context,index){
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                              child: Stack(
                                                                children: [
                                                                  Center(
                                                                    child: GestureDetector(
                                                                      onTap:(){
                                                                        _numberMenu();
                                                                      },
                                                                      child: Text("Select Type",
                                                                        style: TextStyle(
                                                                            fontSize: 13,
                                                                            color: Color(0XFF2CB3BF),
                                                                            fontWeight: FontWeight.bold
                                                                        ),),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),

                                                          Expanded(
                                                              child: Center(
                                                                child: Text("_",
                                                                  style: TextStyle(
                                                                      fontSize: 17,
                                                                      color: Color(0XFF2CB3BF),
                                                                      fontWeight: FontWeight.bold
                                                                  ),),
                                                              )),

                                                          Expanded(
                                                            child: Center(
                                                              child: Container(
                                                                margin: EdgeInsets.all(7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10)
                                                                ),
                                                                child: TextFormField(
                                                                  controller: controllerReps,
                                                                  autovalidateMode: AutovalidateMode.always,
                                                                  keyboardType: TextInputType.number,
                                                                  style: TextStyle(color: Color(0XFF262626)),
                                                                  decoration: const InputDecoration(
                                                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                    border: InputBorder.none,
                                                                    hintText: '',
                                                                    filled: true,
                                                                    counterText: "",
                                                                    fillColor: Color(0xFFEBF0F3),
                                                                    enabledBorder : OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    errorBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                  ),
                                                                  onSaved: (String value) {
                                                                  },
                                                                ),
                                                              ),
                                                            ),),

                                                        ],
                                                      );
                                                    }),

                                                SizedBox(
                                                  height: 15,),

                                                GestureDetector(
                                                  onTap: ()async{
                                                    setState(() {
                                                      isLoadOne = true;
                                                    });
                                                    await Provider.of<ApiManager>(context,listen: false).addToSetApi("reps",snapshots.data['data'][index]['exercise']['id'],controllerReps.text,setType);
                                                    controllerReps.clear();
                                                    setState(() {
                                                      isLoadOne = false;
                                                    });
                                                  },
                                                  child: Text("ADD SET",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0XFF2CB3BF),
                                                    ),),
                                                ),
                                              ],
                                            ),
                                          )
                                        else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "2")
                                          Opacity(
                                            opacity: 0.0,
                                            child: Column(
                                              children: [

                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount: snapshots.data['data'][index]['sets'].length,
                                                    itemBuilder: (context,inde){
                                                      newIndex = inde + 1;
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                              child: Stack(
                                                                children: [
                                                                  Center(
                                                                    child: GestureDetector(
                                                                      onTap:(){
                                                                        _numberMenu();
                                                                      },
                                                                      child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                        style: TextStyle(
                                                                            fontSize: 17,
                                                                            color: Color(0XFF2CB3BF),
                                                                            fontWeight: FontWeight.bold
                                                                        ),),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),

                                                          Expanded(
                                                              child: Center(
                                                                child: Text("_",
                                                                  style: TextStyle(
                                                                      fontSize: 17,
                                                                      color: Color(0XFF2CB3BF),
                                                                      fontWeight: FontWeight.bold
                                                                  ),),
                                                              )),

                                                          Expanded(
                                                            child: Center(
                                                              child: Container(

                                                                margin: EdgeInsets.all(7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    color: Color(0xFFEBF0F3)
                                                                ),
                                                                child: Text(snapshots.data['data'][index]['sets'][inde]['kg'].toString(),
                                                                  style: TextStyle(color: Color(0XFF262626)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          Expanded(
                                                            child: Center(
                                                              child: Container(

                                                                margin: EdgeInsets.all(7),

                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    color: Color(0xFFEBF0F3)
                                                                ),
                                                                child: Text(snapshots.data['data'][index]['sets'][inde]['reps'].toString(),
                                                                  style: TextStyle(color: Color(0XFF262626)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      );
                                                    }),

                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount: 1,
                                                    itemBuilder: (context,index){
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                              child: Stack(
                                                                children: [
                                                                  Center(
                                                                    child: GestureDetector(
                                                                      onTap:(){
                                                                        _numberMenu();
                                                                      },
                                                                      child: Text("Select Type",
                                                                        style: TextStyle(
                                                                            fontSize: 13,
                                                                            color: Color(0XFF2CB3BF),
                                                                            fontWeight: FontWeight.bold
                                                                        ),),
                                                                    ),
                                                                  ),
                                                                  // Positioned(
                                                                  //   child: PopupMenuButton(
                                                                  //     icon: Icon(
                                                                  //       Icons.ac_unit_outlined,color: Colors.black87,
                                                                  //     ),
                                                                  //     itemBuilder: (BuildContext context){
                                                                  //
                                                                  //     },
                                                                  //   ),
                                                                  // )
                                                                ],
                                                              )),

                                                          Expanded(
                                                              child: Center(
                                                                child: Text("_",
                                                                  style: TextStyle(
                                                                      fontSize: 17,
                                                                      color: Color(0XFF2CB3BF),
                                                                      fontWeight: FontWeight.bold
                                                                  ),),
                                                              )),

                                                          Expanded(
                                                            child: Center(
                                                              child: Container(
                                                                margin: EdgeInsets.all(7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10)
                                                                ),
                                                                child: TextFormField(
                                                                  controller: controllerWeightThree,
                                                                  autovalidateMode: AutovalidateMode.always,
                                                                  keyboardType: TextInputType.number,
                                                                  style: TextStyle(color: Color(0XFF262626)),
                                                                  decoration: const InputDecoration(
                                                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                    border: InputBorder.none,
                                                                    hintText: '',
                                                                    filled: true,
                                                                    counterText: "",
                                                                    fillColor: Color(0xFFEBF0F3),
                                                                    enabledBorder : OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    errorBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                  ),
                                                                  onSaved: (String value) {},
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          Expanded(
                                                            child: Center(
                                                              child: Container(
                                                                margin: EdgeInsets.all(7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10)
                                                                ),
                                                                child: TextFormField(
                                                                  controller: controllerRepsThree,
                                                                  autovalidateMode: AutovalidateMode.always,
                                                                  keyboardType: TextInputType.number,
                                                                  style: TextStyle(color: Color(0XFF262626)),
                                                                  decoration: const InputDecoration(
                                                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                    border: InputBorder.none,
                                                                    hintText: '',
                                                                    filled: true,
                                                                    counterText: "",
                                                                    fillColor: Color(0xFFEBF0F3),
                                                                    enabledBorder : OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    errorBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                      borderSide: BorderSide(color: Colors.white12),
                                                                    ),
                                                                  ),
                                                                  onSaved: (String value) {
                                                                  },
                                                                ),
                                                              ),
                                                            ),),
                                                        ],
                                                      );
                                                    }),

                                                SizedBox(
                                                  height: 15,
                                                ),

                                                if(isLoadTwo)
                                                  CircularProgressIndicator()
                                                else
                                                  GestureDetector(
                                                    onTap: () async{
                                                      setState(() {
                                                        isLoadTwo = true;
                                                      });
                                                      await Provider.of<ApiManager>(context,listen: false).addToSetTwoControllerApi("weightwithreps",snapshots.data['data'][index]['exercise']['id'],controllerRepsThree.text,controllerWeightThree.text,setType);
                                                      controllerWeightThree.clear();
                                                      controllerRepsThree.clear();
                                                      setState(() {
                                                        isLoadTwo = false;
                                                      });
                                                    },
                                                    child: Text("ADD SET",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0XFF2CB3BF),
                                                      ),),
                                                  ),
                                              ],
                                            ),
                                          )
                                        else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "3")
                                            Opacity(
                                              opacity: 0.0,
                                              child: Column(
                                                children: [

                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemCount: snapshots.data['data'][index]['sets'].length,
                                                      itemBuilder: (context,inde){
                                                        newIndex = inde + 1;
                                                        return Row(
                                                          children: [
                                                            Expanded(
                                                                child: Stack(
                                                                  children: [
                                                                    Center(
                                                                      child: GestureDetector(
                                                                        onTap:(){
                                                                          _numberMenu();
                                                                        },
                                                                        child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: Color(0XFF2CB3BF),
                                                                              fontWeight: FontWeight.bold
                                                                          ),),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),

                                                            Expanded(
                                                                child: Center(
                                                                  child: Text("_",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        color: Color(0XFF2CB3BF),
                                                                        fontWeight: FontWeight.bold
                                                                    ),),
                                                                )),

                                                            Expanded(
                                                              child: Center(
                                                                child: Container(

                                                                  margin: EdgeInsets.all(7),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      color: Color(0xFFEBF0F3)
                                                                  ),
                                                                  child: Text(snapshots.data['data'][index]['sets'][inde]['km'].toString(),
                                                                    style: TextStyle(color: Color(0XFF262626)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                          ],
                                                        );
                                                      }),

                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemCount: 1,
                                                      itemBuilder: (context,index){
                                                        return Row(
                                                          children: [
                                                            Expanded(
                                                                child: Stack(
                                                                  children: [
                                                                    Center(
                                                                      child: GestureDetector(
                                                                        onTap:(){
                                                                          _numberMenu();
                                                                        },
                                                                        child: Text("Select Type",
                                                                          style: TextStyle(
                                                                              fontSize: 13,
                                                                              color: Color(0XFF2CB3BF),
                                                                              fontWeight: FontWeight.bold
                                                                          ),),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),

                                                            Expanded(
                                                                child: Center(
                                                                  child: Text("_",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        color: Color(0XFF2CB3BF),
                                                                        fontWeight: FontWeight.bold
                                                                    ),),
                                                                )),

                                                            Expanded(
                                                              child: Center(
                                                                child: Container(
                                                                  margin: EdgeInsets.all(7),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10)),
                                                                  child: TextFormField(
                                                                    controller: controllerkm,
                                                                    autovalidateMode: AutovalidateMode.always,
                                                                    keyboardType: TextInputType.number,
                                                                    style: TextStyle(color: Color(0XFF262626)),
                                                                    decoration: const InputDecoration(
                                                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                      border: InputBorder.none,
                                                                      hintText: '',
                                                                      filled: true,
                                                                      counterText: "",
                                                                      fillColor: Color(0xFFEBF0F3),
                                                                      enabledBorder : OutlineInputBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                        borderSide: BorderSide(color: Colors.white12),
                                                                      ),
                                                                      errorBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                        borderSide: BorderSide(color: Colors.white12),
                                                                      ),
                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                        borderSide: BorderSide(color: Colors.white12),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                        borderSide: BorderSide(color: Colors.white12),
                                                                      ),
                                                                    ),
                                                                    onSaved: (String value) {
                                                                    },
                                                                  ),
                                                                ),
                                                              ),),

                                                          ],
                                                        );
                                                      }),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  if(isLoadThree)
                                                    CircularProgressIndicator()
                                                  else
                                                    GestureDetector(
                                                      onTap: () async{
                                                        setState(() {
                                                          isLoadThree = true;
                                                        });
                                                        await Provider.of<ApiManager>(context,listen: false).addToSetApi("km",snapshots.data['data'][index]['exercise']['id'],controllerkm.text,setType);
                                                        controllerkm.clear();
                                                        setState(() {
                                                          isLoadThree = false;
                                                        });
                                                      },
                                                      child: Text("ADD SET",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w600,
                                                          color: Color(0XFF2CB3BF),
                                                        ),),
                                                    ),
                                                ],
                                              ),
                                            )
                                          else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "4")
                                              Opacity(
                                                opacity: 0.0,
                                                child: Column(
                                                  children: [

                                                    ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: snapshots.data['data'][index]['sets'].length,
                                                        itemBuilder: (context,inde){
                                                          newIndex = inde + 1;
                                                          return Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Stack(
                                                                    children: [
                                                                      Center(
                                                                        child: GestureDetector(
                                                                          onTap:(){
                                                                            _numberMenu();
                                                                          },
                                                                          child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                            style: TextStyle(
                                                                                fontSize: 17,
                                                                                color: Color(0XFF2CB3BF),
                                                                                fontWeight: FontWeight.bold
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),

                                                              Expanded(
                                                                  child: Center(
                                                                    child: Text("_",
                                                                      style: TextStyle(
                                                                          fontSize: 17,
                                                                          color: Color(0XFF2CB3BF),
                                                                          fontWeight: FontWeight.bold
                                                                      ),),
                                                                  )),

                                                              Expanded(
                                                                child: Center(
                                                                  child: Container(

                                                                    margin: EdgeInsets.all(7),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        color: Color(0xFFEBF0F3)
                                                                    ),
                                                                    child: Text(snapshots.data['data'][index]['sets'][inde]['time'].toString(),
                                                                      style: TextStyle(color: Color(0XFF262626)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                            ],
                                                          );
                                                        }),

                                                    ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: 1,
                                                        itemBuilder: (context,index){
                                                          return Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Stack(
                                                                    children: [
                                                                      Center(
                                                                        child: GestureDetector(
                                                                          onTap:(){
                                                                            _numberMenu();
                                                                          },
                                                                          child: Text("1",
                                                                            style: TextStyle(
                                                                                fontSize: 17,
                                                                                color: Color(0XFF2CB3BF),
                                                                                fontWeight: FontWeight.bold
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),

                                                              Expanded(
                                                                  child: Center(
                                                                    child: Text("_",
                                                                      style: TextStyle(
                                                                          fontSize: 17,
                                                                          color: Color(0XFF2CB3BF),
                                                                          fontWeight: FontWeight.bold
                                                                      ),),
                                                                  )),

                                                              Expanded(
                                                                child: Center(
                                                                  child: Container(
                                                                    margin: EdgeInsets.all(7),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10)
                                                                    ),
                                                                    child: TextFormField(
                                                                      controller: controllerTime,
                                                                      autovalidateMode: AutovalidateMode.always,
                                                                      keyboardType: TextInputType.number,
                                                                      style: TextStyle(color: Color(0XFF262626)),
                                                                      decoration: const InputDecoration(
                                                                        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                        border: InputBorder.none,
                                                                        hintText: '',
                                                                        filled: true,
                                                                        counterText: "",
                                                                        fillColor: Color(0xFFEBF0F3),
                                                                        enabledBorder : OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                        errorBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                        focusedErrorBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                          borderSide: BorderSide(color: Colors.white12),
                                                                        ),
                                                                      ),
                                                                      onSaved: (String value) {
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),),

                                                            ],
                                                          );
                                                        }),

                                                    SizedBox(height: 15,),

                                                    if(isLoadFour)
                                                      CircularProgressIndicator()
                                                    else
                                                      GestureDetector(
                                                        onTap: () async{
                                                          setState(() {
                                                            isLoadFour = true;
                                                          });
                                                          await Provider.of<ApiManager>(context,listen: false).addToSetApi("time",snapshots.data['data'][index]['exercise']['id'],controllerTime.text,setType);
                                                          controllerTime.clear();
                                                          setState(() {
                                                            isLoadFour = false;
                                                          });
                                                        },
                                                        child: Text("ADD SET",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(0XFF2CB3BF),
                                                          ),),
                                                      ),

                                                  ],
                                                ),
                                              )
                                            else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "5")
                                                Opacity(
                                                  opacity: 0.0,
                                                  child: Column(
                                                    children: [

                                                      ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemCount: snapshots.data['data'][index]['sets'].length,
                                                          itemBuilder: (context,inde){
                                                            newIndex = inde + 1;
                                                            return Row(
                                                              children: [
                                                                Expanded(
                                                                    child: Stack(
                                                                      children: [
                                                                        Center(
                                                                          child: GestureDetector(
                                                                            onTap:(){
                                                                              _numberMenu();
                                                                            },
                                                                            child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                              style: TextStyle(
                                                                                  fontSize: 17,
                                                                                  color: Color(0XFF2CB3BF),
                                                                                  fontWeight: FontWeight.bold
                                                                              ),),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )),

                                                                Expanded(
                                                                    child: Center(
                                                                      child: Text("_",
                                                                        style: TextStyle(
                                                                            fontSize: 17,
                                                                            color: Color(0XFF2CB3BF),
                                                                            fontWeight: FontWeight.bold
                                                                        ),),
                                                                    )),

                                                                Expanded(
                                                                  child: Center(
                                                                    child: Container(

                                                                      margin: EdgeInsets.all(7),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          color: Color(0xFFEBF0F3)
                                                                      ),
                                                                      child: Text(snapshots.data['data'][index]['sets'][inde]['level'].toString(),
                                                                        style: TextStyle(color: Color(0XFF262626)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                Expanded(
                                                                  child: Center(
                                                                    child: Container(

                                                                      margin: EdgeInsets.all(7),

                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          color: Color(0xFFEBF0F3)
                                                                      ),
                                                                      child: Text(snapshots.data['data'][index]['sets'][inde]['time'].toString(),
                                                                        style: TextStyle(color: Color(0XFF262626)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                              ],
                                                            );
                                                          }),

                                                      ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemCount: 1,
                                                          itemBuilder: (context,index){
                                                            return Row(
                                                              children: [
                                                                Expanded(
                                                                    child: Stack(
                                                                      children: [
                                                                        Center(
                                                                          child: GestureDetector(
                                                                            onTap:(){
                                                                              _numberMenu();
                                                                            },
                                                                            child: Text("Select Type",
                                                                              style: TextStyle(
                                                                                  fontSize: 13,
                                                                                  color: Color(0XFF2CB3BF),
                                                                                  fontWeight: FontWeight.bold
                                                                              ),),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )),

                                                                Expanded(
                                                                    child: Center(
                                                                      child: Text("_",
                                                                        style: TextStyle(
                                                                            fontSize: 17,
                                                                            color: Color(0XFF2CB3BF),
                                                                            fontWeight: FontWeight.bold
                                                                        ),),
                                                                    )),

                                                                Expanded(
                                                                  child: Center(
                                                                    child: Container(
                                                                      margin: EdgeInsets.all(7),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10)
                                                                      ),
                                                                      child: TextFormField(
                                                                        controller: controllerLevelFive,
                                                                        autovalidateMode: AutovalidateMode.always,
                                                                        keyboardType: TextInputType.number,
                                                                        style: TextStyle(color: Color(0XFF262626)),
                                                                        decoration: const InputDecoration(
                                                                          contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                          border: InputBorder.none,
                                                                          hintText: '',
                                                                          filled: true,
                                                                          counterText: "",
                                                                          fillColor: Color(0xFFEBF0F3),
                                                                          enabledBorder : OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                          errorBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                          focusedErrorBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                          focusedBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                        ),
                                                                        onSaved: (String value) {},
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                Expanded(
                                                                  child: Center(
                                                                    child: Container(
                                                                      margin: EdgeInsets.all(7),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10)
                                                                      ),
                                                                      child: TextFormField(
                                                                        controller: controllerTimesFive,
                                                                        autovalidateMode: AutovalidateMode.always,
                                                                        keyboardType: TextInputType.number,
                                                                        style: TextStyle(color: Color(0XFF262626)),
                                                                        decoration: const InputDecoration(
                                                                          contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                          border: InputBorder.none,
                                                                          hintText: '',
                                                                          filled: true,
                                                                          counterText: "",
                                                                          fillColor: Color(0xFFEBF0F3),
                                                                          enabledBorder : OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                          errorBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                          focusedErrorBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                          focusedBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                            borderSide: BorderSide(color: Colors.white12),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),),

                                                              ],
                                                            );
                                                          }),

                                                      SizedBox(height: 15,),

                                                      if(isLoadFive)
                                                        CircularProgressIndicator()
                                                      else
                                                        GestureDetector(
                                                          onTap: () async{
                                                            setState(() {
                                                              isLoadFive = true;
                                                            });
                                                            await Provider.of<ApiManager>(context,listen: false).addToSetTwoControllerApi("level",snapshots.data['data'][index]['exercise']['id'],controllerLevelFive.text,controllerTimesFive.text,setType);
                                                            controllerLevelFive.clear();
                                                            controllerTimesFive.clear();
                                                            setState(() {
                                                              isLoadFive = false;
                                                            });
                                                          },
                                                          child: Text("ADD SET",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                              color: Color(0XFF2CB3BF),
                                                            ),),
                                                        )
                                                    ],
                                                  ),
                                                )
                                              else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "6")
                                                  Opacity(
                                                    opacity: 0.0,
                                                    child: Column(
                                                      children: [

                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: snapshots.data['data'][index]['sets'].length,
                                                            itemBuilder: (context,inde){
                                                              newIndex = inde + 1;
                                                              return Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Stack(
                                                                        children: [
                                                                          Center(
                                                                            child: GestureDetector(
                                                                              onTap:(){
                                                                                _numberMenu();
                                                                              },
                                                                              child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                                style: TextStyle(
                                                                                    fontSize: 17,
                                                                                    color: Color(0XFF2CB3BF),
                                                                                    fontWeight: FontWeight.bold
                                                                                ),),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),

                                                                  Expanded(
                                                                      child: Center(
                                                                        child: Text("_",
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: Color(0XFF2CB3BF),
                                                                              fontWeight: FontWeight.bold
                                                                          ),),
                                                                      )),

                                                                  Expanded(
                                                                    child: Center(
                                                                      child: Container(

                                                                        margin: EdgeInsets.all(7),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            color: Color(0xFFEBF0F3)
                                                                        ),
                                                                        child: Text(snapshots.data['data'][index]['sets'][inde]['breath'].toString(),
                                                                          style: TextStyle(color: Color(0XFF262626)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              );
                                                            }),

                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: 1,
                                                            itemBuilder: (context,index){
                                                              return Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Stack(
                                                                        children: [
                                                                          Center(
                                                                            child: GestureDetector(
                                                                              onTap:(){
                                                                                _numberMenu();
                                                                              },
                                                                              child: Text("1",
                                                                                style: TextStyle(
                                                                                    fontSize: 17,
                                                                                    color: Color(0XFF2CB3BF),
                                                                                    fontWeight: FontWeight.bold
                                                                                ),),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),

                                                                  Expanded(
                                                                      child: Center(
                                                                        child: Text("_",
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: Color(0XFF2CB3BF),
                                                                              fontWeight: FontWeight.bold
                                                                          ),),
                                                                      )),

                                                                  /*Expanded(
                                                        child: Center(
                                                          child: Container(
                                                            margin: EdgeInsets.all(7),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: TextFormField(
                                                              autovalidateMode: AutovalidateMode.always,
                                                              keyboardType: TextInputType.number,
                                                              style: TextStyle(color: Color(0XFF262626)),
                                                              decoration: const InputDecoration(
                                                                contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                border: InputBorder.none,
                                                                hintText: '',
                                                                filled: true,
                                                                counterText: "",
                                                                fillColor: Color(0xFFEBF0F3),
                                                                enabledBorder : OutlineInputBorder(
                                                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                  borderSide: BorderSide(color: Colors.white12),
                                                                ),
                                                                errorBorder: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                  borderSide: BorderSide(color: Colors.white12),
                                                                ),
                                                                focusedErrorBorder: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                  borderSide: BorderSide(color: Colors.white12),
                                                                ),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                  borderSide: BorderSide(color: Colors.white12),
                                                                ),
                                                              ),
                                                              onSaved: (String value) {},
                                                            ),
                                                          ),
                                                        ),
                                                      ),*/

                                                                  Expanded(
                                                                    child: Center(
                                                                      child: Container(
                                                                        margin: EdgeInsets.all(7),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10)
                                                                        ),
                                                                        child: TextFormField(
                                                                          controller: controllerBreath,
                                                                          autovalidateMode: AutovalidateMode.always,
                                                                          keyboardType: TextInputType.number,
                                                                          style: TextStyle(color: Color(0XFF262626)),
                                                                          decoration: const InputDecoration(
                                                                            contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                            border: InputBorder.none,
                                                                            hintText: '',
                                                                            filled: true,
                                                                            counterText: "",
                                                                            fillColor: Color(0xFFEBF0F3),
                                                                            enabledBorder : OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                            errorBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                            focusedErrorBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                              borderSide: BorderSide(color: Colors.white12),
                                                                            ),
                                                                          ),
                                                                          onSaved: (String value) {
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),),

                                                                  /*Expanded(
                                                        child: Icon(Icons.lock,size: 18,
                                                          color: Colors.grey,),
                                                      )*/

                                                                ],
                                                              );
                                                            }),
                                                        SizedBox(
                                                          height: 15,
                                                        ),

                                                        if(isLoadSix)
                                                          CircularProgressIndicator()
                                                        else
                                                          GestureDetector(
                                                            onTap: () async{

                                                              setState(() {
                                                                isLoadSix = true;});

                                                              await Provider.of<ApiManager>(context,listen: false).addToSetApi("breath",snapshots.data['data'][index]['exercise']['id'],controllerBreath.text,setType);
                                                              controllerBreath.clear();

                                                              setState(() {
                                                                isLoadSix = false;
                                                              });

                                                            },
                                                            child: Text("ADD SET",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600,
                                                                color: Color(0XFF2CB3BF),
                                                              ),),
                                                          ),

                                                      ],
                                                    ),
                                                  )
                                                else if(snapshots.data['data'][index]['exercise_data']['selected_unit'] == "7")
                                                    Opacity(
                                                      opacity: 0.0,
                                                      child: Column(
                                                        children: [

                                                          ListView.builder(
                                                              shrinkWrap: true,
                                                              physics: NeverScrollableScrollPhysics(),
                                                              itemCount: snapshots.data['data'][index]['sets'].length,
                                                              itemBuilder: (context,inde){
                                                                newIndex = inde + 1;
                                                                return Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child: Stack(
                                                                          children: [
                                                                            Center(
                                                                              child: GestureDetector(
                                                                                onTap:(){
                                                                                  _numberMenu();
                                                                                },
                                                                                child: Text(snapshots.data['data'][index]['sets'][inde]['set_type'].toString()[0],
                                                                                  style: TextStyle(
                                                                                      fontSize: 17,
                                                                                      color: Color(0XFF2CB3BF),
                                                                                      fontWeight: FontWeight.bold
                                                                                  ),),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),

                                                                    Expanded(
                                                                        child: Center(
                                                                          child: Text("_",
                                                                            style: TextStyle(
                                                                                fontSize: 17,
                                                                                color: Color(0XFF2CB3BF),
                                                                                fontWeight: FontWeight.bold
                                                                            ),),
                                                                        )),

                                                                    Expanded(
                                                                      child: Center(
                                                                        child: Container(

                                                                          margin: EdgeInsets.all(7),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              color: Color(0xFFEBF0F3)
                                                                          ),
                                                                          child: Text(snapshots.data['data'][index]['sets'][inde]['breath'].toString(),
                                                                            style: TextStyle(color: Color(0XFF262626)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Expanded(
                                                                      child: Center(
                                                                        child: Container(

                                                                          margin: EdgeInsets.all(7),

                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              color: Color(0xFFEBF0F3)
                                                                          ),
                                                                          child: Text(snapshots.data['data'][index]['sets'][inde]['reps'].toString(),
                                                                            style: TextStyle(color: Color(0XFF262626)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  ],
                                                                );
                                                              }),

                                                          ListView.builder(
                                                              shrinkWrap: true,
                                                              physics: NeverScrollableScrollPhysics(),
                                                              itemCount: 1,
                                                              itemBuilder: (context,index){
                                                                return Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child: Stack(
                                                                          children: [
                                                                            Center(
                                                                              child: GestureDetector(
                                                                                onTap:(){
                                                                                  _numberMenu();
                                                                                },
                                                                                child: Text("Select Type",
                                                                                  style: TextStyle(
                                                                                      fontSize: 13,
                                                                                      color: Color(0XFF2CB3BF),
                                                                                      fontWeight: FontWeight.bold
                                                                                  ),),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),

                                                                    Expanded(
                                                                        child: Center(
                                                                          child: Text("_",
                                                                            style: TextStyle(
                                                                                fontSize: 17,
                                                                                color: Color(0XFF2CB3BF),
                                                                                fontWeight: FontWeight.bold
                                                                            ),),
                                                                        )),

                                                                    Expanded(
                                                                      child: Center(
                                                                        child: Container(
                                                                          margin: EdgeInsets.all(7),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10)
                                                                          ),
                                                                          child: TextFormField(
                                                                            controller: controllerbreathSeven,
                                                                            autovalidateMode: AutovalidateMode.always,
                                                                            keyboardType: TextInputType.number,
                                                                            style: TextStyle(color: Color(0XFF262626)),
                                                                            decoration: const InputDecoration(
                                                                              contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                              border: InputBorder.none,
                                                                              hintText: '',
                                                                              filled: true,
                                                                              counterText: "",
                                                                              fillColor: Color(0xFFEBF0F3),
                                                                              enabledBorder : OutlineInputBorder(
                                                                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                                borderSide: BorderSide(color: Colors.white12),
                                                                              ),
                                                                              errorBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                                borderSide: BorderSide(color: Colors.white12),
                                                                              ),
                                                                              focusedErrorBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                                borderSide: BorderSide(color: Colors.white12),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                                borderSide: BorderSide(color: Colors.white12),
                                                                              ),
                                                                            ),
                                                                            onSaved: (String value) {},
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Expanded(
                                                                      child: Center(
                                                                        child: Container(
                                                                          margin: EdgeInsets.all(7),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10)
                                                                          ),
                                                                          child: TextFormField(
                                                                            controller: controllerRepsSeven,
                                                                            keyboardType: TextInputType.number,
                                                                            style: TextStyle(color: Color(0XFF262626)),
                                                                            decoration: const InputDecoration(
                                                                              contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                                              border: InputBorder.none,
                                                                              hintText: '',
                                                                              filled: true,
                                                                              counterText: "",
                                                                              fillColor: Color(0xFFEBF0F3),
                                                                              enabledBorder : OutlineInputBorder(
                                                                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                                borderSide: BorderSide(color: Colors.white12),
                                                                              ),
                                                                              errorBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                                borderSide: BorderSide(color: Colors.white12),
                                                                              ),
                                                                              focusedErrorBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                                borderSide: BorderSide(color: Colors.white12),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                                                                borderSide: BorderSide(color: Colors.white12),
                                                                              ),
                                                                            ),
                                                                            onSaved: (String value) {
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),),


                                                                  ],
                                                                );
                                                              }),

                                                          SizedBox(
                                                            height: 15,),

                                                          GestureDetector(
                                                            onTap: () async{
                                                              setState(() {
                                                                isLoadSeven = true;
                                                              });
                                                              await Provider.of<ApiManager>(context,listen: false).addToSetTwoControllerApi("breathwithreps",snapshots.data['data'][index]['exercise']['id'],controllerRepsSeven.text,controllerbreathSeven.text,setType);
                                                              controllerbreathSeven.clear();
                                                              controllerRepsSeven.clear();
                                                              setState(() {
                                                                isLoadSeven = false;
                                                              });
                                                            },
                                                            child: Text("ADD SET",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600,
                                                                color: Color(0XFF2CB3BF),
                                                              ),),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                      ],
                                    )),
                                  ],
                                ),
                              ))
                            ] );
                        }),

                    SizedBox(height: 10,),

                    TextButton(
                      child: Text('Add Exercise',
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddExerCise()));},),

                  ],
                );
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
      ),
    );
  }
}