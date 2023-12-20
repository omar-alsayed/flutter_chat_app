import 'package:postgres/postgres.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class conn{
  
  final Supabase_initialize=Supabase.initialize(
    url: 'https://your-project-url.supabase.co',
    anonKey: 'your-project-api-key',
  );
  
  
  final Postgre_connection = PostgreSQLConnection(
    'your_host',
    5432,
    'your_database_name',
    username: 'your_username',
    password: 'your_password',
  );
  
  
  
supabase_conn(){
  
}
  


  
  
  
  
  
}