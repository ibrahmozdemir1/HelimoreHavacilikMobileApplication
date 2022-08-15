import 'dart:math';

import 'package:best_flutter_ui_templates/LoginPage/login_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:best_flutter_ui_templates/navigation_home_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:best_flutter_ui_templates/firebase/validator.dart';
import 'package:best_flutter_ui_templates/firebase/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

Future<void> messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

class _RegisterPageState extends State<RegisterPage> {
  final registerFormKey = GlobalKey<FormState>();
  Random random = new Random();

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final sirketAdiController = TextEditingController();
  final sirketIDController = TextEditingController();
  final sirketSahibiController = TextEditingController();
  final sirketAdresController = TextEditingController();
  final sirketTelController = TextEditingController();

  final focusName = FocusNode();
  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  @override
  void dispose() {
    nameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    sirketAdiController.dispose();
    sirketIDController.dispose();
    sirketSahibiController.dispose();
    sirketAdresController.dispose();
    sirketTelController.dispose();
    focusName.dispose();
    focusEmail.dispose();
    focusPassword.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/arkaplan1.gif'), // <-- BACKGROUND IMAGE
            fit: BoxFit.cover,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          focusName.unfocus();
          focusEmail.unfocus();
          focusPassword.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 250,
                          child: Image.asset("assets/images/helimore-logo.png"),
                        ),
                        Center(
                          child: Card(
                            elevation: 10,
                            margin: EdgeInsets.all(10),
                            shadowColor: Colors.green,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.blue)),
                            child: Form(
                              key: registerFormKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 270,
                                    child: TextFormField(
                                      controller: sirketSahibiController,
                                      focusNode: focusName,
                                      validator: (value) =>
                                          Validator.validateName(
                                        name: value,
                                      ),
                                      decoration: InputDecoration(
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.person_outline_rounded,
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        fillColor: Colors.grey,
                                        labelText: 'Şirket Sahibi',
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: "verdana_regular",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  SizedBox(
                                    height: 50,
                                    width: 270,
                                    child: TextFormField(
                                      controller: emailTextController,
                                      focusNode: focusEmail,
                                      validator: (value) =>
                                          Validator.validateEmail(
                                        email: value,
                                      ),
                                      decoration: InputDecoration(
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.mail,
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        fillColor: Colors.grey,
                                        labelText: 'E-Posta',
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontFamily: "verdana_regular",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  SizedBox(
                                    height: 50,
                                    width: 270,
                                    child: TextFormField(
                                      controller: passwordTextController,
                                      focusNode: focusPassword,
                                      obscureText: true,
                                      validator: (value) =>
                                          Validator.validatePassword(
                                        password: value,
                                      ),
                                      decoration: InputDecoration(
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.password_sharp,
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        fillColor: Colors.grey,
                                        labelText: 'Şifre',
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontFamily: "verdana_regular",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  SizedBox(
                                    height: 50,
                                    width: 270,
                                    child: TextFormField(
                                      validator: (value) =>
                                          Validator.validateSirketAdi(
                                        sirketAdi: value,
                                      ),
                                      controller: sirketAdiController,
                                      decoration: InputDecoration(
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.add_business,
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        fillColor: Colors.grey,
                                        labelText: 'Şirket Adı',
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontFamily: "verdana_regular",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  SizedBox(
                                    height: 50,
                                    width: 270,
                                    child: TextFormField(
                                      validator: (value) =>
                                          Validator.validateSirketAdres(
                                        sirketAdres: value,
                                      ),
                                      keyboardType: TextInputType.streetAddress,
                                      controller: sirketAdresController,
                                      decoration: InputDecoration(
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.maps_home_work,
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        fillColor: Colors.grey,
                                        labelText: 'Adres',
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontFamily: "verdana_regular",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 270,
                                    child: TextFormField(
                                      validator: (value) =>
                                          Validator.validateSirketNum(
                                        sirketNum: value,
                                      ),
                                      keyboardType: TextInputType.phone,
                                      controller: sirketTelController,
                                      decoration: InputDecoration(
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.phone,
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        fillColor: Colors.grey,
                                        labelText: 'Telefon',
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontFamily: "verdana_regular",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 26.0),
                                  Center(
                                    child: Container(
                                      height: 50,
                                      width: 200,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.indigo.shade800,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                        onPressed: () async {
                                          if (registerFormKey.currentState!
                                              .validate()) {
                                            User? user = await FireAuth
                                                .registerUsingEmailPassword(
                                              name: nameTextController.text,
                                              email: emailTextController.text,
                                              password:
                                                  passwordTextController.text,
                                            );

                                            try {
                                              if (user != null) {
                                                FirebaseFirestore.instance
                                                    .collection("sirket")
                                                    .doc(user.uid)
                                                    .set({
                                                      'sirketAdi':
                                                          sirketAdiController
                                                              .text,
                                                      'bileklikSayisi': 0,
                                                      'sirketID': random
                                                          .nextInt(100000),
                                                      'email':
                                                          emailTextController
                                                              .text,
                                                      'password':
                                                          passwordTextController
                                                              .text,
                                                      'sirketSahibi':
                                                          sirketSahibiController
                                                              .text,
                                                      'sirketAdres':
                                                          sirketAdresController
                                                              .text,
                                                      'sirketTel':
                                                          sirketTelController
                                                              .text
                                                    })
                                                    .then((value) => print(
                                                        "Kişi Kayıt Edildi"))
                                                    .catchError((error) => print(
                                                        "Failed to user $error"))
                                                    .whenComplete(() {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              NavigationHomeScreen(
                                                                  user: user),
                                                        ),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false,
                                                      );
                                                    });
                                              }
                                            } catch (e) {}
                                          }
                                        },
                                        child: Text(
                                          'Kayıt Ol',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Hesabınız var mı?',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 10, 9, 9),
                                            fontStyle: FontStyle.italic),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => LoginPage(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Giriş',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
