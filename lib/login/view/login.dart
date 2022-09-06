import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/login/cubit/login_cubit.dart';
import 'package:flutter_project/login/view/widget/login_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: BlocProvider(
        create: (_) => LoginCubit(),
        child: const LoginPage(),
      )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}