import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/login/cubit/login_cubit.dart';
import 'package:flutter_project/login/cubit/login_state.dart';
import 'package:flutter_project/models/UserToken.dart';
import 'package:flutter_project/presentations/Home.dart';
import 'package:flutter_project/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;
  String _account = "";
  String _password = "";
  var _passwordVisible = true;

  final accountTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    accountTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
      if (state == LoginStates.success && UserUtils.accessToken.isNotEmpty) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    }, buildWhen: (previous, current) {
      return !(previous == current);
    }, builder: (context, state) {
      return (state != LoginStates.loading)
          ? loginPage(context)
          : const Center(
              child: CircularProgressIndicator(),
            );
    }));
  }

  Scaffold loginPage(BuildContext context) {
    return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                      vertical: (MediaQuery.of(context).size.height) * 0.2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: Colors.white,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(24),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          const Text(
                            'Please Login to your account',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              //apply padding to all four sides
                              child: TextFormField(
                                controller: accountTextController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Email address',
                                ),
                                onChanged: (account) {
                                  // _account = account;
                                },
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              //apply padding to all four sides
                              child: TextFormField(
                                  controller: passwordTextController,
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
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      )),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  gradient: LinearGradient(colors: [
                                    Colors.deepOrangeAccent,
                                    Colors.yellow
                                  ])),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                onPressed: () {
                                  BlocProvider.of<LoginCubit>(context)
                                      .requestLogin();
                                },
                                child: const Text('Login',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Colors.white)),
                              )),
                        ],
                      ))),
            ));
  }
}
