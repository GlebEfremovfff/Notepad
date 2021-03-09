import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/mainmenu/note_list/change_note.dart';
import 'package:notepad/mainmenu/note_list/files_area/database_helper.dart';
import 'package:notepad/mainmenu/note_list/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  NoteList({Key key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    updateListView();
    return ListView.builder(
      itemCount: noteList.length,
      itemBuilder: (BuildContext context, int pos) {
        return Dismissible(
          key: Key(noteList[pos].title),
          background: slideLeftBackground(),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              final bool res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Are you sure wanna delete this?"),
                      actions: <Widget>[
                        FlatButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              return Navigator.of(context).pop();
                            }),
                        FlatButton(
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () {
                            _deleteNote(context, noteList[pos]);
                            return Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }
          },
          child: Card(
            color: Colors.black,
            elevation: 2.0,
            shadowColor: Colors.black26,
            child: ListTile(
              title: Text(
                noteList[pos].title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
              ),
              trailing: GestureDetector(
                child: getPriorityStar(noteList[pos].isPrioritied),
                onTap: () {
                  this.noteList[pos].isPrioritied == 1
                      ? this.noteList[pos].isPrioritied = 0
                      : this.noteList[pos].isPrioritied = 1;
                  _update(noteList[pos]);
                  updateListView();
                },
              ),
              onTap: () {
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ChangeNote(noteList[pos])));
              },
            ),
          ),
        );
      },
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red[700],
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.black,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Icon getPriorityStar(int isPrioritied) {
    if (isPrioritied == 1) {
      return Icon(
        Icons.star,
        color: Colors.red[900],
        size: 30,
      );
    } else {
      return Icon(
        Icons.star,
        color: Colors.white,
        size: 30,
      );
    }
  }

  void _update(Note note) async {
    int result;
    result = await databaseHelper.updateNote(note);
  }

  void _deleteNote(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String mess) {
    final snackBar = SnackBar(
        content: Text(
      mess,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initDb();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
