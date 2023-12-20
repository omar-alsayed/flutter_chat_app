import 'package:chatapp_php/chat_page.dart';
import 'package:chatapp_php/conn.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
final _mybox=Hive.box('info_user');

conn con=new conn();
var usernamefromuserpage;
var idfromuserspage;


class users_page extends StatefulWidget {
  const users_page({super.key});

  @override
  State<users_page> createState() => _users_pageState();

}

class _users_pageState extends State<users_page> {
  
  
  String username=_mybox.get('info_user');
  
   final getusers= Supabase.instance.client
  .from('users')
  .stream(primaryKey:['id']);
  

  final randomid='${Uuid().v4()}';//genrate random id 
  
  
  check_the_user(selecteduser)async{
    
final connection=con.Postgre_connection;
    
await connection.open();


final results = await connection.query("select * from who_chat_with where fromuser='$username' and touser='$selecteduser'or fromuser='$selecteduser' and touser='$username'");


if(results.length==1){
idfromuserspage=results[0][4];
}


else{
await Supabase.instance.client
    .from('who_chat_with')
    .insert({'fromuser':'$username' ,'touser':'$selecteduser','messages_id':'$randomid'});
    idfromuserspage=randomid;
    
}



}
  
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 97, 25, 110),
        title: Center(
          child:Text("users"))),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: StreamBuilder(
          stream: getusers,
          builder: (context,snapshot){
            if(snapshot.data!=null){
            var list=snapshot.data;
            return ListView.builder(
                itemCount: list!.length,
                itemBuilder:  (BuildContext context,index) {
                  if(list[index]['username']!='$username')
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async{
                        await check_the_user(list[index]['username']);
                        usernamefromuserpage=list[index]['username'];
                        
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => 
                   chat_page(selecteduserfromdmpage:usernamefromuserpage,idfromuserspage:idfromuserspage)),
                  );
                  
                      },
                      child:  ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                        child:Container(
                          color: Colors.purple,
                          width: double.infinity,
                          height: 50,
                          child:Center(child:Text("${list[index]['username']}",style:TextStyle(fontSize: 25)))
                          ))));
                          else
                          return SizedBox();
      
                }
                );
            }
            else
            return Center(child: CircularProgressIndicator());
          }
        ),
      )
    );
  }
}
