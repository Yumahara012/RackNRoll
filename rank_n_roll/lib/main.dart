import 'package:flutter/material.dart';
import 'package:rack_n_roll/screens/splashscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Supabase.initialize(
    url: 'https://coppysxcqpwpxceyrwiu.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNvcHB5c3hjcXB3cHhjZXlyd2l1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIxMTM3NzksImV4cCI6MjA1NzY4OTc3OX0.Hql-Grc0qEvSHyUf3pPIITF4S622UD_bO9QB0Gvn-GA',
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
