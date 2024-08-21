import 'package:flutter/material.dart';

class about_us extends StatelessWidget {
  const about_us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text('من نحن'),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics().applyTo(AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "قسم 'من نحن' في تطبيقنا يقدم نافذة تعريفية عن فكرة تطويرنا",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffe18505),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "نحن مجموعة من المطورين قمنا بتنفيذ هذا المشروع كجزء من مشروع التخرج ",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xffe18505),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      " رسالتنا هي توفير تجربة تطبيق مبتكرة ومفيدة للمستخدمين ",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xffe18505),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "نسعى من خلال هذا المشروع إلى الابتكار والتطوير المستمر لتقديم تجربة ملهمة وفريدة لجميع مستخدمينا",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xffe18505),
                      ),
                      textAlign: TextAlign.center,
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
