import 'package:chatapp_php/conn.dart';
import 'package:chatapp_php/dm_page.dart';
import 'package:chatapp_php/showusers.dart';
import 'package:chatapp_php/signin.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _mybox=Hive.box('info_user');

conn connection=conn();
// 


void main() async {

  await Hive.initFlutter();
  await Hive.openBox('info_user');

await connection.Supabase_initialize;
 
  runApp(sec_screen());


}
class sec_screen extends StatefulWidget {
  const  sec_screen({super.key});
  
  @override
  State<sec_screen> createState() => _sec_screenState();
}

class _sec_screenState extends State<sec_screen> {
  int i=0;


int chvar(int pe){
  setState(() {});
  i=pe;
   return pe;
}



//////////
final List<Widget> _pages=[ ///list of widget(here where the widgte will showing in the app)
dm_page(),
users_page()
];

  @override
  Widget build(BuildContext context) {

   return MaterialApp(
    debugShowCheckedModeBanner: false,

    home: SafeArea(
    child:Scaffold(
    resizeToAvoidBottomInset:false,
    body:_mybox.get('info_user')!=null? _pages[chvar(i)]:signin(),
   ////////////////
    bottomNavigationBar:
    
    _mybox.get('info_user')!=null?
GNav(
      backgroundColor:Color.fromARGB(255, 97, 25, 110),
      gap:2,
      color: Colors.white,
      activeColor:Colors.white,
      padding: EdgeInsets.all(15),
      onTabChange:(r){chvar(r);},
      ////////////////////////////////
      tabs:[
      GButton(icon:Icons.messenger),
      GButton(icon:Icons.person_rounded),
    ]):null
    
    
    
    )));
         
  }}

