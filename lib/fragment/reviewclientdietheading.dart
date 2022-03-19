import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apimanager.dart';

class ReviewClientDietHeading extends StatefulWidget {
  final String dietId;

  ReviewClientDietHeading({this.dietId});

  @override
  _ReviewClientDietHeadingState createState() =>
      _ReviewClientDietHeadingState();
}

class _ReviewClientDietHeadingState extends State<ReviewClientDietHeading> {
  Widget get listTile {
    return FutureBuilder(
        future:
            Provider.of<ApiManager>(context).reviewDietDatesApi(widget.dietId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data['data'].length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTileWidget(
                      date: snapshot.data['data'][index],
                      id: widget.dietId,
                      indexes: index);
                });
          } else {
            return Text("d");
          }
        });
  }

  bool status = false;

  List<bool> newStatus = [];
  var date;

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
          "Review Client Diet",
          style: TextStyle(
              fontSize: 18 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
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
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Calories",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0XFF262626)),
                                ),
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
                            "0 kcal",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFF262626)),
                          ),
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
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "0 gm",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color(0XFF262626)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "0 gm",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color(0XFF262626)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "0 gm",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color(0XFF262626)),
                          ),
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
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Color(0XFFFC9C84),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Protein",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0XFF262626)),
                              ),
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
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Carbs",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0XFF262626)),
                              ),
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
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Fats",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0XFF262626)),
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
            listTile
          ],
        ),
      ),
    );
  }
}

class ListTileWidget extends StatefulWidget {
  final String date, id;
  final int indexes;
  ListTileWidget({this.date, this.id, this.indexes});

  @override
  _ListTileWidget createState() => _ListTileWidget();
}

class _ListTileWidget extends State<ListTileWidget> {
  // This is for individual ListTile reference
  bool isSelected = false;
  var dates;

  Widget get foodlistTile {
    return Column(
      children: [
        ListTile(
          // title: Text("snapshot.data['data'][index]",style: TextStyle(
          title: Text(
            widget.date,
            style: TextStyle(
                fontSize: 19 * MediaQuery.of(context).textScaleFactor,
                color: Color(0XFF2CB3BF),
                fontWeight: FontWeight.w600),
          ),
          subtitle: Text("Calories: 0 Kcal",
              style: TextStyle(
                  fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                  fontWeight: FontWeight.normal,
                  color: Color(0XFF484848))),
          trailing: GestureDetector(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
                dates = widget.date;
              });
            },
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 50,
              color: Color(0XFF2CB3BF),
            ),
          ),
        ),
        isSelected
            ? FutureBuilder(
                future: Provider.of<ApiManager>(context, listen: false)
                    .reviewDietByDatesApi(widget.id, dates),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, mealIndex) {
                        return FoodList(
                            mealIndex: mealIndex,
                            name: snapshot.data['data'][mealIndex]['meal']
                                ['name'],
                            lengthFood:
                                snapshot.data['data'][mealIndex]['food'].length,
                            snapshot: snapshot.data['data']);
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
            : Container(),

        /*FoodList(isSelected : isSelected),*/
      ],
    );
  }

  /*Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          ListTile(
            // title: Text("snapshot.data['data'][index]",style: TextStyle(
            title: Text(widget.date,style: TextStyle(
                fontSize: 19*MediaQuery.of(context).textScaleFactor,
                color: Color(0XFF2CB3BF),
                fontWeight: FontWeight.w600
            ),),
            subtitle: Text("Calories: 0 Kcal",
              style: TextStyle(
                  fontSize: 16*MediaQuery.of(context).textScaleFactor,
                  fontWeight: FontWeight.normal,
                  color: Color(0XFF484848)
              ),),
            trailing: GestureDetector(
              onTap:(){
                setState(() {
                  isSelected = !isSelected;
                  dates = widget.date;
                });
              },
              child: Icon(Icons.keyboard_arrow_down,size: 50,
                color: Color(0XFF2CB3BF),),
            ),
          ),

          isSelected ? FutureBuilder(
            future: Provider.of<ApiManager>(context,listen: false).reviewDietByDatesApi(widget.id, dates),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context,mealIndex){
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 4),
                      child: Card(
                        elevation: 11,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(

                                  leading: Text(snapshot.data['data'][mealIndex]['meal']['name'],

                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0XFF262626),
                                      fontWeight: FontWeight.w600,
                                    ),),

                                  trailing: GestureDetector(
                                    onTap:(){
                                      setState(() {
                                        isSelected = !isSelected;
                                        dates = widget.date;
                                      });
                                    },
                                    child: Icon(Icons.keyboard_arrow_down,size: 50,
                                      color: Color(0XFF2CB3BF),),
                                  ),

                                ),
                              ),

                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data['data'][mealIndex]['food'].length,
                                  itemBuilder: (context,i){
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 12.0,right: 12,top: 7),
                                      child: Card(
                                        elevation: 11,
                                        child: ListTile(
                                          title: Text(snapshot.data['data'][mealIndex]['food'][i]['name'],
                                            style: TextStyle(
                                              fontSize: 18*MediaQuery.of(context).textScaleFactor,
                                              color: Color(0XFF2CB3BF),
                                              fontWeight: FontWeight.w600,
                                            ),),
                                          subtitle: Text("Total Calories: 100 kcal",
                                            style: TextStyle(
                                                fontSize: 16*MediaQuery.of(context).textScaleFactor,
                                                fontWeight: FontWeight.normal,
                                                color: Color(0XFF484848)
                                            ),),
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ): Container()
        ]
    )*/

  @override
  Widget build(BuildContext context) {
    return foodlistTile;
  }
}

class FoodList extends StatefulWidget {
  List snapshot;
  int mealIndex, lengthFood;
  String name, nameFood;
  FoodList({this.mealIndex, this.name, this.lengthFood, this.snapshot});

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 4),
        child: Card(
          elevation: 11,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: ListTile(
                    leading: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0XFF262626),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        setState(() {
                          status = !status;
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 50,
                        color: Color(0XFF2CB3BF),
                      ),
                    ),
                  ),
                ),
                status
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.lengthFood,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12, top: 7),
                            child: Card(
                              color: widget.snapshot[widget.mealIndex]['food']
                                          [i]['isTaken'] ==
                                      false
                                  ? widget.snapshot[widget.mealIndex]['food'][i]
                                                  ['created_by']
                                              .toString() ==
                                          "USER"
                                      ? Color(0XFF2CB3BF)
                                      : Colors.white
                                  : Color(0XFFCDE9FF),
                              elevation: 11,
                              child: ListTile(
                                title: Text(
                                  widget.snapshot[widget.mealIndex]['food'][i]
                                      ['name'],
                                  style: TextStyle(
                                    fontSize: 18 *
                                        MediaQuery.of(context).textScaleFactor,
                                    color: widget.snapshot[widget.mealIndex]
                                                    ['food'][i]['created_by']
                                                .toString() ==
                                            "USER"
                                        ? Colors.white
                                        : Color(0XFF2CB3BF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  "Total Calories: 100 kcal",
                                  style: TextStyle(
                                      fontSize: 16 *
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0XFF484848)),
                                ),
                              ),
                            ),
                          );
                        })
                    : Container()
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
