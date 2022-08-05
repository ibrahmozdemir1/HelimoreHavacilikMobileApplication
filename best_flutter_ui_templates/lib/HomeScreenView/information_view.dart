// ignore_for_file: unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InformationScreen extends StatefulWidget {
  final Map<String, dynamic> sirketVeri;
  const InformationScreen(
      {Key? key, this.animationController, required this.sirketVeri})
      : super(key: key);

  final AnimationController? animationController;
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

Map<String, dynamic>? sirketVeri;

var sirketisim;
var sirketsahibi;
var sirketmail;
var sirketbileklikSayisi;
var sirketAdres;

Future<void> getSirketData() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  //query the user photo
  DocumentSnapshot pathData = await FirebaseFirestore.instance
      .collection('sirket')
      .doc(currentUser?.uid)
      .get();
  if (pathData.exists) {
    sirketVeri = pathData.data() as Map<String, dynamic>?;
    sirketisim = sirketVeri?['sirketAdi'];
    sirketsahibi = sirketVeri?['sirketSahibi'];
    sirketmail = sirketVeri?['email'];
    sirketbileklikSayisi = sirketVeri?['bileklikSayisi'];
    sirketAdres = sirketVeri?['sirketAdres'];
  }
}

class _InformationScreenState extends State<InformationScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  var currentUser = FirebaseAuth.instance.currentUser;
  bool isSendingVerification = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  double topBarOpacity = 0.0;
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
      Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: FutureBuilder(
                future: getSirketData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/logo1.jpg'),
                      ),
                      Text(
                        "${sirketisim}",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Pacifico",
                        ),
                      ),
                      Text(
                        "${sirketsahibi}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey[200],
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Source Sans Pro"),
                      ),
                      SizedBox(
                        height: 20,
                        width: 200,
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: ListTile(
                          leading: Icon(
                            Icons.mail_lock,
                            color: Colors.teal,
                          ),
                          title: Text(
                            "${sirketmail}",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Source Sans Pro"),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: ListTile(
                          leading: Icon(
                            Icons.broadcast_on_home_outlined,
                            color: Colors.teal,
                          ),
                          title: Text(
                            "Tanımlı Bileklik Sayısı : ${sirketbileklikSayisi}",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Source Sans Pro"),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: ListTile(
                          leading: Icon(
                            Icons.home_work,
                            color: Colors.teal,
                          ),
                          title: Text(
                            "${sirketAdres}",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Source Sans Pro"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      currentUser!.emailVerified
                          ? Text(
                              'E-Posta Doğrulandı.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Color.fromARGB(255, 5, 240, 5)),
                            )
                          : Column(
                              children: [
                                Text(
                                  "E-Posta Onaylanmadı.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              Color.fromARGB(255, 236, 22, 7)),
                                ),
                                TextButton(
                                  child: Text(
                                    "Lütfen Tıklayarak E-Postayı Onaylayınız.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: Color.fromARGB(
                                                255, 236, 22, 7)),
                                  ),
                                  onPressed: () async {
                                    Fluttertoast.showToast(
                                        msg:
                                            "E-Postanıza Doğrulama Maili Gönderildi.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    setState(() {
                                      isSendingVerification = true;
                                    });
                                    await currentUser?.sendEmailVerification();
                                    setState(() {
                                      isSendingVerification = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                    ],
                  );
                }),
          )),
    ]);
  }
}
