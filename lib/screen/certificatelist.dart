import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchCertificate.dart';
import 'package:tws/apiService/apimanager.dart';
import 'package:tws/main.dart';
import 'package:tws/screen/achievements.dart';

class CertificateList extends StatefulWidget {
  @override
  _CertificateListState createState() => _CertificateListState();
}

class _CertificateListState extends State<CertificateList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigatorKey.currentState.pushReplacement(
            MaterialPageRoute(builder: (context) => Achivements()));
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF2CB3BF),
          title: Text(
            "Certificate",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        body: FutureBuilder(
          future: Provider.of<ApiManager>(context).fetchCertificateApi(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (snapshots.hasError) {
              return Text("${snapshots.error}");
            } else {
              if (snapshots.hasData) {
                ResponseFetchCertificate response = snapshots.data;
                List<Data> data = response.data;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 10,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: GestureDetector(
                                      child: Image.network(
                                        "http://fitnessapp.frantic.in/" +
                                            data[index].image,
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.cover,
                                      ),
                                      onTap: () {
                                        print('ok');
                                        showDialog(
                                          context: context,
                                          builder: (context) => imageDialog(
                                              data[index].description,
                                              "http://fitnessapp.frantic.in/" +
                                                  data[index].image,
                                              context),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  data[index].description,
                                  style: TextStyle(
                                      fontSize: 14 *
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible: false,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            data[index].organisationName,
                                            style: TextStyle(
                                                fontSize: 17 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF76787B)),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            Provider.of<ApiManager>(context,
                                                    listen: false)
                                                .deleteCertificateApi(
                                                    data[index].id.toString());
                                          });
                                        },
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Icon(
                                                Icons.delete,
                                                size: 30,
                                              ),
                                            )),
                                      ),
                                      Visibility(
                                        visible: false,
                                        child: GestureDetector(
                                          onTap: () async {
                                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCertificate(data[index].description,data[index].id)));
                                          },
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 30,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  )),

                              /*Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: Icon(Icons.double_arrow),
                              )*/
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text(
                    "No certificate added",
                    style: TextStyle(
                        fontFamily: "Proxima Nova",
                        fontWeight: FontWeight.w600,
                        fontSize: 20 * MediaQuery.of(context).textScaleFactor),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget imageDialog(text, path, context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      // elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   '$text',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            child: Image.network(
              '$path',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
