import 'package:flutter/material.dart';
import 'package:tws/fragment/addexercise.dart';

class NewWorkOutTemplate extends StatelessWidget {
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
          "New Workout Template",
          style: TextStyle(
              fontSize: 16 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 8, bottom: 0, right: 20, left: 20),
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
                      "Exercise Title",
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
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Color(0XFF262626)),
                    decoration: InputDecoration(
                      fillColor: Color(0XFFF2F2F2),
                      filled: true,
                      border: InputBorder.none,
                      hintText: "",
                    ),
                    onSaved: (String value) {},
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddExerCise()));
                    },
                    child: Text(
                      "ADD EXERCISE",
                      style: TextStyle(
                          fontSize: 17 * MediaQuery.of(context).textScaleFactor,
                          color: Color(0XFF2CB3BF),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
