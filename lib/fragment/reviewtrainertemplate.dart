import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apimanager.dart';

class ReviewTrainerTemplate extends StatelessWidget {

  String workoutId,date;

  ReviewTrainerTemplate({this.date,this.workoutId});

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
        title: Text("REVIEW CLIENT WORKOUT",style: TextStyle(
            fontSize: 18*MediaQuery.of(context).textScaleFactor,
            color: Colors.white
        ),),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0XFF2CB3BF),width: 1),
            borderRadius: BorderRadius.circular(6)
        ),
        child: FutureBuilder(
            future: Provider.of<ApiManager>(context).workoutReviewApi(date, workoutId),
            builder: (context,snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),);
              else if (snapshots.hasError) {
                return Text("${snapshots.error}");
              }else{
                if(snapshots.hasData){
                  return ListView.builder(
                      itemCount: snapshots.data['data'].length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(top: 12.0,left: 10,right: 10,bottom: 10),
                          child: snapshots.data['data'][index]['exercise']['exercise_id'] == "0" ?
                          Card(
                            elevation: 10,
                            child: Column(
                              children: <Widget>[

                                ListTile(
                                  title: Text(snapshots.data['data'][index]['exercise']['exercise_name'],style: TextStyle(
                                      fontSize: 20*MediaQuery.of(context).textScaleFactor,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF2CB3BF)
                                  ),),

                                  subtitle: Text(snapshots.data['data'][index]['exercise']['created_at'],style: TextStyle(
                                      fontSize: 13*MediaQuery.of(context).textScaleFactor,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF262626)
                                  ),),

                                  /*trailing: Container(
                                    width: 53,
                                    child: Row(
                                      children: [
                                        Icon(Icons.keyboard_arrow_down_outlined,
                                          color: Color(0XFF2CB3BF),),

                                        SizedBox(width: 5,),

                                        Icon(Icons.more_vert)
                                      ],
                                    ),
                                  ),*/
                                ),

                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshots.data['data'][index]['sets'].length,
                                    itemBuilder: (context,i){
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            if(snapshots.data['data'][index]['exercise']['exercise_name'].toString() == "Trademil")
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Total Km: "+snapshots.data['data'][index]['sets'][i]['sets']['km'].toString(),
                                                    style: TextStyle(color: Color(0XFF2CB3BF),
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600)),

                                                  if(snapshots.data['data'][index]['sets'][i]['sets']['level'] == "1.00")
                                                  TextSpan(
                                                      text: "    Intensity: "+"Slow",
                                                      style: TextStyle(color: Color(0XFF262626),
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w600)
                                                  )else if(snapshots.data['data'][index]['sets'][i]['sets']['level'] == "2.00")
                                                    TextSpan(
                                                        text: "    Intensity: "+"Medium",
                                                        style: TextStyle(color: Color(0XFF262626),
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600))
                                                  else
                                                    TextSpan(
                                                        text: "    Intensity: "+"Fast",
                                                        style: TextStyle(color: Color(0XFF262626),
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600))
                                                ],
                                              ),
                                            )
                                            else if(snapshots.data['data'][index]['exercise']['exercise_name'].toString() == "Cylcling")
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: "Total Km: "+snapshots.data['data'][index]['sets'][i]['sets']['km'].toString(),
                                                        style: TextStyle(color: Color(0XFF2CB3BF),
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600)),

                                                    if(snapshots.data['data'][index]['sets'][i]['sets']['level'] == "1.00")
                                                      TextSpan(
                                                          text: "    Intensity: "+"Slow",
                                                          style: TextStyle(color: Color(0XFF262626),
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w600)
                                                      )else if(snapshots.data['data'][index]['sets'][i]['sets']['level'] == "2.00")
                                                      TextSpan(
                                                          text: "    Intensity: "+"Medium",
                                                          style: TextStyle(color: Color(0XFF262626),
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w600))
                                                    else
                                                      TextSpan(
                                                          text: "    Intensity: "+"Fast",
                                                          style: TextStyle(color: Color(0XFF262626),
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w600))
                                                  ],
                                                ),
                                              )
                                            else
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: "Level: "+snapshots.data['data'][index]['sets'][i]['sets']['level'].toString(),
                                                        style: TextStyle(color: Color(0XFF2CB3BF),
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600)),

                                                    TextSpan(
                                                        text: "    Time: "+snapshots.data['data'][index]['sets'][i]['sets']['time'],
                                                        style: TextStyle(color: Color(0XFF262626),
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600)
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ],
                                        ),
                                      );
                                  }),
                              ],
                            ),
                          ):
                          Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(snapshots.data['data'][index]['exercise']['exercise_name'],style: TextStyle(
                                    fontSize: 20*MediaQuery.of(context).textScaleFactor,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF2CB3BF)
                                ),),

                                subtitle: Text(snapshots.data['data'][index]['exercise']['created_at'],style: TextStyle(
                                    fontSize: 13*MediaQuery.of(context).textScaleFactor,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF262626)
                                ),),

                                /*trailing: Container(
                                  width: 53,
                                  child: Row(
                                    children: [
                                      Icon(Icons.keyboard_arrow_down_outlined,
                                        color: Color(0XFF2CB3BF),),

                                      SizedBox(width: 5,),

                                      Icon(Icons.more_vert)
                                    ],
                                  ),
                                ),*/
                              ),

                              /*Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.access_time,size: 19,color: Colors.redAccent,),
                                        SizedBox(width: 3,),
                                        Text("12:57 MIN",style: TextStyle(
                                            fontSize: 12*MediaQuery.of(context).textScaleFactor,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF262626)
                                        ),),
                                      ],
                                    ),
                                    SizedBox(width: 14,),
                                    Row(
                                      children: [
                                        Icon(Icons.expand,size: 19,color: Colors.redAccent,),
                                        SizedBox(width: 3,),
                                        Text("5060 KG",style: TextStyle(
                                            fontSize: 12*MediaQuery.of(context).textScaleFactor,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF262626)
                                        ),),
                                      ],
                                    )
                                  ],
                                ),
                              ),*/

                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshots.data['data'][index]['sets'].length,
                                  itemBuilder: (context,i){
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: snapshots.data['data'][index]['sets'][i]['sets']['reps'].toString(),
                                                      style: TextStyle(color: Color(0XFF2CB3BF),
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                    TextSpan(
                                                        text: snapshots.data['data'][index]['sets'][i]['sets']['kg'] == "0.00" ? "" : " X "+snapshots.data['data'][index]['sets'][i]['sets']['kg'].toString()+" Kg",
                                                        style: TextStyle(color: Color(0XFF262626),
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600)
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 20,),
                                              Text(snapshots.data['data'][index]['sets'][i]['sets']['set_type'].toString()[0],
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600
                                              ),)
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  })

                            ],
                          ),
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
            }),
      ),
    );
  }
}