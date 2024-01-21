import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optiqos/pages/home.dart';

import '../utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Nama Lengkap'),
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
                TextFormField(
                  controller: password,
                  validator: (value) {
                    if (!(value!.length < 8) && value.isNotEmpty) {
                      return 'Maksimal 8 karakter';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Sudah punya akun?',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Login disini'))
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                              (route) => false);

                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email.text, password: password.text);

                          Utils.USER_NOW =
                              FirebaseAuth.instance.currentUser!.email! ?? '';
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

                        ///
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
