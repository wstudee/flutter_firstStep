import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * 2023.04.21 다이알로그
 * showDialog
 *
 * * context ?
 * - 커스텀 위젯 만들 때마다 하나씩 생성되는데 이게 뭐야?
 * - build 함수의 context 파라미터
 * - "부모 위젯의 정보를 담고 있는 변수"
 *
 * - 아래 함수들은 context 를 잘 입력해야 작동함
 * showDialog
 * Scaffold.of
 * Navigater.pop
 * Theme.of
 *
 * - 족보 (context)를 생성해 주는 위젯도 있음
 * Builder
 *
 */
void main() {
  runApp( MaterialApp(
      home: MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var name = ['이수댕', '홍길동', '피자집'];
  var like = [0, 0, 0];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButton: Builder(
            builder: (context) {
              return FloatingActionButton(
                onPressed: (){
                  print(context.findAncestorWidgetOfExactType<MaterialApp>());
                  showDialog( // context 에 MaterialApp 이 있어야 작동함 . 그래서 MaterialApp을 뺀거야
                      context: context,
                      builder: (context){
                        return Dialog(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            height: 300,
                            child: Column(
                              children: [
                                Text('Contact',
                                    textAlign: TextAlign.left,
                                    style: TextStyle( fontWeight: FontWeight.bold, fontSize: 30 )),
                                TextField(
                                  textAlign: TextAlign.left,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text('Cancel')),
                                    TextButton(onPressed: (){}, child: Text('Ok'))

                                  ],
                                )

                              ],
                            ),
                          )
                        );
                      }
                  );
                },
              );
            }
          ),
          appBar: AppBar( title: Text('연락처 앱 ')),
          body: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, i){
                return ListTile(
                  leading: Image.asset('shuri.png'),
                  title: Text( name[i] ),
                );
              }
          ),
        );
  }
}
