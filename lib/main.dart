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
  var a = 3; // 이걸 쓰고 싶다 !
  var name = ['이수댕', '홍길동', '피자집'];
  var like = [0, 0, 0];

  updateState(){
    setState(() {
      a++;
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
                        return DialogUI(state : a, name : name, updateState : updateState); // step1 전송
                      }
                  );
                },
              );
            }
          ),
          appBar: AppBar( title: Text(a.toString())),
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


class DialogUI extends StatelessWidget {
  // {} 중괄호 파라미터는 옵셔널
  DialogUI({Key? key, this.state, this.name, required this.updateState}) : super(key: key);
  // step2. 등록은 2군데
  // const를 지우던지 변수를 final로 만들던지
  // 보통 부모가 보낸거는 수정 안하기 때문에 final 사용이 관습
  final state;
  final name;
  final updateState;

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
                textAlign: TextAlign.left,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    // 현재 페이지 닫힘
                    Navigator.pop(context);
                  }, child: Text('Cancel')),
                  TextButton(onPressed: (){
                    print(state.toString());
                    updateState();
                    /*setState(() {
                      widget.state++;
                    });*/
                  }, child: Text('확인')),  // step3. 사용하기
                  TextButton(onPressed: (){}, child: Text(state.toString()))  // step3. 사용하기
                ],
              )

            ],
          ),
        )
    );
  }
}
