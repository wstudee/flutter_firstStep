import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


/**
 * 2023.04.26.
 * 유저 허락 받기
 *
 * 허락팝업 패키지 설치
 * pubspec.yaml
 *
 * gradle.properties
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

  // await : 끝날때까지 기다려주세요
  // dart 특징. 오래걸리는 줄 제껴두고 다음 줄 실행하려고 함

  getPermission() async {
    // 패키지 만든 사람이 짠 코드임
    var status = await Permission.contacts.status;
    if(status.isGranted){
      print('허락됨');
    } else if (status.isDenied){
      print('거절됨');
      Permission.contacts.request();
    }
  }

  @override
  void initState() {
    super.initState();
    // 앱 실행되면 물어보기
    // 요즘에는 여기다 안함 -> 필요할 때 띄우기
    // getPermission();
  }

  var total = 3;

  var name = [['말숙', '010-1234-1234'], ['홍길동', '010-5678-5678'], ['피자집', '010-9090-90900']];
  var like = [0, 0, 0];

  addOne(text){
    setState(() {
      total++;
      name.add(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: (){
              print(context.findAncestorWidgetOfExactType<MaterialApp>());
              showDialog(
                  context: context,
                  builder: (context){
                    return DialogUI( addOne : addOne ); // step1 전송
                  }
              );
            },
          );
        }
      ),

      appBar: AppBar( title: Text(total.toString()) ,
          actions: [
            IconButton(onPressed: (){
              getPermission();
            }, icon: Icon(Icons.contacts))
          ],
          leading: ElevatedButton(child: Icon(Icons.sort_by_alpha),
            onPressed: (){
              setState(() {
                // 문자 오름차순
                // name.sort();
                name.sort((a, b) => a[0].compareTo(b[0]));
                // 숫자 내림차순 list.reversed
                // 문자 내림차순
                // name.sort((b, a) => a.compareTo(b));
              });
            },
          )
      ),
      body: ListView.builder(
          itemCount: name.length,
          itemBuilder: (context, i){
            return ListTile(
              leading: Image.asset('assets/shuri.png'),
              title: Text( name[i][0] + ' ' +  name[i][1] ),
              trailing: ElevatedButton(child: Text('삭제'),
                onPressed: (){
                  setState(() {
                    name.removeAt(i);
                  });
                }
              ),
            );
          }
      ),
    );
  }
}


class DialogUI extends StatelessWidget {
  // {} 중괄호 파라미터는 옵셔널
  DialogUI({Key? key, this.addOne }) : super(key: key);

  final addOne;

  // 유저가 입력한 데이터를 변수에 담자
  var inputData = TextEditingController();
  var inputData2 = '';
  // [] list {} map

  @override
  build(context) {
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
                // controller: inputData,
                // controller 보다 조금 더 직관적인 방법
                onChanged: (text){ inputData2 = text; },  // 입력값(text)이 변하면 코드를 실행해줘
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    // 현재 페이지 닫힘
                    Navigator.pop(context);
                  }, child: Text('Cancel')),
                  TextButton(onPressed: (){
                    if ( inputData2 != null && inputData2 != '' ){
                      addOne(inputData2);
                    }

                    Navigator.pop(context);
                    /*setState(() {
                      widget.state++;
                    });*/
                  }, child: Text('확인')),  // step3. 사용하기
                  TextButton(onPressed: (){}, child: Text( '취소' ))  // step3. 사용하기
                ],
              )

            ],
          ),
        )
    );
  }
}
