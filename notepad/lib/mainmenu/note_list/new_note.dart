import 'package:flutter/material.dart';
import 'package:notepad/mainmenu/note_list/files_area/database_helper.dart';
import 'package:notepad/mainmenu/note_list/note.dart';
import 'package:notepad/mainmenu/animation/animation.dart';

class NewNote extends StatefulWidget {
  Note note;
  NewNote(this.note);

  @override
  State<StatefulWidget> createState() {
    return _NewNoteState(this.note);
  }
}

class _NewNoteState extends State<NewNote> {
  _NewNoteState(this.note);
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController titleContr = TextEditingController();
  TextEditingController messContr = TextEditingController();
  Note note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "New Note",
          style: TextStyle(color: Colors.yellow),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.yellow,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.save,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          setState(() {
            _save();
          });
        },
      ),
      body: Container(
        color: Colors.yellow[400],
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                controller: titleContr,
                scrollPadding: EdgeInsets.only(left: 15, right: 15),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                onChanged: (val) {
                  updateTitle();
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Message",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                  controller: messContr,
                  scrollPadding: EdgeInsets.only(left: 15, right: 15),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  maxLines: null,
                  expands: true,
                  onChanged: (val) {
                    updateMessage();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateTitle() {
    note.title = titleContr.text;
  }

  void updateMessage() {
    note.message = messContr.text;
  }

  void _save() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => AnimationMail()));
    int result;
    if (note.id == null) {
      result = await databaseHelper.insertNote(note);
    } else {
      result = await databaseHelper.updateNote(note);
    }
  }
}
