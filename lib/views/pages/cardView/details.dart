part of '../pages.dart';

class Details extends StatefulWidget {
  String folderPath;

  Details({
    required this.folderPath,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String folderName = '';
  final DataServices dataServices = DataServices();

  @override
  void initState() {
    super.initState();
    // Ekstrak nama folder dari folderPath
    final parts = widget.folderPath.split('/');
    if (parts.isNotEmpty) {
      folderName = parts.last;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.doc(widget.folderPath).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;

          final prefix = data['prefix'];
          final number = data['number'];
          bool isDMG = data['isDMG'];
          final dynamicImages = data['images'] as List;
          final images = dynamicImages.map((item) => item.toString()).toList();

          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text(folderName,
              style: TextStyle(
                fontSize: 30,
              ),),
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              centerTitle: true,
              leading: BackButton(
                onPressed: (){
                  Navigator.pop(context);
                },
              ),

            ),
            body: Align(
              alignment: Alignment.topCenter,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeDetailView(
                                      prefix: prefix,
                                      numbers: number,
                                    isDMG: isDMG,

                                  )));
                        },
                        child: Text(
                          'CHANGE DETAIL',
                          style: TextStyle(fontSize: 25),
                        ),
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            fixedSize: Size(300, 70)),
                      ),
                    ),

                    //Change Status button
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Change Status:'),
                                  content: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'change status?',
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel')),
                                    TextButton(
                                        onPressed: () {
                                          dataServices.deleteData(Data(
                                              prefix: prefix,
                                              numbers: number,
                                              images: images,
                                              isDMG: isDMG));
                                          if (isDMG == false) {
                                            isDMG = true;
                                          } else {
                                            isDMG = false;
                                          }
                                          DataServices().addData(Data(
                                              prefix: prefix,
                                              numbers: number,
                                              images: images,
                                              isDMG: isDMG));
                                          print(isDMG);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Survei()));
                                        },
                                        child: Text('Lanjut')),
                                  ],
                                );
                              });
                        },
                        child: Text(
                          'CHANGE STATUS',
                          style: TextStyle(fontSize: 25),
                        ),
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            fixedSize: Size(300, 70)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CameraScreen(
                                      prefix: prefix,
                                      numbers: number,
                                    images: images,
                                    isDMG: isDMG,
                                  )));
                        },
                        child: Text(
                          'ADD PHOTO',
                          style: TextStyle(fontSize: 25),
                        ),
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            fixedSize: Size(300, 70)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CameraView(
                                      imagesUrl: images,
                                      prefix: prefix,
                                      number: number,
                                      isDMG: isDMG)));
                        },
                        child: Text(
                          'PHOTO REVIEW',
                          style: TextStyle(fontSize: 25),
                        ),
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            fixedSize: Size(300, 70)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
