class Note {
  int _id;
  String _title;
  String _message;
  int _isPrioritied;

  Note.withId(this._id, this._title, this._message, this._isPrioritied);
  Note(this._title, this._message, this._isPrioritied);

  int get id => _id;
  String get title => _title;
  String get message => _message;
  int get isPrioritied => _isPrioritied;

  set title(String newTitle) {
    this._title = newTitle;
  }

  set message(String newMessage) {
    this._message = newMessage;
  }

  set isPrioritied(int newIsPrioritied) {
    this._isPrioritied = newIsPrioritied;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['message'] = _message;
    map['isPrioritied'] = _isPrioritied;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._message = map['message'];
    this._isPrioritied = map['isPrioritied'];
  }
}
