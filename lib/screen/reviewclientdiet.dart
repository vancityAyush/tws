import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apimanager.dart';
import 'package:tws/fragment/reviewclientdietheading.dart';

class ReviewClientDiet extends StatelessWidget {
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
          "REVIEW CLIENT DIET",
          style: TextStyle(
              fontSize: 18 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<ApiManager>(context).reviewDietListApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data['data'].length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  // padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFF2CB3BF), width: 1),
                      borderRadius: BorderRadius.circular(6)),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReviewClientDietHeading(
                              dietId: snapshot.data['data'][index]['id'])));
                    },
                    title: Text(
                      snapshot.data['data'][index]['name'],
                      style: TextStyle(
                          fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF2CB3BF)),
                    ),
                    subtitle: Text(
                      '${snapshot.data['data'][index]['from_date']} to ${snapshot.data['data'][index]['to_date']}',
                      style: TextStyle(
                          fontSize: 13 * MediaQuery.of(context).textScaleFactor,
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
      ),
    );
  }
}
