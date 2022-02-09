import 'package:flutter/material.dart';
import 'package:notepad/models/note_model.dart';
import 'package:notepad/pages/create_note.dart';
import 'package:notepad/services/auth_service.dart';
import 'package:notepad/services/prefs_service.dart';
import 'package:notepad/services/rtdb_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static final String  id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Note> items = [];
  List<String> colors = [];
  var timeNow ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetPost();
  }

  openCreateNote() async{
    Map results = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context){
        return new CreateNote();
      }
    ));
    if(results != null && results.containsKey("data")){
      print(results["data"]);
      _apiGetPost();
    }
  }

  _apiGetPost() async{
    var id = await Prefs.loadUserId();
    RTDBService.getPosts(id).then((notes) => {
      _respPosts(notes),
    });
  }

  _respPosts(List<Note> notes){

      setState(() {
        items = notes;
        timeNow = DateTime.now();
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("All Notes", style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            onPressed: (){
              AuthService.signOutUser(context);
            },
            icon: Icon(Icons.exit_to_app),)
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i){
          return _itemOfList(items[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        tooltip: "Add note",
        onPressed: openCreateNote,
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
  Widget _itemOfList(Note note){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent,
        border: Border.all(
          width: 1,
          color: Colors.grey
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(note.title, style: TextStyle(fontSize: 20),),
              IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.create,size: 17,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text(note.myNote, style: TextStyle(fontSize: 14),),
          SizedBox(height: 10,),
          Text("(${timeNow.year}:${timeNow.month}:${timeNow.day}) ${timeNow.hour}: ${timeNow.minute} PM",
          style: TextStyle(fontSize: 12),),
        ],
      ),
    );
  }
}
