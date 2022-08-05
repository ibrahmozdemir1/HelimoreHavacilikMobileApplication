// ignore_for_file: unused_local_variable, unnecessary_null_comparison
import 'dart:math' as math;
import 'package:best_flutter_ui_templates/themes/fitness_app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/tabIcon_data.dart';

Map<String, dynamic>? data;
var bileklikCollection = FirebaseFirestore.instance.collection('bileklik');
var sirketCollection = FirebaseFirestore.instance.collection('sirket');
var listItem = [];
late List<DropdownMenuItem> bileklikID;
var sirketID;

Future<void> getdata() async {
  User? user = FirebaseAuth.instance.currentUser;
  //query the user photo
  DocumentSnapshot pathData = await FirebaseFirestore.instance
      .collection('sirket')
      .doc(user?.uid)
      .get();
  if (pathData.exists) {
    data = pathData.data() as Map<String, dynamic>?;
    sirketID = data?['sirketID'];
  }
}

class BottomBarView extends StatefulWidget {
  const BottomBarView(
      {Key? key, this.tabIconsList, this.changeIndex, this.addClick})
      : super(key: key);

  final Function(int index)? changeIndex;
  final Function()? addClick;
  final List<TabIconData>? tabIconsList;
  @override
  _BottomBarViewState createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final isimController = TextEditingController();
  var secilenBileklik;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController?.forward();
    getdata();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    isimController.dispose();

    super.dispose(); // you need this
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return Transform(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: PhysicalShape(
                color: FitnessAppTheme.white,
                elevation: 16.0,
                clipper: TabClipper(
                    radius: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(CurvedAnimation(
                                parent: animationController!,
                                curve: Curves.fastOutSlowIn))
                            .value *
                        38.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 62,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 4),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TabIcons(
                                  tabIconData: widget.tabIconsList?[0],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList?[0]);
                                    widget.changeIndex!(0);
                                  }),
                            ),
                            SizedBox(width: 90),
                            Expanded(
                              child: TabIcons(
                                  tabIconData: widget.tabIconsList?[1],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList?[1]);
                                    widget.changeIndex!(1);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
            );
          },
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: SizedBox(
            width: 38 * 2.0,
            height: 38 + 62.0,
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              child: SizedBox(
                width: 38 * 2.0,
                height: 38 * 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController!,
                            curve: Curves.fastOutSlowIn)),
                    child: Container(
                      // alignment: Alignment.center,s
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyDarkBlue,
                        gradient: LinearGradient(
                            colors: [
                              FitnessAppTheme.nearlyDarkBlue,
                              HexColor('#6A88E5'),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: FitnessAppTheme.nearlyDarkBlue
                                  .withOpacity(0.4),
                              offset: const Offset(8.0, 16.0),
                              blurRadius: 16.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.white.withOpacity(0.1),
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () {
                            showGeneralDialog(
                                context: context,
                                pageBuilder: (BuildContext buildContext,
                                    Animation animation,
                                    Animation secondaryAnimation) {
                                  return AlertDialog(
                                      shape: defaultShape(),
                                      content: SizedBox(
                                        width: 400,
                                        height: 350,
                                        child: Column(
                                          children: <Widget>[
                                            getCloseButton(context),
                                            Center(
                                              child: FutureBuilder<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>(
                                                future: FirebaseFirestore
                                                    .instance
                                                    .collection('bileklik')
                                                    .get(),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData)
                                                    return const Text(
                                                        "Loading..");
                                                  listItem =
                                                      snapshot.data!.docs;
                                                  return new Row(children: <
                                                      Widget>[
                                                    Container(
                                                      width: 90,
                                                      child: Text(
                                                        "Bileklik Numarası : ",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    Container(
                                                      width: 120,
                                                      child: InputDecorator(
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText: "Seçim Yap",
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  "OpenSans",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                        child:
                                                            DropdownButtonFormField<
                                                                String>(
                                                          value:
                                                              secilenBileklik,
                                                          onSaved:
                                                              (value) async {
                                                            setState(() {
                                                              secilenBileklik =
                                                                  value;
                                                            });
                                                          },
                                                          onChanged: (secilen) {
                                                            setState(() {
                                                              secilenBileklik =
                                                                  secilen;
                                                            });
                                                          },
                                                          items: snapshot
                                                              .data!.docs
                                                              .map((doc) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: doc
                                                                  .data()[
                                                                      'bileklikID']
                                                                  .toString(),
                                                              child: Text(doc
                                                                  .data()[
                                                                      'bileklikID']
                                                                  .toString()),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ]);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 90,
                                                  child: Text(
                                                    "Şirketin Numarası :",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 36,
                                                ),
                                                Container(
                                                  width: 70,
                                                  child: Text(
                                                    "${data?['sirketID'] ?? "Yükleniyor..."} ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                  ),
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
                                                  width: 32,
                                                ),
                                                Container(
                                                  width: 130,
                                                  child: TextFormField(
                                                    textAlign: TextAlign.start,
                                                    controller: isimController,
                                                    decoration: InputDecoration(
                                                      hintText: "İsim Giriniz",
                                                      errorBorder:
                                                          UnderlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
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
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(255,
                                                              244, 67, 54)),
                                                ),
                                                onPressed: () {
                                                  if (secilenBileklik != null) {
                                                    saveBileklik(
                                                        context,
                                                        secilenBileklik,
                                                        isimController.text);
                                                    if (isimController.text !=
                                                        null) {
                                                      isimController.clear();
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                  "Ekle",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                });
                          },
                          child: Icon(
                            Icons.add,
                            color: FitnessAppTheme.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void setRemoveAllSelection(TabIconData? tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList?.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData!.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}

class TabIcons extends StatefulWidget {
  const TabIcons({Key? key, this.tabIconData, this.removeAllSelect})
      : super(key: key);

  final TabIconData? tabIconData;
  final Function()? removeAllSelect;
  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.tabIconData?.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect!();
          widget.tabIconData?.animationController?.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    widget.tabIconData?.animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (!widget.tabIconData!.isSelected) {
              setAnimation();
            }
          },
          child: IgnorePointer(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ScaleTransition(
                  alignment: Alignment.center,
                  scale: Tween<double>(begin: 0.88, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.tabIconData!.animationController!,
                          curve:
                              Interval(0.1, 1.0, curve: Curves.fastOutSlowIn))),
                  child: Image.asset(widget.tabIconData!.isSelected
                      ? widget.tabIconData!.selectedImagePath
                      : widget.tabIconData!.imagePath),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabClipper extends CustomClipper<Path> {
  TabClipper({this.radius = 38.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(
            ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    final double redian = (math.pi / 180) * degree;
    return redian;
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

saveBileklik(context, secilenBileklik, isim) async {
  var bilekliksayi = data?['bileklikSayisi'];
  String kisiIsmi = isim;
  User? user = FirebaseAuth.instance.currentUser;

  bileklikCollection.get().then((QuerySnapshot snap) {
    snap.docs.forEach((element) {
      if (element['bileklikID'] == int.parse(secilenBileklik)) {
        if (element['sirketID'] != 0) {
          Fluttertoast.showToast(
              msg: "Bileklik, başka bir şirket üzerine kayıtlı.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          bileklikCollection.doc(element.id).update({
            'sirketID': data?['sirketID'],
            'kisiAdi': kisiIsmi,
          }).whenComplete(() {
            sirketCollection.get().then((QuerySnapshot sirketsnap) {
              sirketsnap.docs.forEach((element) {
                if (element.id == user?.uid) {
                  sirketCollection.doc(user?.uid).update({
                    'bileklikSayisi': bilekliksayi + 1,
                  });
                }
              });
            });
            Fluttertoast.showToast(
                msg: "Bileklik, şirketinize eklendi.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0);
          }).whenComplete(() {
            Navigator.pop(context);
          });
        }
      }
    });
  });
}
