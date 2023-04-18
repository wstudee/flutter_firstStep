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
          title: Text('봉산동', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          actions: [
            Icon(Icons.search, color: Colors.black),
            Icon(Icons.menu, color: Colors.black),
            Icon(Icons.notifications_none, color: Colors.black)
          ],
        ),
        body: SizedBox(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            child: Row(
              children: [
                Container(
                  child: Image(image: AssetImage('../assets/shuri.png')),
                  decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
                  width: 120,
                  height: 120,
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                ),
                Container(
                  height: 120,
                  child: Column(
                    children: [
                      Container(
                        child: Text('귀야호 슈리~~~~ (뽕주댕이 2짝, 너구리꼬리 1개 포함)'),
                        decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
                        height: 40,
                        width: 300,
                      ),
                      Container(
                        child: Text('경기도 평택시 연쥐하우스·끌올 10분 전',
                          style: TextStyle(color: Color(0xffc9c3c3), fontSize: 12),),
                        decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
                        height: 25,
                        width: 300,
                      ),
                      Container(
                        child: Text('486원', style: TextStyle(fontWeight: FontWeight.bold ),),
                        decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
                        height: 25,
                        width: 300,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.favorite_border),
                                Text('486')
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
                        height: 30,
                        width: 300,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
          )
        )
      );
  }
}
