import 'package:best_flutter_ui_templates/navigation_home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:best_flutter_ui_templates/firebase/validator.dart';
import 'package:best_flutter_ui_templates/firebase/firebase_auth.dart';
import 'package:best_flutter_ui_templates/LoginPage/register_page.dart';
import 'package:best_flutter_ui_templates/firebase/firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  bool isProcessing = false;

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    User? user = FirebaseAuth.instance.currentUser;
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NavigationHomeScreen(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusEmail.unfocus();
        focusPassword.unfocus();
      },
      child: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/arkaplan1.gif'), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: initializeFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              height: 240,
                              child: Image.asset(
                                  "assets/images/ibocanuygulama.png"),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 0.0, right: 0),
                                child: TextFormField(
                                  controller: emailTextController,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  autofocus: false,
                                  focusNode: focusEmail,
                                  validator: (value) => Validator.validateEmail(
                                    email: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "E-Mail",
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    focusColor: Colors.white,
                                    prefixIcon: Icon(
                                      Icons.person_outline_rounded,
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.blue, width: 1.0),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    fillColor: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 55,
                              margin: EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: TextFormField(
                                  controller: passwordTextController,
                                  focusNode: focusPassword,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  autofocus: false,
                                  obscureText: true,
                                  validator: (value) =>
                                      Validator.validatePassword(
                                    password: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Şifre",
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    focusColor: Colors.white,
                                    prefixIcon: Icon(
                                      Icons.person_outline_rounded,
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.blue, width: 1.0),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    fillColor: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            isProcessing
                                ? CircularProgressIndicator()
                                : Container(
                                    height: 55,
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 70, right: 70),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.indigo.shade800,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      onPressed: () async {
                                        focusEmail.unfocus();
                                        focusPassword.unfocus();

                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            isProcessing = true;
                                          });

                                          User? user = await FireAuth
                                              .signInUsingEmailPassword(
                                            email: emailTextController.text,
                                            password:
                                                passwordTextController.text,
                                          );

                                          setState(() {
                                            isProcessing = false;
                                          });

                                          if (user != null) {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NavigationHomeScreen(
                                                        user: user),
                                              ),
                                              (Route<dynamic> route) => false,
                                            );
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Giriş',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 14,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Bir hesabınız yok mu ?',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Kayıt Ol',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Şifrenizi mi Unuttunuz?',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showGeneralDialog(
                                        context: context,
                                        pageBuilder: (BuildContext buildContext,
                                            Animation animation,
                                            Animation secondaryAnimation) {
                                          return sifreSifirla(context);
                                        });
                                  },
                                  child: Text(
                                    'Sıfırla',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

final epostaController = TextEditingController();

Widget sifreSifirla(
  context,
) {
  return AlertDialog(
      shape: defaultShape(),
      content: SizedBox(
        width: 300,
        height: 250,
        child: Column(
          children: <Widget>[
            getCloseButton(context),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              width: 270,
              child: TextField(
                controller: epostaController,
                decoration: InputDecoration(
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
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
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  labelText: 'E-Posta',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 250,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 244, 67, 54)),
                ),
                onPressed: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: epostaController.text)
                      .whenComplete(() => Navigator.pop(context));
                },
                child: Text(
                  "Sıfırlama İsteği Gönder",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ));
}

ShapeBorder defaultShape() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
    side: const BorderSide(
      color: Colors.deepOrange,
    ),
  );
}

getCloseButton(context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
    child: GestureDetector(
      onTap: () {},
      child: Container(
        alignment: FractionalOffset.topRight,
        child: GestureDetector(
          child: const Icon(
            Icons.clear,
            color: Colors.red,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    ),
  );
}
