import 'package:flutter/material.dart';

class LearnPath{
  String title;
  String desc;
  bool isLocked;
  List<LearnPathChild> child;

  LearnPath({this.title,this.desc,this.isLocked, this.child});
}

class LearnPathChild{
  String title;
  String desc;
  bool isLocked;

  LearnPathChild({this.title,this.desc,this.isLocked});
}

List<LearnPath> learnPaths = [
  LearnPath(
    title: "Fungsi Kuadrat", desc: "3 materi | 2 kuis", isLocked: false,
    child: [
      LearnPathChild(title:"Fungsi Kuadrat", desc: "Mulai Belajar", isLocked: false,),
      LearnPathChild(title:"Fungsi Kuadrat 2", desc: "Mulai Belajar", isLocked: true,),
      LearnPathChild(title:"Fungsi Kuadrat 3", desc: "Mulai Belajar", isLocked: true,),
    ]
  ),
  LearnPath(title: "Fungsi Kuadrat", desc: "3 materi | 2 kuis", isLocked: true),
  LearnPath(title: "Fungsi Kuadrat", desc: "3 materi | 2 kuis", isLocked: true),
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff7E55BF).withOpacity(.8),
              Color(0xff6C76E0).withOpacity(.8),
            ]
          )
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Image.asset("assets/images/shape1.png"),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: Image.asset("assets/images/shape2.png"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _appbar(),
                _heading(),
                _learnPaths()
              ],
            )
            
          ],
        ),
      ),
    );
  }

  Widget _heading(){
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("X IPA A Matematika",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 26),),
          SizedBox(height: 4,),
          Text("Kelas X",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300, fontSize: 18),),
          SizedBox(height: 4,),
          Text("3 Learning Path",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300, fontSize: 16),),
          SizedBox(height: 30,),
          Text("Learning Path",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),),
        ],
      ),
    );
  }

  Widget _learnPaths(){
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: 400,
      child: ListView(
        children: <Widget>[
          ...learnPaths.map((d) => Container(child:PathItem(item: d),margin: EdgeInsets.only(bottom: 10),)).toList()
        ],
      ),
    );
  }


  AppBar _appbar(){
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(icon:Icon(Icons.arrow_back),
        onPressed:() => print("back"),
      ),
    );
  }
}

class PathItem extends StatefulWidget{

  LearnPath item;

  PathItem({Key key, this.item});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PathItemState();
  }

}

class _PathItemState extends State<PathItem>{

  bool childOpen = false;

  LearnPath item;

  BorderRadius radius() => BorderRadius.all(Radius.circular(20));

  BoxDecoration decor() => BoxDecoration(
    borderRadius: radius(),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        offset: Offset(0,3),
        color: Color(0xff6C76E0)
      )
    ]
  );

  @override
  void initState(){
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      borderRadius: radius(),
      child: InkWell(
        borderRadius: radius(),
        splashColor: Colors.black,
        child: Container(
          padding: EdgeInsets.fromLTRB(20,20,20,0),
          decoration: decor(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _content(),
              _child(),
              SizedBox(height: 30,),
              !item.isLocked ? Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      childOpen = (!childOpen);  
                    });
                  },
                  child: Icon(childOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,color: Color(0xff6C76E0),),
                ),
              ) : Container()
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _child(){
    return (item.child != null) ? AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: childOpen? 200 : 0,
      margin: EdgeInsets.only(top: 10),
      child:  ListView(
        children: <Widget>[
          ...item.child.map((d) =>_childItem(d)).toList()
        ],
      ),
    ): Container();
  }

  Widget _childItem(LearnPathChild data){

    IconData iconAction = data.isLocked? Icons.lock_outline: Icons.chevron_right;
    IconData iconItemType  = data.isLocked? Icons.chat : Icons.play_circle_outline;
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(iconItemType,size: 36,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(data.title,style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(data.desc)
                ],
              )
            ],
          ),
          IconButton(icon: Icon(iconAction,color: Color(0xff6C76E0)))
        ],
      ),
    );
  }

  Widget _content(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(item.title, style: TextStyle(color: (item.isLocked? Colors.grey:Colors.black),fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 5,),
            Text(item.desc, style: TextStyle(color: Colors.grey),),
          ],
        ),
        item.isLocked ? Icon(Icons.lock,size: 36,color: Color(0xff6C76E0),): Container()
      ],
    );
  }

}