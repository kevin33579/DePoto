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
      appBar: AppBar(
        title: Text('Main Menu'),
        backgroundColor: Colors.blue,
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
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 15.0, bottom: 15.0),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Survei.routeName);
                    },
                    child: const Text(
                      'Survei',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 15.0, bottom: 15.0),
                      ),
                      onPressed: null,
                      child: const Text(
                        'Crani',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
