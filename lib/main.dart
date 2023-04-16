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
        appBar: AppBar( title: Text('앱임') ),
        //body: Center(
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity, // 부모를 넘지 않는 선에서 꽉 차게
            height: 150, // color: Colors.blue,
            padding: EdgeInsets.all(20),
            // padding: EdgeInsets.fromLTRB(left, top, right, bottom),
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(color:Colors.black)
            ),
            child: Text('dddd')
          ),
        )
      ),
    );
  }
}
