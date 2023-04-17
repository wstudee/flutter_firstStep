import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
// 위 4줄 기본셋팅문법
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // 실제로 코딩하는 영역 - 메인화면 디자인
    // 위젯짜깁기 : 글자, 이미지, 아이콘, 박스위젯
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          title: Text('금호동 3가', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          actions: [Icon(Icons.search), Icon(Icons.menu), Icon(Icons.notifications_none)],
        ),
        body: SizedBox(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
            ),
            width: double.infinity,
            padding: EdgeInsets.all(5),
            child: Container(
              width: double.infinity,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple),
                            ),

                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple),
                            ),

                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple),
                            ),

                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple),
                            ),

                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            )
          )
        )
      );
  }
}
