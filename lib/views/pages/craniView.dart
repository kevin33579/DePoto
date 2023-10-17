part of 'pages.dart';

class CraniView extends StatefulWidget {
  static const String routeName = '/crani';

  @override
  State<CraniView> createState() => _CraniViewState();
}

class _CraniViewState extends State<CraniView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Crani',
          style: TextStyle(
              color: Colors.white,
              fontSize: 35
          ),),
        backgroundColor: Colors.black,
        centerTitle: true,
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
                      // shape: ,
                      padding: EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 15.0, bottom: 15.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, CraniContainerDetails.routeName);
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
                        shape: ContinuousRectangleBorder(),
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 15.0, bottom: 15.0),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, CraniList.routeName);
                      },
                      child: const Text(
                        'LIST',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
