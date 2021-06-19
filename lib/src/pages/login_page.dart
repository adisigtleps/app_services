import 'package:flutter/material.dart';
import 'package:app_services/src/shared/preferences.dart';

class LoginPage extends StatelessWidget {

  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final preferences = Preferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          height: 300.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: loginScreen(context),
        ),
      ),
    );
  }

  Widget loginScreen(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('L O G I N', style: TextStyle(
              fontSize: 30.0,
              color: Colors.blueAccent
            )),
            Divider(),
            TextField(
              controller: _usernameController,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                hintText: 'Username',
                labelText: 'Username',
                prefixIcon: Icon(Icons.account_circle),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                hintText: 'Password',
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => login(context),
                child: Text('Login')
              ),
            )
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username == '' || password == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Empty fields')));
    } else if (username == 'squirtle' && password == '123456') {
      preferences.token = 'asdqwe';
      Navigator.pushReplacementNamed(context, 'movies');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong password')));
    }

  }
}