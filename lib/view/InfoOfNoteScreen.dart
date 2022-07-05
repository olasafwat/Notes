import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui';
import '../constants.dart';

class InfoOfNoteScreen extends StatefulWidget {
  var ID;
  var Description;
  var Title;
  var Date;


  var url;


  InfoOfNoteScreen.URL(this.url);

  @override
  State<InfoOfNoteScreen> createState() => _InfoOfNoteScreenState();

  InfoOfNoteScreen.ALL({
    required this.ID,
    required this.Description,
    required this.Title,
    required this.Date,

  });
}

class _InfoOfNoteScreenState extends State<InfoOfNoteScreen> {


   void shareLink(String link)
  {
    Share.share(
        '${widget.Title}',
        subject: 'The Link Shared by News App');

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [

          //Title
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("${widget.Title}",style: TextStyle(fontSize: titleInfoFont,fontWeight: FontWeight.bold),),
            ),

          //Date
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("${widget.Description}",style: TextStyle(fontSize: subtitleInfoFont,)),
            ),

          //Note
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("${widget.Date}",style: TextStyle(fontSize: subtitleInfoFont,)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appbarColor,
        onPressed: () {
          shareLink("${widget.url}");
        },
        child: Icon(Icons.share,color:appColor),
      ),
    );
  }
}
