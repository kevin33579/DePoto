part of 'pages.dart';

class Survei extends StatefulWidget {
  static const routeName = '/survei';

  @override
  _SurveiState createState() => _SurveiState();
}

class _SurveiState extends State<Survei> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('SURVEI',
        style: TextStyle(
          color: Colors.white,
          fontSize: 35
        ),),
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainMenu.routeName);
          },
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
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
                      textStyle: const TextStyle(fontSize: 35),
                      backgroundColor: Colors.blue,
                      fixedSize: Size(400, 100),
                      padding: EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 15.0, bottom: 15.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ContainerDetails.routeName);
                    },
                    child: const Text(
                      'NEW',
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
                        padding: EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 15.0, bottom: 15.0),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, SurveiList.routeName);
                      },
                      child: const Text(
                        'LIST',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold
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
