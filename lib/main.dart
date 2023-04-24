import 'package:flutter/material.dart';

/**
 * 2023.04.24 응용
 * 1. 완료 버튼 누르면 dialog 닫기 ok 
 * 2. 빈칸으로 완료버튼 누르면 추가 안 되게 ok 
 * 3. 이름 옆에 삭제 버튼과 기능 ok
 * 4. 이름 가나다 정렬 버튼 (sort 함수) ok
 * 5. 전화번호도 보여주기
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
              leading: Image.asset('shuri.png'),
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
