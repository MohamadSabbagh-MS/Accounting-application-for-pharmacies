import 'package:flutter/material.dart';

class about_app extends StatelessWidget {
  const about_app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1e224c),
        title: Text('عن التطبيق'),
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
                      "تطبيق محاسبة إلكتروني خاص بالصيادلة",
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
                      "الهدف منه حل مشكلة تحديث الأسعار المتكرر بسبب الظروف الراهنة في البلد",
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
                      " كما يعتبر حلاً مبدئياً لأصحاب الصيدليات الذين لا يستطيعون شراء حاسوب خاص للصيدلية لأغراض الشراء والبيع ",
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
                      "يتضمن التطبيق المبادئ الرئيسية في المحاسبة مثل الفواتير البيع والشراء والمرتجعات والسندات (القبض-الدفع) وإعداد التقارير وإدارة المخزون",
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
                      "يتميز المشروع بواجهاته البسيطة التي تسهل التعامل معها بكل سهولة وسلاسة لأي صيدلي",
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
