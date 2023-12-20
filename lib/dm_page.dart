import 'package:chatapp_php/chat_page.dart';
import 'package:chatapp_php/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final _mybox=Hive.box('info_user');

var user_chat;
var messages_id;

class dm_page extends StatefulWidget {
  const dm_page({super.key});

  @override
  State<dm_page> createState() => _dm_pageState();
  
}

class _dm_pageState extends State<dm_page> {
  
  String username=_mybox.get('info_user');
  
  ////
  
  Future<dynamic> who_chat_with()async{
  return Supabase.instance.client
  .from('who_chat_with')
  .select('*') 
  .or('fromuser.eq.$username,touser.eq.$username');
  }
  
  
    
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left:45),
        child: Text("people u chat with"),
      ),
      leading: IconButton(
      icon: Icon(Icons.logout),
      iconSize: 30,
    onPressed: () {
      _mybox.put('info_user',null);
      
      Navigator.push(
      context,MaterialPageRoute(builder: (context) =>sec_screen()));
      
    }),
      backgroundColor:Color.fromARGB(255, 97, 25, 110)
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 13, 13, 13),
        child: FutureBuilder(
          future: who_chat_with(),
          builder: (context,snapshot){
            if(snapshot.data!=null){
            var list=snapshot.data;
            return ListView.builder(
                itemCount: list!.length,
                itemBuilder:  (BuildContext context,index) {
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        if(list[index]['fromuser']=='$username'){
                        user_chat=list[index]['touser'];
                        messages_id=list[index]['messages_id'];
                        }
                        
                        else{
                          user_chat=list[index]['fromuser'];
                          messages_id=list[index]['messages_id'];
                        }
                        
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => chat_page(selecteduserfromdmpage:user_chat,idfromuserspage:messages_id)),
                    );
                      },
                      child:  ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                        child:Container(
                          color: Colors.purple,
                          width: double.infinity,
                          height: 50,
                          child:  Center(
                            child:list[index]['fromuser']!='$username' 
                          ? 
                          Text("${list[index]['fromuser']} ",style:TextStyle(fontSize: 25)):
                          Text("${list[index]['touser']} ",style:TextStyle(fontSize: 25))
                          
                          )
                          ),
                    )
                  ));
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
