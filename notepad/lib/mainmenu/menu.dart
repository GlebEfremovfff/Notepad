import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/mainmenu/note_list/new_note.dart';
import 'package:notepad/mainmenu/note_list/note.dart';
import 'package:notepad/mainmenu/note_list/note_list.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.black,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(bottom: 20),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        "Your Notepad",
                        style: TextStyle(fontSize: 25, color: Colors.yellow),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20, top: 10),
                      child: GestureDetector(
                        child: Icon(
                          Icons.add,
                          color: Colors.yellow,
                          size: 40,
                        ),
                        onTap: () {
                          return Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NewNote(Note(" ", " ", 0))));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(child: NoteList(), color: Colors.yellow[400]),
            ),
          ],
        ),
      ),
    );
  }
}
