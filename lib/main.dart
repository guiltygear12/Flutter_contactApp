import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
          home: MyApp()
      )
  );
}
// #ffbd33 - 연한 주황
// #ff5733 - 감색
// #DAF7A6 - 연한 연두
// #FFC300 - 좀더 노란 색이더 많은 주황
// #FF5733 - 감색보단 좀더 노랑이 더 들어간듯한 색상
// #C70039 - 자주색 스러운 색상

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var nameList = ["테스트1","테스트2","테스트3","테스트4","테스트5","테스트6","테스트7","테스트8"];
  var phoneList = ["010-1111-1111","010-2222-2222","010-3333-3333","010-4444-4444","010-5555-5555","010-6666-6666","010-7777-7777","010-8888-8888"];
  var count = 0;


  var a = "1234".length;

  addFriendCount(){
    setState(() {
      count++;
    });
  }
  addFriend(name,phone){
    setState(() {
      nameList.add(name);
      phoneList.add(phone);
    });
  }
  deleteFriend(index){
    setState(() {
      count--;
      nameList.removeAt(index);
      phoneList.removeAt(index);
    });
  }
  // showList(){
  //   print(nameList);
  //   print(phoneList);
  // }
  @override
  Widget build(BuildContext context) {
    count = nameList.length;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(context: context, builder: (context){
              return DialogUi(addFriendCount : addFriendCount,addFriend: addFriend,);
            });
          },
          foregroundColor: Colors.white,
          backgroundColor: Color(0xffC70039),
          child:  Text(count.toString(),style: TextStyle(fontSize: 16),),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xffff5733),
          leading: Icon(Icons.menu),
          title: Text("전화"),
          actions: [Icon(Icons.phone),Icon(Icons.message),Icon(Icons.contact_page)],
        ),
        body: Container(
          color: Color(0xffDAF7A6),
          width: double.infinity,
            child:ListView.builder(
                itemCount:count,
                itemBuilder: (context, i){
                  return ShopItem(name: nameList[i], phone: phoneList[i],index: i,deleteFriend: deleteFriend,);
                }
            )
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xffff5733),
          child:Bottombar(),
        ),
      );
  }
}
class DialogUi extends StatelessWidget {
  DialogUi({Key? key, this.addFriendCount, this.addFriend}) : super(key: key);
  final addFriendCount, addFriend;
  var inputName = TextEditingController();
  var inputPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(32),
        height: 300,
        child: Column(
          children: [
            SizedBox(
              child: Text("추가하기", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: TextField(
                controller: inputName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "이름"
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: TextField(
                controller: inputPhone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "전화번호"
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    print("이름: "+inputName.text+", 전화번호: "+ inputPhone.text);
                    if(inputName.text != "" && inputPhone.text != ""){
                      addFriendCount();
                      addFriend(inputName.text, inputPhone.text);
                      Navigator.of(context).pop();
                    }
                  }, child: Text("추가",)),
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                    }, child: Text("닫기"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ShopItem extends StatelessWidget {
  const ShopItem ({Key? key, this.name, this.phone, this.index, this.deleteFriend}) : super(key: key);
  final name, phone, index;
  final deleteFriend;
  @override
  Widget build(BuildContext context) {
    return Container(
            height: 120,
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              color: Color(0xffbae868),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffffffff).withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 2,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                // 좌측 이미지
                Container(
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                      child: Image.asset("assets/test.png")
                  ),
                ),
                //우측 정보영역
                Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                  child: Text(name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black87),),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                  child: Text(phone, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black54),),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: TextButton(
                              child: Text("삭제", style: TextStyle(color: Color(0xffff5733), fontSize: 12, fontWeight: FontWeight.w600),),
                              onPressed: (){
                                print(index);
                                deleteFriend(index);
                              },
                            ),
                          )
                        ],
                      )
                    )
                )
              ],
            ),
          );
  }
}
class Bottombar  extends StatelessWidget {
  const Bottombar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.phone, color: Colors.white,),
                Text("다이얼", style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.message, color: Colors.white,),
                Text("메세지", style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.contact_page, color: Colors.white,),
                Text("주소록", style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
