import 'package:flutter/material.dart';
import 'package:notes_app/controller/HelperSql.dart';
import 'package:notes_app/view/AddNewScreen.dart';

import '../constants.dart';
import 'InfoOfNoteScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelperSql.db.then((value) {
      print("Display where is database ================>");
      print(value);
      /* HelperSql.getallrowDB().then((value2) {
        print("Display data ================>");
        print(value2);
      });*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(fontSize: titleappbarFont, color: appColor),
        ),
        elevation: 5,
        centerTitle: true,
        backgroundColor: appbarColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: HelperSql.getallrowDB(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(child: Text("There's No Data To Show",style: TextStyle(fontSize: titleFont)));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: listtileColor,
                      child: ListTile(

                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return InfoOfNoteScreen.ALL(
                              ID: snapshot.data[index].ID,
                              Title: snapshot.data[index].Title,
                              Date: snapshot.data[index].Date,
                              Description: snapshot.data[index].Description,
                            );
                          }));
                        },
                        title: Text(
                          "${snapshot.data[index].Title}",
                          style: TextStyle(color: appColor,fontWeight: FontWeight.bold,fontSize:titleFont, ),
                        ),
                        subtitle: Text(
                          "${snapshot.data[index].Date}",
                          style: TextStyle(color: appColor,fontSize: subtitleFont),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              HelperSql.deleteDB(snapshot.data[index].ID);
                            });
                          },
                          icon: Icon(Icons.delete),
                          iconSize: deleteSize,
                          color: appColor,
                        ),
                      ),
                    );
                  },
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appbarColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return AddNewScreen();
          }));
        },
        child: Icon(
          Icons.add,
          color: appColor,
        ),

      ),
    );
  }
}
