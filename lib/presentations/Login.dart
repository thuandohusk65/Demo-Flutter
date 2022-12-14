import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/UserToken.dart';
import 'package:flutter_project/presentations/Home.dart';
import 'package:flutter_project/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;
  String _account = "";
  String _password = "";
  var _passwordVisible = true;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void onValueAccountChange(String account) {
    setState(() {
      _account = account;
    });
  }

  void onValuePasswordChange(String password) {
    setState(() {
      _password = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/images/img_home_bg.png'),
            )),

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: (MediaQuery
                    .of(context)
                    .size
                    .height) * 0.2),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.white,
            ),
            child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  // Column is also a layout widget. It takes a list of children and
                  // arranges them vertically. By default, it sizes itself to fit its
                  // children horizontally, and tries to be as tall as its parent.
                  //
                  // Invoke "debug painting" (press "p" in the console, choose the
                  // "Toggle Debug Paint" action from the Flutter Inspector in Android
                  // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                  // to see the wireframe for each widget.
                  //
                  // Column has various properties to control how it sizes itself and
                  // how it positions its children. Here we use mainAxisAlignment to
                  // center the children vertically; the main axis here is the vertical
                  // axis because Columns are vertical (the cross axis would be
                  // horizontal).
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Hello',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const Text(
                      'Please Login to your account',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        //apply padding to all four sides
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email address',
                          ),
                          onChanged: (account) {
                            _account = account;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        //apply padding to all four sides
                        child: TextFormField(
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                labelText: 'password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                )),
                            onChanged: (account) {
                              onValueAccountChange(account);
                            },
                            obscureText: _passwordVisible,
                            enableSuggestions: true)),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Text("forgot password",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.orange))),
                    Container(
                        width: Size.infinite.width,
                        margin: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            gradient: LinearGradient(colors: [
                              Colors.deepOrangeAccent,
                              Colors.yellow
                            ])),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                          onPressed: () async {
                            try {
                              var response = await Dio().post(
                                  'http://api.beta.radiantgalaxy.io/sdk/v1/auth/login/credential',
                                  data: {
                                    'email': 'chhh@gmail.com',
                                    'password': '123qweA@'
                                  });
                              Map<String, dynamic> dataResponse =
                              json.decode(response.toString());
                              final userToken = UserToken.fromJson(dataResponse);
                              UserUtils.accessToken = userToken.accessToken ;
                              if (UserUtils.accessToken.isNotEmpty) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (context) => const HomeScreen()));
                                    }
                                } catch (e)
                                {
                                  print(e);
                                }
                              },
                          child: const Text('Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.white)),
                        )),
                  ],
                ))),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
