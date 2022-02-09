
import 'package:firebase_database/firebase_database.dart';
import 'package:notepad/models/note_model.dart';

class RTDBService{

  static final _database = FirebaseDatabase.instance.reference();

  static Future<Stream<Event>> addPost (Note note) async{
    _database.child("posts").push().set(note.toJson());
    return _database.onChildAdded;
  }

  static Future<List<Note>> getPosts(String id) async{
    List<Note> items = [];
    Query _query =_database.reference().child("posts").orderByChild("userId").equalTo(id);
    var  snapshot = await _query.once();
    var result = snapshot.value.values as Iterable;

    for(var item in result){
      items.add(Note.fromJson(Map<String, dynamic>.from(item)));
    }
    return items;
  }

  static Future<Stream<Event>> updatePost (Note note) async{
    Map<String, dynamic>  update = {"title" : note.title, "content" : note.myNote};
   _database.child("posts").update(update);
   return _database.onChildChanged;
  }


}