// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apiResponse/ResponseQuestion.dart';
import 'package:tws/apiService/apimanager.dart';

class QuestionFitness extends StatefulWidget {
  @override
  _QuestionFitnessState createState() => _QuestionFitnessState();
}

class _QuestionFitnessState extends State<QuestionFitness> {
  int selectQuestion = 0;

  void _trySubmit() async {
    setState(() {
      // _isLoad = true;
    });

    // await Provider.of<ApiManager>(context,listen: false).loginApi(_userNumber);

    setState(() {
      // _isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          centerTitle: true,
          title: Text(
            "Physical Question",
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
        body: FutureBuilder(
          future: Provider.of<ApiManager>(context).questionApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ResponseQuestion responseQuestion = snapshot.data;
              List<Data> response = responseQuestion.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: response.length,
                        itemBuilder: (context, index) {
                          selectQuestion = index + 1;

                          return Container(
                            padding: EdgeInsets.all(20),
                            // color: Colors.black87,
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Question " + selectQuestion.toString(),
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Color(0XFF2CB5C3),
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    response[index].question.question,
                                    style: TextStyle(
                                        wordSpacing: 1,
                                        height: 1.2,
                                        color: Color(0XFF363636),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    response[index].answer.toString(),
                                    style: TextStyle(
                                        wordSpacing: 1,
                                        height: 1.2,
                                        color: Color(0XFF363636),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
