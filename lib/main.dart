import 'package:flutter/material.dart';
import 'package:student_application_manager_new/router/router_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://lcrwgogsladpewlvjlmb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxjcndnb2dzbGFkcGV3bHZqbG1iIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0NTYyNTEsImV4cCI6MjA1NTAzMjI1MX0.c8zRYy7bW4iVgIAfh16BHQWfhliRBKqzamAamZ_X6l0',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData.dark(),
    );
  }
}
