import 'package:chatapp_php/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _mybox=Hive.box('info_user');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(chat_page());
}

class chat_page extends StatefulWidget {
  
  const chat_page({this.selecteduserfromdmpage,this.idfromuserspage});
  final idfromuserspage;
  final selecteduserfromdmpage;
  @override
  State<chat_page> createState() => _chat_pageState();
}

class _chat_pageState extends State<chat_page> {
  //////////
  var signinuser=_mybox.get('info_user');
  
  late TextEditingController message;
  
  late Stream getchat;
  
  final scrollcontroller=ScrollController();
  
  int x=20;
  
  var currDt = DateTime.now();

  /////////




sendmessage(content)async{
await Supabase.instance.client
    .from('mess')
    .insert({'fromuser':'$signinuser' ,'touser':'${widget.selecteduserfromdmpage}','message':'$content','messages_id':'${widget.idfromuserspage}'});
}


changecolor(lst,index,fromuser){
  if(lst[index]['fromuser']==fromuser)
  return Color.fromARGB(255, 97, 11, 112);
  else
  return Color.fromARGB(255, 76, 0, 111);
}

getchats(){//get all chats in db
getchat=Supabase.instance.client
.from('mess')
.stream(primaryKey: ['id'])
.order('date')
.eq('messages_id','${widget.idfromuserspage}')
.limit(x);
}

scrolltoloadmore(){
  
if(scrollcontroller.position.pixels==scrollcontroller.position.maxScrollExtent){
setState(() {x=x+20;});
}

}


  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }
  
  
@override
  void initState() {
    super.initState();
    message=TextEditingController();
      
      scrollcontroller.addListener((){
        scrolltoloadmore();
        });
        
        getchats();
  }
  
  
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text("${widget.selecteduserfromdmpage}"),
          leading:IconButton(
          icon: Icon(Icons.arrow_back_ios),
        iconSize: 30,
        onPressed: () {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>sec_screen()));
    }),
            
            
            
            backgroundColor:Color.fromARGB(255, 97, 25, 110)
          ),
          
          
          body: StreamBuilder(
          stream: getchat,
          builder: (context,snapshot){
            if(snapshot.data!=null){
            var list=snapshot.data!;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                    children: [
                
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height:height/1.13,
                  child: ListView.builder(
                    controller: scrollcontroller,
                    reverse: true,
                      itemCount: list!.length,
                      itemBuilder:  (BuildContext context,index) {
                  if(list[index]['fromuser']=='$signinuser' && list[index]['touser']=='${widget.selecteduserfromdmpage}' || list[index]['fromuser']=='${widget.selecteduserfromdmpage}' && list[index]['touser']=='$signinuser')
                
                              return Padding(
                                padding: const EdgeInsets.all(3),
                                child:Align(
                                alignment: list[index]['fromuser']=='$signinuser'?FractionalOffset.centerRight:FractionalOffset.centerLeft,
                                child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:Container(
                                constraints: BoxConstraints(maxWidth: 270),
                
                                color: changecolor(list,index,'$signinuser'),
                                child:Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                children:[ 
                                Text("${list[index]['message']}",
                                style: TextStyle(fontSize: 20,color:Colors.white)),
                                
                                
                                
                                  ],
                                
                                )
                                )
                                
                                ),
                                ))
                              
                                    
                                    
                                    
                            
                            
                            
                          );
                        
                              else 
                              return SizedBox();
                              
                      }),
                
                      
                ),
                     
                          
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child:ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Container( 
                    color: Colors.purple,
                    width:width,
                    height:height/18,
                    child: TextField(
                    controller: message,
                    decoration: InputDecoration(
                    suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: (){
                    sendmessage(message.text);
                      }))
                      
                    )
                         )))
                    ],
                  
                  
                ),
              
            );
            
            
            }
            
            else
            return Center(child: CircularProgressIndicator());//futurebuilder
            
          }
        )
          ),
      ));
  }
}

                  //   ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  // child:TextField(
                  //   controller: message,
                  //   decoration: InputDecoration(suffixIcon: IconButton(
                  //   icon: Icon(Icons.send),
                  //   onPressed: (){
                  //     sendmessage(message.text);
                  //     print("message send it ");
                      
                      
                      
                      
                      
                      
                      
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var username="$signinuser";

//   final connection = PostgreSQLConnection(//conn section
//   'db.bkqimylsvpdzyhkptguq.supabase.co',
//   5432, 
//   'postgres',
//   username: 'postgres',
//   password: 'B@38Cbm*4qhJg.Y');
  
  
  
  
  
  



//       // .select<List<Map<String, dynamic>>>();
      
      
      
      
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: _future,
//         builder: (context,snapshot){
//           if(snapshot.data!=null){
//             var list=snapshot.data!;
//           return 
//             ListView.builder(
//               itemCount: list!.length,
//               itemBuilder:  (BuildContext context,index) {
//                 return  Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                       color: Colors.purple,
//                       width: double.infinity,
//                       height: 50,
//                       child:  ElevatedButton(
//                         onPressed: ()async{await sd();},
//                          child: Text("click")),
//                       ),
//                 );
//               }
//               );
//           }
//           else
//           return Center(child: CircularProgressIndicator());
//         }
//       )
//     );
//   }
// }






