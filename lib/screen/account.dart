import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:tws/apiService/AppConstant.dart';
import 'package:tws/apiService/sharedprefrence.dart';
import 'package:tws/dummypage.dart';
import 'package:tws/screen/achievements.dart';
import 'package:tws/screen/addtransformation.dart';
import 'package:tws/screen/membershippackage.dart';
import 'package:tws/screen/paymentdetails.dart';
import 'package:tws/screen/pdf_view_page.dart';
import 'package:tws/screen/profile.dart';

class AccountFragment extends StatefulWidget {
  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  var trainerCode, image, name;

  void referCode() async {
    trainerCode =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERCODE);
    image =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERIMAGE);
    name = await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERNAME);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        referCode();
      });
    });

    referCode();

    super.initState();
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0XFF2CB3BF),
        centerTitle: true,
        title: Text(
          "Account",
          style: TextStyle(
              fontSize: 22 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/spalsh.jpg"),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 90),
                        child: Card(
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        name.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      )),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text("Tws Code: " + trainerCode.toString()),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 53,
                          left: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Color(0XFFFFFFFF),
                            radius: 58,
                            backgroundImage: image == null
                                ? AssetImage("assets/images/spalsh.jpg")
                                : NetworkImage(
                                    "http://fitnessapp.frantic.in/" + image),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 8,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      leading: Image.asset(
                        "assets/images/user.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Profile",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Achivements()));
                      },
                      leading: Image.asset(
                        "assets/images/certificate.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Certificate",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> WorkOut()));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddTransformation()));
                      },
                      leading: Image.asset(
                        "assets/images/gallery.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Transformation Picture",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PaymentDetails()));
                      },
                      leading: Image.asset(
                        "assets/images/paymetdetail.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Payment Details",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MemberShipPackage()));
                      },
                      leading: Image.asset(
                        "assets/images/membership.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Membership Package",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      leading: Image.asset(
                        "assets/images/twsvirtual.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Tws Virtual Office",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => PDFViewPage(
                              title: "Terms & Conditions",
                              path: "assets/terms_and_condition.pdf",
                            ),
                          ),
                        );
                      },
                      leading: Image.asset(
                        "assets/images/terms.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Terms & Condition",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 1,
                        color: Color(0XFF838383)),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => PDFViewPage(
                              title: "FAQ",
                              path: "assets/faq.pdf",
                            ),
                          ),
                        );
                      },
                      leading: Image.asset(
                        "assets/images/faq.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "FAQ",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 1,
                        color: Color(0XFF838383)),
                    ListTile(
                      leading: Image.asset(
                        "assets/images/priv.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => DummyPage()));
                      },
                      leading: Image.asset(
                        "assets/images/priv.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Dummy Page",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () {
                        SharedPrefManager.clearPrefs();
                      },
                      leading: Image.asset(
                        "assets/images/logout.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
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
