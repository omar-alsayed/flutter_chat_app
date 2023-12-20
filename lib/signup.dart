import 'package:chatapp_php/conn.dart';
import 'package:chatapp_php/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

final _mybox=Hive.box('info_user');

var lst=[];

conn con=conn();

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();

}

class _signupState extends State<signup> {
  


late TextEditingController username;
late TextEditingController password;
late TextEditingController email;

var isusernameempty=true;
var ispasswordempty=true;
var isemailempty=true;

var check;
  
  
Future<dynamic> check_user(user,pass,emaill)async {
final connection=con.Postgre_connection;

await connection.open();
final results = await connection.query("select count(*) from users where username='$user'");

// if(results.first.first==0 && results.first.first==1){
if(results.first.first==1){
check= "user already taken";
}

else{
  
  print("signup done");
  
  await connection.query("insert into users(username,password,email) values('$user','$pass','$emaill')");
    
  _mybox.put('info_user',user);
  
  
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const sec_screen()),
);
               


}
await connection.close();
}
  
  
  
@override
void initState(){
  super.initState();
  username=TextEditingController();
  password=TextEditingController();
  email=TextEditingController();

}
  
  @override
  void dispose() {
    username.dispose();
    password.dispose();
    email.dispose();

    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    print(_mybox.get('info_user'));
    return Container(
      width: double.infinity,
      height: double.infinity,
      color:Color.fromARGB(255, 12, 12, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:30),
            child: Text("signup",style: TextStyle(color:Colors.white,fontSize: 50)),
          ),
          
          
            Padding(
              padding: const EdgeInsets.all(15.0),
              child:
              ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container( 
                color: Color.fromARGB(173, 17, 17, 17),
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextField(
                     onChanged: (value) {
                        check=null;
                        value.isNotEmpty?isusernameempty=false:isusernameempty=true;

                        setState(() {});
                      },
                    controller: username,
                    decoration: InputDecoration(
                      labelText: "username",
                      labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                    border: InputBorder.none,
                    enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 0.0))),
                    style: TextStyle(color:Colors.white),
                    cursorColor:Colors.white),
                )),
            ),
          ),
          
          
          Padding(
              padding: const EdgeInsets.all(15.0),
              child:
              ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container( 
                color: Color.fromARGB(173, 17, 17, 17),
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextField(
                    onChanged: (value) {
                    value.isNotEmpty?ispasswordempty=false:ispasswordempty=true;
                    setState(() {});
                    },
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration( 
                      labelText: "password",
                      labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 0.0))),
                    style: TextStyle(color:Colors.white),
                    cursorColor:Colors.white),
                )),
            ),
          )
          
          ,
           Padding(
              padding: const EdgeInsets.all(15.0),
              child:
              ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container( 
                color: Color.fromARGB(173, 17, 17, 17),
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextField(
                    onChanged: (value) {
                      value.isNotEmpty?isemailempty=false:isemailempty=true;
                      setState(() {});
                    },
                    controller: email,
                    decoration: InputDecoration( 
                      labelText: "email",
                      labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 0.0))),
                    style: TextStyle(color:Colors.white),
                    cursorColor:Colors.white),
                )),
            ),
          )
          ,
          
          
          
          Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(check!=null?'$check':'',style: TextStyle(fontSize: 15,color: Colors.red),)),
            ),
          
          
          
          SizedBox(height: 30)
          ,
            Container(
              width: 380,
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onSurface: Colors.purple,
              primary: Colors.purple),
              
              
                onPressed: !isusernameempty&&!ispasswordempty&&!isemailempty?
                ()async{
                  setState(() {});
                 await check_user(username.text,password.text,email.text);
                }:null,
                 child: Text("signup" , style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),)),
            ),

          
        ],
      ),
    );
  }
}