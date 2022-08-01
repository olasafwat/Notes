import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:notes_app/controller/HelperSql.dart';
import 'package:notes_app/view/HomeScreen.dart';
import 'dart:ui';
import '../constants.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({Key? key}) : super(key: key);

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  String? Title, DesNote;
  late DateTime Date = DateTime.now();


  @override
  void initState() {
    super.initState();
    print("initState selectedDate = ${Date.toLocal()}");
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
          leading: IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_rounded),color: appColor,),
          elevation: 5,
          centerTitle: true,
          backgroundColor: appbarColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 18,
            ),

          //Title
            Padding(
              padding: const EdgeInsets.all(5.5),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Title",
                    hintText: "Enter Title",
                    labelStyle: TextStyle(color: appColor),
                    helperStyle: TextStyle(color: appColor),
                    fillColor: appColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.teal)),

                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.yellow)),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.pinkAccent))),
                onChanged: (value) {
                  setState(() {
                    Title = value;
                  });
                },
              ),
            ),
            SizedBox(height: 18),

          //Date
            Padding(
              padding: const EdgeInsets.all(5.5),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(Date.year, Date.month, Date.day),
                      maxTime: DateTime(2035, 1, 1),

                      onChanged: (date) {
                    setState(() {
                      Date = date;
                    });

                        print('change $Date');
                    },
                      onConfirm: (date) {
                        setState(() {
                          Date = date;
                        });
                       print('confirm $Date');
                  },
                      currentTime: DateTime.now(), locale: LocaleType.en);
                },
                controller:
                    TextEditingController(text: "${Date.toLocal()}"),
                decoration: InputDecoration(
                    labelText: "Date",
                    hintText: "Enter Date",
                    labelStyle: TextStyle(color: appColor),
                    helperStyle: TextStyle(color: appColor),
                    fillColor: appColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.teal)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.yellow)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.pinkAccent))),
              ),
            ),
            SizedBox(height: 18),

          //Note
            Padding(
              padding: const EdgeInsets.all(5.5),
              child: TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: "Note",
                    alignLabelWithHint: true,
                    hintText: "Enter Note",
                    labelStyle: TextStyle(color: appColor),
                    helperStyle: TextStyle(color: appColor),
                    fillColor: appColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.teal)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.yellow)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.pinkAccent))),
                onChanged: (value) {
                  DesNote = value;
                },
              ),
            ),

          //Button Add
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(appbarColor)
                  ),
                  onPressed: () {
                    HelperSql.insertDB(
                      {
                        "Description": "$DesNote",
                        "Title": "$Title",
                        "Date": "$Date",
                      }).then((value) {
                      print("value");
                      print(value);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                        return HomeScreen();
                      }));
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    size: addSize,
                    color: appColor,
                  ),
                  label: Text("Add",style: TextStyle(color: appColor),)),
            )
          ],
        ));
  }
}
