// import 'package:flutter/material.dart';
// import 'package:sqlite/contact.dart';
// import 'package:sqlite/dbhelper.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'SQLite CRUD'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   final _fromKey = GlobalKey<FormState>();
//   Contact _contact = Contact();
//   List<Contact> _contacts  = [];
//   DBHelper? _dbHelper;
//   final _ctrlName = TextEditingController();
//   final _ctrlMobile = TextEditingController();
//   @override
//   void initState(){
//     super.initState();
//     setState(() {
//       _dbHelper = DBHelper();
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _from(),
//             _list(),
//           ],
//         ),
//       ),
//     );
//   }
//   _from() => Container(
//     color: Colors.white,
//     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//     child: Form(
//       key: _fromKey,
//       child: Column(
//         children: [
//           TextFormField(
//             controller: _ctrlName,
//             decoration: InputDecoration(
//               labelText: 'Tên',
//             ),
//             onSaved: (val){
//               setState(() {
//                 _contact.name = val;
//               });
//             },
//             validator: (val) =>
//             ((val?.length ?? 0) == 0?  'Tên không được để trống' :null),
//           ),
//           TextFormField(
//             controller: _ctrlMobile,
//             decoration: InputDecoration(
//               labelText: 'Số điện thoại',
//             ),
//             onSaved: (val){
//               setState(() {
//                 _contact.mobile = val;
//               });
//             },
//             validator: (val) =>
//             ((val?.length ?? 0) < 10 ? 'Nhập ít nhất 10 chữ số':null),
//           ),
//           Container(
//             margin: EdgeInsets.all(10.0),
//             child: ElevatedButton(
//               onPressed: _onSubmit,
//               child: Text('Lưu'),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
//   _onSubmit() async {
//     var form = _fromKey.currentState;
//     if(_fromKey.currentState!.validate()){
//       form?.save();
//       if(_contact.id == null){
//         await _dbHelper!.insertContact(_contact);
//       }else{
//         await _dbHelper!.updateContact(_contact);
//       }
//       _refreshData();
//       _resetData();
//     }
//   }
//   _refreshData() async {
//     List<Contact> x = await _dbHelper!.fecthContact();
//     setState(() {
//       _contacts = x;
//     });
//   }
//
//   _resetData(){
//     setState(() {
//       _fromKey.currentState?.reset();
//       _ctrlName.clear();
//       _ctrlMobile.clear();
//       _contact.id == null;
//     });
//   }
//
//   _list() => Expanded(
//       child: Card(
//             margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
//             child: ListView.builder(
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       ListTile(
//                         leading: const Icon(Icons.account_circle, color: Colors.cyan,),
//                         title: Text(_contacts[index].name!.toUpperCase()),
//                         subtitle: Text(_contacts[index].mobile!),
//                         onTap: (){
//                           setState(() {
//                             _contact = _contacts[index];
//                             _ctrlName.text = _contacts[index].name!;
//                             _ctrlMobile.text = _contacts[index].mobile!;
//                           });
//                         },
//                         trailing: IconButton(
//                           onPressed: () async {
//                             await _dbHelper?.deleteContact(_contacts[index]!);
//                             _resetData();
//                             _refreshData();
//                           },
//                           icon: const Icon(Icons.delete_sweep, color: Colors.cyan,),
//                         ),
//                       ),
//                       const Divider(
//                         height: 5.0,
//                       ),
//                     ],
//                   );
//                 },
//               itemCount: _contacts.length,
//             )
//           ),
//       );
// }
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sqlite/contact.dart';
import 'package:sqlite/dbhelper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'SQLite CRUD'),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _fromKey = GlobalKey<FormState>();
  Contact _contact = Contact();
  List<Contact> _contacts  = [];
  DBHelper? _dbHelper;
  final _ctrlName = TextEditingController();
  final _ctrlMobile = TextEditingController();
  @override
  void initState(){
    super.initState();
    setState(() {
      _dbHelper = DBHelper();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _from(),
            Container(
              margin: EdgeInsets.all(10),
              child: const Text('DANH BẠ',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            _list(),
          ],
        ),
      ),
    );
  }
  _from() => Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _fromKey,
      child: Column(
        children: [
          TextFormField(
            controller: _ctrlName,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              hintText: 'Nhập tên',
              contentPadding: EdgeInsets.fromLTRB(25, 20, 25, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSaved: (val){
              setState(() {
                _contact.name = val;
              });
            },
            validator: (val) =>
            ((val?.length ?? 0) == 0 ?  'Tên không được để trống' :null),
          ),
          SizedBox(height: 15,),
          TextFormField(
            controller: _ctrlMobile,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              hintText: 'Nhập số điện thoại',
              contentPadding: EdgeInsets.fromLTRB(25, 20, 25, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSaved: (val){
              setState(() {
                _contact.mobile = val;
              });
            },
            validator: (val) =>
            ((val?.length ?? 0) < 10 ? 'Nhập ít nhất 10 chữ số':null),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
            ),
            margin: EdgeInsets.all(20),
            height: 50,
            width: 150,
            child: ElevatedButton(
              onPressed: _onSubmit,
              child: Text(
                'Lưu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  _onSubmit() async {
    var form = _fromKey.currentState;
    if(_fromKey.currentState!.validate()){
      form?.save();
      if(_contact.id == null){
        await _dbHelper!.insertContact(_contact);
        EasyLoading.showSuccess('Đã Lưu Thành Công!',);
      }
      else{
        await _dbHelper!.updateContact(_contact);
        EasyLoading.showSuccess('Cập Nhật Thành Công!',);
      }
      _resetData();
      _refreshData();
    }
  }
  _refreshData() async {
    List<Contact> x = await _dbHelper!.fecthContact();
    setState(() {
      _contacts = x;
    });
  }
  _resetData() {
    setState(() {
      _fromKey.currentState?.reset();
      _contact.id = null;
      _ctrlName.clear();
      _ctrlMobile.clear();
    });
  }
  _list() => Expanded(
    child: Card(
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.account_circle, color: Colors.cyan,),
                  title: Text(_contacts[index].name!.toUpperCase()),
                  subtitle: Text(_contacts[index].mobile!),
                  onTap: (){
                    setState(() {
                      _contact = _contacts[index];
                      _ctrlName.text = _contacts[index].name!;
                      _ctrlMobile.text = _contacts[index].mobile!;
                    });
                  },
                  trailing: IconButton(
                    onPressed: () async {
                      await _dbHelper?.deleteContact(_contacts[index]);
                      EasyLoading.showSuccess('Đã Xóa Khỏi Danh Bạ!',);
                      _resetData();
                      _refreshData();
                    },
                    icon: const Icon(Icons.delete_sweep, color: Colors.cyan,),
                  ),
                ),
                const Divider(
                  height: 5.0,
                ),
              ],
            );
          },
          itemCount: _contacts.length,
        )
    ),
  );
}

