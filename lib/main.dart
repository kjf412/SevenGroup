import 'package:flutter/material.dart';
import './page/manage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MyIcons {
  // book 图标
  static const IconData book =
      IconData(0xe614, fontFamily: 'myIcon', matchTextDirection: true);
  // 微信图标
  static const IconData wechat =
      IconData(0xec7d, fontFamily: 'myIcon', matchTextDirection: true);
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _deleteCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var choose = 0;
    String icons = "";
    // accessible: 0xe03e
    icons += "\uE03e";
    // error:  0xe237
    icons += " \uE237";
// fingerprint: 0xe287
    icons += " \uE287";
    bool switchSelected = true; //维护单选开关状态
    bool checkboxSelected = true; //维护复选框状态
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '您已经为我的APP点赞了:',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "MyText1",
              style: TextStyle(
                  color: Colors.lightGreen,
//该属性用于指定行高，但它并不是一个绝对值，而是一个因子，具体的行高等于
//fontSize可以精确指定字体大小，而textScaleFactor只能通过缩放比例来控制。
//textScaleFactor主要是用于系统字体大小设置改变时对 Flutter 应用字体进行全局调整，
//而fontSize通常用于单个文本，字体大小不会跟随系统字体大小变化。
                  fontSize: 18.0, //
                  height: 1.2,
//由于不同平台默认支持的字体集不同，所以在手动指定字体时一定要先在不同平台测试一下。              fontFamily: "Courier",
                  background: Paint()
                    ..color = const Color.fromARGB(255, 238, 22, 130),
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed),
            ),
            const Text.rich(TextSpan(children: [
              TextSpan(text: "Home: "),
              TextSpan(
                text: "https://flutterchina.club",
                style: TextStyle(color: Colors.blue),
//_tapRecognizer，它是点击链接后的一个处理器（代码已省略）
                //recognizer: _tapRecognizer
              ),
            ])),
//在 Widget 树中，文本的样式默认是可以被继承的（子类文本类组件未指定具体样式时可以使用 Widget 树中父级设置的默认样式），
//因此，如果在 Widget 树的某一个节点处设置一个默认的文本样式，那么该节点的子树中所有文本都会默认使用这个样式，
//而DefaultTextStyle正是用于设置默认文本样式的。
            DefaultTextStyle(
              //1.设置文本默认样式
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.start,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text("默认格式"),
                  Text("I am Kong（继承默认）"),
                  Text(
                    "I am from China(不继承)",
                    style: TextStyle(
                        inherit: false, //2.不继承默认样式
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.thumbs_up_down),
              onPressed: () {},
            ),
            ElevatedButton.icon(
              label: const Text("取消点赞"),
              icon: const Icon(Icons.thumb_down),
              onPressed: () {
                _deleteCounter();
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text("发送"),
              onPressed: () {},
            ),
            //? 找不到OutlineButton
            // OutlineButton.icon(
            //   icon: Icon(Icons.add),
            //   label: Text("添加"),
            //   onPressed: _onPressed,
            // ),
            TextButton.icon(
              icon: const Icon(Icons.info),
              label: const Text("详情"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => login()),
                );
              },
            ),
            // Image.asset(
            //   "images/hua.jpg",
            //   width: 100,
            //   alignment: Alignment.topLeft,
            // ),
            const Image(
              image: AssetImage("images/meigui.jpg"),
              height: 100.0,
              fit: BoxFit.cover,
            ),

            Text(
              icons,
              style: const TextStyle(
                fontFamily: "MaterialIcons",
                fontSize: 24.0,
                color: Colors.green,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.accessible, color: Colors.green),
                Icon(Icons.error, color: Colors.green),
                Icon(Icons.fingerprint, color: Colors.green),
              ],
            ),
            //由于iconfont.cn上目前在维护，无法注册，无法下载素材
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(MyIcons.book, color: Colors.purple),
                Icon(MyIcons.wechat, color: Colors.green),
              ],
            ),
            Switch(
              value: switchSelected, //当前状态
              onChanged: (value) {
                //重新构建页面
                setState(() {
                  switchSelected = value;
                });
              },
            ),
            Checkbox(
              value: checkboxSelected,
              activeColor: Colors.red, //选中时的颜色
              onChanged: (value) {
                setState(() {
                  checkboxSelected = value;
                });
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'thumb_up',
        child: const Icon(Icons.thumb_up_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class login extends StatelessWidget {
  TextEditingController unameController = TextEditingController();
  TextEditingController mimaController = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode focusScopeNode;
  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String userName;
    String mima;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: unameController, //设置controller
              focusNode: focusNode1,
              decoration: const InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person)),
            ),
            TextField(
              focusNode: focusNode2,
              controller: mimaController,
              decoration: const InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("登录"),
                      ),
                      onPressed: () {
                        // 通过_formKey.currentState 获取FormState后，
                        // 调用validate()方法校验用户名密码是否合法，校验
                        // 通过后再提交数据。
                        userName = unameController.text;
                        mima = mimaController.text;
                        if (userName == 'peple' && mima == '123456') {
                          //验证通过提交数据
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => manage()),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.back_hand_sharp),
              label: const Text("返回"),
              onPressed: () {
                Navigator.pop(context); //从第二个界面返回
              },
            ),
            Builder(
              builder: (ctx) {
                return Column(
                  children: <Widget>[
                    ElevatedButton(
                      child: Text("移动焦点"),
                      onPressed: () {
                        //将焦点从第一个TextField移到第二个TextField
                        // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                        // 这是第二种写法
                        if (null == focusScopeNode) {
                          focusScopeNode = FocusScope.of(context);
                        }
                        focusScopeNode?.requestFocus(focusNode2);
                      },
                    ),
                    ElevatedButton(
                      child: Text("隐藏键盘"),
                      onPressed: () {
                        // 当所有编辑框都失去焦点时键盘就会收起
                        focusNode1.unfocus();
                        focusNode2.unfocus();
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    //监听输入改变
    unameController.addListener(() {
      print(unameController.text);
    });
  }
}
