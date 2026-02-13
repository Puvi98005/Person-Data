import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseHelper{

 

  //add book details

  Future addbooksdetails(String id ,Map<String, dynamic> addData) async{
    try {
      await FirebaseFirestore.instance.collection("Users").doc(id).set(addData);
      return "Data Added Succesfully!";
  }
    catch(e){
      return e.toString();
    }
  }
  
   //get all books info
  Future<Stream<QuerySnapshot>> getallBookinfo() async{
    return await FirebaseFirestore.instance.collection("Users").snapshots();
  }

  //update 

  Future Updatebooksdetails(String id ,Map<String, dynamic> updateDetails) async{
    try {
      await FirebaseFirestore.instance.collection("Users").doc(id).update(updateDetails);
      return "Data Updated Succesfully!";
  }
    catch(e){
      return e.toString();
    }
  }
  //delete

  Future deleteBookinfo(String id) async{
    return await FirebaseFirestore.instance.collection("Users").doc(id).delete();
  }
}