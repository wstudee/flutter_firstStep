import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';


/**
 * 2023.04.29
   TextField 스타일 주기

    TextField 위젯 > decoration : InputDecoration()
    1. TextField 양 옆에 아이콘
      icon : , prefixIcon : , suffixIcon :
      * ThemeData 안에 InputDecoration() 넣어서 모든 TextField에 스타일 줄 수 있음
    2. border
      enabledBorder :
      border :
      focusedBorder :
      disabledBorder :
      errorBorder :
      focusedErrorBorder : ...
     - 상하좌우 OutlineInputBorder()
       둥근테두리 borderRadius :
     - 하단 UnderlineInputBorder()
     - 테두리없음 InputBorder.none
     - 배경색 filled : true, fillColor :
    3. 근처에 힌트를 띄우고 싶을 때
     hintText : 'hint'
     helperText : 'helper'
     labelText : 'label'
     counterText : 'counter'

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

  getPermission() async {
    var status = await Permission.contacts.status;
    if(status.isGranted){
      print('허락됨');
      var contacts = await ContactsService.getContacts();  // 연락처 꺼내기 = 오래 걸리는 코드임
      setState(() {
        name = contacts;
      });

    } else if (status.isDenied){
      print('거절됨');
      Permission.contacts.request();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  var total = 3;

  var name = [];
  var like = [0, 0, 0];

  addOne(text){
    setState(() {
      var newPerson = Contact();
      newPerson.givenName = text;

      name.add(newPerson);
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
              title: Text( name[i].givenName ),
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
                decoration: InputDecoration(
                  icon: Icon(Icons.star),
                  suffixIcon: Icon(Icons.cloudy_snowing),
                  filled: true,
                  fillColor: Colors.orange.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none

                  ),
                  hintText: '이름을 입력하세요', // placeHolder
                  labelText: '이름!',
                  counterText: '미야모',
                  helperText: '요 쏘이'
                ),

                onChanged: (text){ inputData2 = text; },
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
