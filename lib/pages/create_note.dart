import 'package:flutter/material.dart';
import 'package:notepad/models/note_model.dart';
import 'package:notepad/services/prefs_service.dart';
import 'package:notepad/services/rtdb_service.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key key}) : super(key: key);
  static const String id = "create_note";

  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {

  var titleController = TextEditingController();
  var noteController = TextEditingController();

   addNote() async{

     String title = titleController.text.toString();
     String content = noteController.text.toString();

     if(title.isEmpty || content.isEmpty) return;

     var id = await Prefs.loadUserId();
     RTDBService.addPost(Note(id, title, content)).then((response) => {
       _getResponse()
     });
   }

   _getResponse(){
     Navigator.of(context).pop({"data" : "done"});
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("Create New Note", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body:  Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.color) ,
              image: AssetImage("assets/images/back_notes2.jpg"),
              fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: TextField(

                  controller: titleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "  Title",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: TextField(
                  controller: noteController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "  New note",
                  ),
                ),
              ),
               Container(
                 child: ElevatedButton(
                   style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                   ),
                  
                   onPressed: addNote,
                   child: Text("Add"),
                 ),
               )
            ],
          ),
        ),
    );
  }
}
