import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/AppConstant.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchClients.dart';
import 'package:tws/apiService/apimanager.dart';
import 'package:tws/apiService/sharedprefrence.dart';
import 'package:tws/chat/newChatScreen.dart';
import 'package:tws/screen/newprofile.dart';

class MyClient extends StatefulWidget {
  @override
  _MyClientState createState() => _MyClientState();
}

class _MyClientState extends State<MyClient> {
  List<DataFetchClients> data;
  @override
  void initState() {
    Provider.of<ApiManager>(context, listen: false).fetchProfileApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0XFF2CB3BF),
        // centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(
                  context: context, delegate: CustomSearchDelegate(data));
            },
          ),
        ],
        title: Text(
          "Clients",
          style: TextStyle(
              fontSize: 22 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<ApiManager>(context).fetchClientsApi(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (snapshots.hasError) {
            return Text("${snapshots.error}");
          } else {
            if (snapshots.hasData) {
              ResponseFetchCleints response = snapshots.data;
              data = response.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ClientTile(data: data[index]);
                },
              );
            } else {
              return Center(
                child: Text(
                  "No clients attached yet",
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
    );
  }
}

class ClientTile extends StatelessWidget {
  const ClientTile({
    Key key,
    @required this.data,
  }) : super(key: key);

  final DataFetchClients data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () async {
          await SharedPrefManager.savePrefString(
              AppConstant.CREATEDIETUSERID, data.id);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NewProfile(data: data)));
        },
        leading: CircleAvatar(
            radius: 40,
            backgroundImage: data.image == null
                ? AssetImage("assets/images/user.png")
                : NetworkImage("http://fitnessapp.frantic.in/" + data.image)),
        title: Text(
          data.name,
          style: TextStyle(
              fontSize: 17 * MediaQuery.of(context).textScaleFactor,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        trailing: GestureDetector(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ChatScreenNew(id: data.id, name: data.name)));
            await SharedPrefManager.savePrefString(
                AppConstant.CREATEDIETUSERID, data.id);
          },
          child: Icon(
            Icons.message,
            size: 30,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.occupations == null ? "" : data.occupations,
              style: TextStyle(
                  fontSize: 15 * MediaQuery.of(context).textScaleFactor,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Color(0XFFC9C8CD),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<DataFetchClients> data;
  CustomSearchDelegate(this.data);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<DataFetchClients> matchQuery = [];
    if (query.isNotEmpty) {
      for (DataFetchClients item in data) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(item);
        }
      }
    }
    if (matchQuery.length == 0) {
      return Center(
        child: Text(
          "No results found",
          style: TextStyle(
              fontFamily: "Proxima Nova",
              fontWeight: FontWeight.w600,
              fontSize: 20 * MediaQuery.of(context).textScaleFactor),
        ),
      );
    } else
      return ListView.builder(
        itemCount: matchQuery == null ? 0 : matchQuery.length,
        itemBuilder: (context, index) {
          return ClientTile(data: data[index]);
        },
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<DataFetchClients> matchQuery = [];
    if (query.isNotEmpty) {
      for (DataFetchClients item in data) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(item);
        }
      }
    }
    if (matchQuery.length == 0 && query.isNotEmpty) {
      return Center(
        child: Text(
          "No results found",
          style: TextStyle(
              fontFamily: "Proxima Nova",
              fontWeight: FontWeight.w600,
              fontSize: 20 * MediaQuery.of(context).textScaleFactor),
        ),
      );
    } else
      return ListView.builder(
        itemCount: matchQuery == null ? 0 : matchQuery.length,
        itemBuilder: (context, index) {
          return ClientTile(data: data[index]);
        },
      );
  }
}
