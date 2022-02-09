
class Note{
  String userId;
  String title;
  String myNote;
  Note(String userid,  String title, String note){
    this.userId = userid;
    this.title = title;
    this.myNote = note ;
  }

  Note.fromJson(Map<String, dynamic> json)
      : userId = json["userId"],
        title = json["title"],
        myNote = json["note"];

   Map<String, dynamic> toJson() => {
     "userId" : userId,
     "title" :title,
     "note" : myNote
   };

}