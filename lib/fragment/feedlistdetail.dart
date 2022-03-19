import 'package:flutter/material.dart';

class FeedListDetail extends StatelessWidget {
  final String image, title, description;

  FeedListDetail({this.image, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0XFF2CB3BF),
        title: Text(
          "Feed Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "http://fitnessapp.frantic.in/" + image,
                height: 185,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 19 * MediaQuery.of(context).textScaleFactor,
                    color: Color(0XFF4B4B4B),
                    fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                description,
                style: TextStyle(
                    color: Color(0XFF737373),
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
