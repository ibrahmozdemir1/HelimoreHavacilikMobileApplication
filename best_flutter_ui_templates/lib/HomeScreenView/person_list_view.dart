import 'package:best_flutter_ui_templates/animation/curve_painter.dart';
import 'package:best_flutter_ui_templates/maps/maps_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:best_flutter_ui_templates/themes/fitness_app_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

Map<String, dynamic>? bileklikVeri;
var bileklikCollection = FirebaseFirestore.instance.collection('bileklik');
var bileklikSayisi;
User? user = FirebaseAuth.instance.currentUser;
var listItem = [];
late List<DropdownMenuItem> bileklikID;
final isimController = TextEditingController();
var sirketCollection = FirebaseFirestore.instance.collection('sirket');

Future<void> getdata() async {
  WidgetsFlutterBinding.ensureInitialized();

  User? currentUser = FirebaseAuth.instance.currentUser;
  //query the user photo
  DocumentSnapshot pathData = await FirebaseFirestore.instance
      .collection('sirket')
      .doc(currentUser?.uid)
      .get();
  if (pathData.exists) {
    bileklikVeri = pathData.data() as Map<String, dynamic>?;
    bileklikSayisi = bileklikVeri?['bileklikSayisi'];
  }
}

class BileklikVeriScreen extends StatefulWidget {
  final sirketID;

  const BileklikVeriScreen({
    Key? key,
    this.sirketID,
  }) : super(key: key);
  @override
  _BileklikVeriScreenState createState() => _BileklikVeriScreenState();
}

class _BileklikVeriScreenState extends State<BileklikVeriScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 134, 175),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/arkaplan1.gif'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: bileklikCollection
                    .where("sirketID", isEqualTo: widget.sirketID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Container(
                      child: Center(
                        child: Text(
                          "Görüntülenecek bileklik bulunamadı",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  } else {
                    return ListView(
                        shrinkWrap: false,
                        children: snapshot.data!.docs.map((doc) {
                          return Card(
                            color: Colors.white70,
                            child: Column(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, left: 16, right: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8, top: 8),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 40,
                                                  width: 2,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4,
                                                                bottom: 2),
                                                        child: Text(
                                                          'Kalp Atışı',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FitnessAppTheme
                                                                    .fontName,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                            letterSpacing: -0.1,
                                                            color:
                                                                FitnessAppTheme
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: 22,
                                                            height: 22,
                                                            child: Image.asset(
                                                                "assets/helimore_app/kalp.png"),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4,
                                                                    bottom: 3),
                                                            child: Text(
                                                              '${doc.data()['kalpAtisHizi']}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FitnessAppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                color: FitnessAppTheme
                                                                    .darkerText,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4,
                                                                    bottom: 3),
                                                            child: Text(
                                                              'bpm',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FitnessAppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    -0.2,
                                                                color: FitnessAppTheme
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 48,
                                                  width: 2,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4,
                                                                bottom: 2),
                                                        child: Text(
                                                          'Son Güncelleme',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FitnessAppTheme
                                                                    .fontName,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                            letterSpacing: -0.1,
                                                            color:
                                                                FitnessAppTheme
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: 22,
                                                            height: 22,
                                                            child: Image.asset(
                                                                "assets/helimore_app/zamansimge.png"),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4,
                                                                    bottom: 3),
                                                            child: Text(
                                                              '${DateFormat.yMMMd().add_jm().format(doc.data()['sonGuncelleme'].toDate())}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FitnessAppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                                color: FitnessAppTheme
                                                                    .darkerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Center(
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: FitnessAppTheme.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(100.0),
                                                  ),
                                                  border: new Border.all(
                                                      width: 4,
                                                      color: Colors.red
                                                          .withOpacity(0.2)),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '${doc.data()['vucutSicakligi']} C°',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            FitnessAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 24,
                                                        letterSpacing: 0.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: CustomPaint(
                                                painter: CurvePainter(
                                                    colors: [
                                                      Colors.red,
                                                      Colors.green,
                                                      Colors.greenAccent
                                                    ],
                                                    angle: doc.data()[
                                                            'vucutSicakligi'] +
                                                        (90 - 4) * (3.0)),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 108,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 24, top: 8, bottom: 18),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Bileklik Sahibi : ${doc.data()['kisiAdi']}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: -0.2,
                                              color: FitnessAppTheme.darkText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 45),
                                        child: Center(
                                          child: Row(
                                            children: <Widget>[
                                              IconButton(
                                                  onPressed: () {
                                                    GeoPoint konum = doc
                                                        .data()['haritaKonum'];
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                MapsScreen(
                                                                    haritaKonum:
                                                                        konum)));
                                                  },
                                                  icon: Icon(Icons.map_rounded))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              var bileklikID =
                                                  doc.data()['bileklikID'];
                                              var kisiAd =
                                                  doc.data()['kisiAdi'];
                                              showGeneralDialog(
                                                  context: context,
                                                  pageBuilder: (BuildContext
                                                          buildContext,
                                                      Animation animation,
                                                      Animation
                                                          secondaryAnimation) {
                                                    return deleteandUpdate(
                                                        context,
                                                        bileklikID,
                                                        widget.sirketID,
                                                        kisiAd);
                                                  });
                                            },
                                            child: Text("Güncelle/Sil"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          );
                        }).toList());
                  }
                }),
          ),
        ),
      ),
    );
  }
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
    padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
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

Widget deleteandUpdate(context, bileklikID, sirketID, kisiAd) {
  return AlertDialog(
      shape: defaultShape(),
      content: SizedBox(
        width: 250,
        height: 300,
        child: Column(
          children: <Widget>[
            getCloseButton(context),
            SizedBox(
              height: 30,
            ),
            Row(children: <Widget>[
              Expanded(
                flex: 2,
                child: new Text(
                  "Bilekliğin Numarası : ${bileklikID.toString()}",
                ),
              ),
            ]),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Şirketin Numarası : ${sirketID}",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  width: 36,
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              children: <Widget>[
                Text("Kişinin Adı : "),
                SizedBox(
                  width: 14,
                ),
                Container(
                  width: 120,
                  height: 30,
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    controller: isimController,
                    decoration: InputDecoration(
                      hintText: "${kisiAd.toString()}",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              width: 120,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 0, 131, 26)),
                ),
                onPressed: () {
                  updateBileklik(bileklikID, context, isimController.text);
                },
                child: Text(
                  "Güncelle",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 120,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {
                  deleteBileklik(bileklikID, context);
                },
                child: Text(
                  "Sil",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ));
}

updateBileklik(bileklikID, context, kisiAdi) {
  bileklikCollection.get().then((QuerySnapshot snap) {
    snap.docs.forEach((element) {
      if (element['bileklikID'] == bileklikID) {
        bileklikCollection.doc(element.id).update({
          'kisiAdi': kisiAdi,
        }).whenComplete(() {
          Fluttertoast.showToast(
              msg: "Bileklik Bilgileri Güncellendi.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        });
      } else {
        print("no");
      }
    });
  });
}

deleteBileklik(bileklikID, context) {
  getdata();

  bileklikCollection.get().then((QuerySnapshot snap) {
    snap.docs.forEach((element) {
      if (element['bileklikID'] == bileklikID) {
        bileklikCollection.doc(element.id).update({
          'sirketID': 0,
          'kisiAdi': "",
        }).whenComplete(() {
          sirketCollection.get().then((QuerySnapshot sirketsnap) {
            sirketsnap.docs.forEach((element) {
              if (element.id == user?.uid) {
                sirketCollection.doc(user?.uid).update({
                  'bileklikSayisi': bileklikSayisi - 1,
                });
              }
            });
          });
        }).whenComplete(() {
          Fluttertoast.showToast(
              msg: "Bileklik Kaldırıldı.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);

          Navigator.pop(context);
        });
      } else {
        print("no");
      }
    });
  });
}
