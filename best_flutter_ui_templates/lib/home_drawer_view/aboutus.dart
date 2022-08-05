import 'package:best_flutter_ui_templates/themes/app_theme.dart';
import 'package:flutter/material.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppTheme.nearlyWhite,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: AppTheme.nearlyWhite,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/arkaplan1.gif'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                        left: 16,
                        right: 16),
                    child: Image.asset('assets/images/kirmizi.png'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Hakkımızda',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "WorkSans-Bold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 370,
                    padding: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'Helimore Havacılık, insansız hava aracı endüstriyel kullanımlar için özelleştirilebilir drone hizmetleri sunar. Yerli tasarım ve yerli imalat ile hızlı teknik servis ve özelleştirmeye elverişlidir. Başak sınıfı zirai insansız hava araçları; karbon fiberden üretilmiş dayanıklı gövdeleri, pek çok kabiliyeti bünyesinde barındıran elektronik uçuş ve görüntü işleme sistemleri, tarıma yeni bir soluk getirecek havadan ilaçlama teknolojisi sayesinde endüstriyel ihtiyaçlarınıza yönelik kalıcı ve sürdürülebilir çözümler yaratır.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: "WorkSans-Bold",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
