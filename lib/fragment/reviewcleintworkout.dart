import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchClientWorkout.dart';
import 'package:tws/apiService/apimanager.dart';
import 'package:tws/fragment/reviewtrainertemplate.dart';

class ReviewClientWorkOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            )),
        backgroundColor: Color(0XFF2CB3BF),
        title: Text(
          "REVIEW CLIENT WORKOUT",
          style: TextStyle(
              fontSize: 18 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: FutureBuilder(
          future: Provider.of<ApiManager>(context).fetchCleintWorkoutApi(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (snapshots.hasError) {
              return Text("${snapshots.error}");
            } else {
              if (snapshots.hasData) {
                ResponseFetchClientWorkout response = snapshots.data;
                List<Data> data = response.data;
                return ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0XFF2CB3BF), width: 1),
                          borderRadius: BorderRadius.circular(6)),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReviewTrainerTemplate(
                                  date: data[index].fromDate,
                                  workoutId: data[index].id)));
                        },
                        title: Text(
                          data[index].title,
                          style: TextStyle(
                              fontSize:
                                  18 * MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF2CB3BF)),
                        ),
                        subtitle: Text(
                          data[index].fromDate,
                          style: TextStyle(
                              fontSize:
                                  13 * MediaQuery.of(context).textScaleFactor,
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
                return Center(
                  child: Text(
                    "",
                    style: TextStyle(
                        fontFamily: "Proxima Nova",
                        fontWeight: FontWeight.w600,
                        fontSize: 20 * MediaQuery.of(context).textScaleFactor),
                  ),
                );
              }
            }
          }),
    );
  }
}
