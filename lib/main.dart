import 'package:flutter/material.dart';

/**
 * 2023.04.22
 * 자식위젯에서 부모위젯의 state를 쓰고 싶다!

 * 부모 -> 자식 state 전송하는 방법
 * step1. 보내고
 *  - 전송: 자식위젯(작명: 보낼 state)
 * step2. 등록하고
 * step3. 사용하기
 *
 * 숙제 1. 다른 state를 보내보기
 * (부모 -> 자식 전송 OK , 자식 -> 부모 : 패륜전송 불가능,  -> 옆집 : 불륜전송 불가능)
 * 숙제 2. 부모한테 받은 state a를 버튼 클릭할때마다 +1 하기
 * (힌트 : state를 변경하는 함수를 하나 만들기)
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
  var total = 3;

  var name = ['이수댕', '홍길동', '피자집'];
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
          appBar: AppBar( title: Text(total.toString())),
          body: ListView.builder(
              itemCount: total,
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
                    addOne(inputData2);
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
