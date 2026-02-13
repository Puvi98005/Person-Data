
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_test/fluttertoast.dart';
import 'package:demo_test/service/database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  Home({super.key});
  @override
  State<StatefulWidget> createState() => _Home();

}



class _Home extends State<Home>{
  
  TextEditingController username = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController imageurl = TextEditingController();

  Stream? personStream ;

  dynamic getInfoInit() async{
    personStream = await DatabaseHelper().getallBookinfo();
    setState(() {});
  }

  void initState(){
    super.initState();
    getInfoInit();
    
  }

  Widget allpersonInfo() 
  {
    return StreamBuilder( builder: (context , AsyncSnapshot snapshot){
     
      return snapshot.hasData? ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index){
             DocumentSnapshot documentSnapshot = snapshot.data.docs[index];

             return Container(
              margin: EdgeInsets.all(15),

              child: Material(

                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                
                
                
                child: Container(
                  
                  width: double.infinity,
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 131, 131, 130)),
                  
                 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.all(15),
                      child: Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.person_outlined , size: 30,),

                              InkWell(
                                onTap: (){
                                  username.text = documentSnapshot["Username"];
                                  phonenumber.text = documentSnapshot["Phone Number"];
                                  email.text = documentSnapshot["Email Id"];
                                  imageurl.text = documentSnapshot["Image URL"];
                                  editpersondetails(documentSnapshot["Id "]);
                                },
                                child: Icon(Icons.edit)),

                                InkWell(
                                  onTap: (){
                                    deletepersonData( context, documentSnapshot["Id "]);
                                  },
                                  child: Icon(Icons.delete_forever)),
                            ]
                            
                            ),
                            SizedBox(height: 20,),
                          buildRow("Username", documentSnapshot["Username"]),
                          buildRow("Phone No", documentSnapshot["Phone Number"]),
                          buildRow("Email", documentSnapshot["Email Id"]),
                          buildRow("Image Url", documentSnapshot["Image URL"]),
                      
                        ],
                      ),
                    ),
                  ],
                  ) ,
                  )
                ),
             );
         } 
         ,):  Container();
             

    }, 
    stream: personStream,); }

    Widget buildRow(String title, String value) {
      return Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  const SizedBox(width: 120),

              SizedBox(width: 120,child: Text(title, style: TextStyle(fontSize: 18, color: Colors.white),),),

              const Text(  " :  ", style: TextStyle(fontSize: 18,color: Colors.white, ),),

              Expanded(child: Text(value, style: TextStyle(fontSize: 18, color: Colors.white)))
          ],
        ),

      );
    }
    
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Person Details" , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 1, 55)),),
      actions: [
        IconButton(onPressed: (){
        Navigator.pushReplacementNamed(context, "/login" );
        }, icon: Icon(Icons.logout_outlined)),
      ],),
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: allpersonInfo()),
         
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
           Navigator.pushNamed(context, "/persondetails");
      }, child: Icon(Icons.add),),
    );
  }


Future editpersondetails(String id) {

  return showDialog(context: context, builder: ( context) => AlertDialog(

    content: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Username" , style: TextStyle(fontSize: 20,),),
              SizedBox(height: 10,),
              TextField(
                controller: username,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 20,),
        
              Text("Phone Number" , style: TextStyle(fontSize: 20,),),
              SizedBox(height: 10,),
              TextField(
                controller: phonenumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter your Phone number",
                  prefixIcon: Icon(Icons.phone_android),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 20,),
        
              Text("Email" , style: TextStyle(fontSize: 20,),),
              SizedBox(height: 10,),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 20,),
        
              Text("Image Url" , style: TextStyle(fontSize: 20,),),
              SizedBox(height: 10,),
              TextField(
                controller: imageurl,
                decoration: InputDecoration(
                  hintText: "Enter your image url",
                  prefixIcon: Icon(Icons.image_rounded),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              
              SizedBox(height: 20,),

              Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      ElevatedButton(onPressed: (){
                        Navigator.pushNamed(context, "/home" );
                      }, child: const Text("Cancel")),

                      ElevatedButton(onPressed: () async{
                         
                         String enteredEmail = email.text.trim();
                         String enterdphonenumber = phonenumber.text.trim();

                         if(!enteredEmail.endsWith("@gmail.com")){
                          Message.show(message: "gmail must end with @gmail.com");
                          email.clear();
                          return ;
                         }
                       
                       RegExp phoneRegex = RegExp(r'^[0-9]+$');

                       if(!phoneRegex.hasMatch(enterdphonenumber)){
                          Message.show(message: "Phone number must contain only digits");

                          phonenumber.clear();
                          return;
                       }

                      Map<String, dynamic> updateDetails ={
                           "Username" : username.text,
                           "Phone Number" : phonenumber.text,
                           "Email Id" : email.text,
                           "Image URL" : imageurl.text,
                           "Id " : id,
                      };

                      await DatabaseHelper().Updatebooksdetails(id, updateDetails).then((value){
                        
                        if(value == "Data Updated Succesfully!"){
                          Message.show(message: "Data Updated Succesfully!");
                          Navigator.of(context).pop();

                        }
                      });

                      }, child: const Text("Update")),

                      
                  ],
                ),
              )
        ],
      ),
    ),
    
  ));

}

void deletepersonData(BuildContext context,String id) async{
    showDialog(context: context, builder: (BuildContext context){

       return AlertDialog(
        title: Text("Confirm Deletion"),

        content: Text("Are you sure want to delete?"),
        actions: [
          
          TextButton(onPressed: (){
             //Navigator.pushNamed(context, "/home" );
              Navigator.of(context).pop();
          }, child: const Text("No")), 

          TextButton(onPressed: () async{
             await DatabaseHelper().deleteBookinfo(id);
            Navigator.of(context).pop();
             
          } , child: const Text("Yes")),
        ],
       );


    }, );
}
}