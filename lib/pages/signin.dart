import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optiqos/pages/admin_home.dart';
import 'package:optiqos/pages/home.dart';
import 'package:optiqos/pages/signup.dart';

import '../utils/utils.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.png',
            fit: BoxFit.cover,
            height: double.maxFinite,
            width: double.maxFinite,
          ),
          Container(
            child: ListView(
              padding: EdgeInsets.all(30),
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset('assets/LOGO.png'),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Email'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Password'),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Belum daftar?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ));
                          },
                          child: Text('Daftar disini'))
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () async {
                        try {
                          if (email.text == 'admin@gmail.com' &&
                              password.text == 'admin') {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminHome(),
                                ),
                                (route) => false);
                          } else {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: password.text);

                            Utils.USER_NOW =
                                FirebaseAuth.instance.currentUser!.email! ?? '';

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                                (route) => false);
                          }

                          // ignore: use_build_context_synchronously
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'wrong-password') {
                            setState(() {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('Email & password salah, coba lagi'),
                                backgroundColor: Colors.orange.shade400,
                              ));

                              email.clear();
                              password.clear();
                            });
                          } else if (e.code == 'user-not-found') {
                            setState(() {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('User tidak ditemukan'),
                                backgroundColor: Colors.orange.shade400,
                              ));

                              email.clear();
                              password.clear();
                            });
                          }
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //   content: Text(e.toString()),
                          //   backgroundColor: Colors.orange.shade400,
                          // ));
                        }
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => Home(),
                        //     ),
                        //     (route) => false);
                      },
                      child: Text(
                        'Masuk',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
