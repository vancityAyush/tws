import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchClients.dart';
import 'package:tws/apiService/apiResponse/ResponseQuestion.dart';
import 'package:tws/apiService/apimanager.dart';

class NewProfileTab extends StatefulWidget {
  DataFetchClients data;
  NewProfileTab(this.data);

  @override
  State<NewProfileTab> createState() => _NewProfileTabState();
}

class _NewProfileTabState extends State<NewProfileTab> {
  int selectQuestion = 0;
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController goal = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController contactDetails = TextEditingController();
  TextEditingController relationStatus = TextEditingController();

  void data() async {
    setState(() {
      name.text = widget.data.name;
      gender.text = widget.data.gender;
      age.text = widget.data.dob;
      weight.text = widget.data.weight;
      height.text = widget.data.height;
      goal.text = widget.data.goal;
      occupation.text = widget.data.occupations;
      relationStatus.text = widget.data.relationshipStatus;
      // contactDetails.text = widget.data.co;
    });
  }

  @override
  void initState() {
    data();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    age.dispose();
    gender.dispose();
    weight.dispose();
    height.dispose();
    goal.dispose();
    occupation.dispose();
    relationStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                  radius: 48,
                  backgroundImage: widget.data.image == null
                      ? AssetImage("assets/images/user.png")
                      : NetworkImage(
                          "http://fitnessapp.frantic.in/" + widget.data.image)),
            ),
            Container(
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
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(22),
                    topLeft: Radius.circular(22)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Basic Profile",
                        style: TextStyle(
                            fontSize:
                                18 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF2CB3BF),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: name,
                      autovalidateMode: AutovalidateMode.always,
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
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Age",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: gender,
                            autovalidateMode: AutovalidateMode.always,
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
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: age,
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.always,
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Weight",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Height",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: weight,
                            autovalidateMode: AutovalidateMode.always,
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
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: height,
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.always,
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Goal",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Occupations",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: goal,
                            autovalidateMode: AutovalidateMode.always,
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
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: occupation,
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.always,
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Contact Details",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Relationship Status",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.always,
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
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: relationStatus,
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.always,
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Visibility(
                      visible: false,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 15, right: 15),
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: Center(
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                  fontSize: 21 *
                                      MediaQuery.of(context).textScaleFactor,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0XFF299FAB),
                          ),
                        ),
                      ),
                    ),
                    FutureBuilder(
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
                                                "Question " +
                                                    selectQuestion.toString(),
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Color(0XFF2CB5C3),
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                response[index]
                                                    .question
                                                    .question,
                                                style: TextStyle(
                                                    wordSpacing: 1,
                                                    height: 1.2,
                                                    color: Color(0XFF363636),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            response[index]
                                                        .answer
                                                        .selectedOption ==
                                                    null
                                                ? Text("")
                                                : Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      response[index]
                                                          .answer
                                                          .selectedOption,
                                                      style: TextStyle(
                                                          wordSpacing: 1,
                                                          height: 1.2,
                                                          color:
                                                              Color(0XFF363636),
                                                          fontWeight:
                                                              FontWeight.w400),
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
