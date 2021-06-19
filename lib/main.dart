import 'package:flutter/material.dart';
import 'package:app_services/src/routes/routes.dart';
import 'package:app_services/src/shared/preferences.dart';
 
void main() async {
  // Cargamos preferencias antes de cargar toda la aplicación
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = Preferences();
  await preferences.initPreferences();
  return runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Services',
      debugShowCheckedModeBanner: false,
      routes: getApplicationRoutes(),
      initialRoute: 'splash',
    );
  }
}