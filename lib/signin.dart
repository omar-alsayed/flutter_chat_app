import 'package:chatapp_php/conn.dart';
import 'package:chatapp_php/signup.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'main.dart';

final _mybox=Hive.box('info_user');

conn con=conn();

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
  
  
}

class _signinState extends State<signin> {
  


late TextEditingController username;
late TextEditingController password;

var check;

auth(user,pass){
  
  
}
  
Future<dynamic> check_user(user,pass)async {
final connection=con.Postgre_connection;
await connection.open();
final check_pass = await connection.query("select count(*) from users where username='$user' and password='$pass'");
final check_user_if_its_found = await connection.query("select count(*) from users where username='$user'");

  
 if(check_user_if_its_found.first.first==0)
check='wrong username';
// 'the useraname u entered is not found in our db';


else if(check_pass.first.first==0)
check='wrong password';
// "the password u entered is incorrect";




else{
  check='done';
  
  print("signin done");
      
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

}
  
  @override
  void dispose() {
    username.dispose();
    password.dispose();

    super.dispose();
  }
  
  var isusernameempty=false;
  var ispasswordempty=false;
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color:Color.fromARGB(255, 12, 12, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          
          SizedBox(height: 170),
          
          Container(
              width:width/1.3,
              height:350,
              color: Color.fromARGB(255, 12, 12, 12),
              child:
          Padding(
            padding: const EdgeInsets.only(bottom:20),
            child: Column(
                children: [
          
            Padding(
              padding: const EdgeInsets.only(bottom:20),
              child: Text("signin",style: TextStyle(color:Colors.white,fontSize: 50)),
            ),
            
            
              Padding(
                padding: const EdgeInsets.all(1.0),
                child:
                ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container( 
                  color: Color.fromARGB(173, 17, 17, 17),
                  width: width/1.3,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextField(
                       onChanged: (value) {
                        check=null;
                        value.isNotEmpty?isusernameempty=true:isusernameempty=false;
                        setState(() {});
                      },
                      controller: username,
                      decoration: InputDecoration(
                        hintText: "username",
                        hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      enabledBorder: const OutlineInputBorder(
                      )),
                      style: TextStyle(color:Colors.white),
                      cursorColor:Colors.white),
                  )),
              ),
            ),
            
            SizedBox(height: 8),
            
            Padding(
                padding: const EdgeInsets.all(1.0),
                child:
                ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container( 
                  color: Color.fromARGB(173, 17, 17, 17),
                  width:width/1.3,
                  height:50,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextField(
                      onChanged: (value) {
                        check=null;
                        value.isNotEmpty?ispasswordempty=true:ispasswordempty=false;
                        setState(() {});
                      },
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration( 
                      hintText: 'password',
                      hintStyle: TextStyle(color:Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      enabledBorder: const OutlineInputBorder(
                      )),
                      style: TextStyle(color:Colors.white),
                      cursorColor:Colors.white),
                  )),
              ),
            ),
                        
                        
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(check!=null?'$check':'',style: TextStyle(fontSize: 15,color: Colors.red),)),
            ),

            SizedBox(height: 30),
            
            Container(
              width: 380,
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
              onSurface: Colors.purple ,
              primary: Colors.purple),
              
              onPressed:isusernameempty&&ispasswordempty?()async{
                setState(() {});
                await check_user(username.text,password.text);}:null,
              child: Text("signin" , style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)))),
            
            ])),///2dn col and con
            ),
            
            
            
            
            
            
          SizedBox(height: 200),
          
          
          
           Container(
              color:  Color.fromARGB(255, 12, 12, 12),
              width: double.infinity,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                   Text("dont have an account?",style: TextStyle(
                        fontSize: 15,
                        fontWeight:FontWeight.w100,
                        color: Colors.white
                        )),
                  
                  TextButton(
                    
                    onPressed: (){
                    
Navigator.push(
context,
MaterialPageRoute(builder: (context) =>
      MaterialApp(
      home: SafeArea(
      child: Scaffold(
      appBar:AppBar(
      backgroundColor:Color.fromARGB(255, 12, 12, 12),
      leading: IconButton(
        iconSize: 50,
    onPressed: () {
      
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_left),
      ),
        ),
      body:signup()),
))));
                  }
                  
                  
                  , child: Text("signup" , style: TextStyle(color: Colors.purple),))
                  
                ],
              ),
            ),
          
          
        ]
      ),
    );
  }
}


