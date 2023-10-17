part of 'pages.dart';

class MainMenu extends StatefulWidget {
  static const String routeName = '/mainmenu';

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Main Menu',
        style: TextStyle(
          color: Colors.white,
          fontSize: 35
        ),),
        backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(400, 100),
                      textStyle: const TextStyle(fontSize: 35),
                      backgroundColor: Colors.blue,
                      shape: ContinuousRectangleBorder(),
                      padding: EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 15.0, bottom: 15.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Survei.routeName);
                    },
                    child: const Text(
                      'SURVEI',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 35),
                        fixedSize: Size(400, 100),
                        backgroundColor: Colors.blue,
                        shape: ContinuousRectangleBorder(),
                        padding: EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 15.0, bottom: 15.0),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, CraniView.routeName);
                      },
                      child: const Text(
                        'CRANI',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
