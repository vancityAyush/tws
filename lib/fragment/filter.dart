import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight) / 10;

    final double itemWidth = size.width / 2;

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
          "Filter",
          style: TextStyle(
              fontSize: 16 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Category",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            GridView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (itemWidth / itemHeight),
                // controller: new ScrollController(keepScrollOffset: false),
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color(0XFFC9E6FA)),
                  margin: EdgeInsets.only(left: 10, right: 10, top: 13),
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 4, bottom: 4),
                  child: Center(
                    child: Text(
                      "Barbell",
                      style: TextStyle(fontSize: 13, color: Color(0XFF262626)),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
