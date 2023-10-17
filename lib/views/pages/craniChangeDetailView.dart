part of 'pages.dart';

class CraniChangeDetailView extends StatefulWidget {
  CraniChangeDetailView({
    required this.prefix,
    required this.numbers,
    required this.isDMG,
    required this.imageUrl,
    required this.date,
  });

  final prefix;
  final numbers;
  final List<String> imageUrl;
  bool isDMG;
  String date;

  @override
  State<CraniChangeDetailView> createState() => _CraniChangeDetailViewState();
}

class _CraniChangeDetailViewState extends State<CraniChangeDetailView> {
  String? selectedDropdownValue;
  TextEditingController textControler = TextEditingController();
  TextEditingController manualTextControler = TextEditingController();
  String number = '';
  List<String> capturedImagePath = [];
  String? selectedPrefix;
  List<bool> isSelected = [false,true];

  final List<String> dropdownItems = [
    'Manual',
    'AMCU',
    'AMFU',
    'APHU',
    'APZU',
  ];

  bool isSubmitButtonEnabled() {
    if(selectedDropdownValue == "Manual"){
      return manualTextControler.text.toUpperCase().isNotEmpty && manualTextControler.text.toUpperCase().length >=4 && textControler.text.isNotEmpty && textControler.text.length>=7;
    }else{
      return selectedDropdownValue != null && textControler.text.length == 7;

    }
  }

  Future<List<String>> fetchImageLinksFromFirestore() async {
    try {
      final formattedDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

      String finalFolderName;

      if (widget.isDMG == false) {
        finalFolderName = '${widget.prefix + widget.numbers}';
      } else {
        finalFolderName = '${widget.prefix + widget.numbers}_DMG';
      }

      // Construct the Firestore path to the image links
      final dataCollection = FirebaseFirestore.instance.collection('DKM/OUT/$formattedDate');
      final dataDocument = dataCollection.doc(finalFolderName);

      final data = await dataDocument.get();
      final List<String> imageLinks = (data['images'] as List).cast<String>();

      return imageLinks;
    } catch (e) {
      print('Error fetching image links from Firestore: $e');
      return [];
    }
  }

  Future<List<Reference>> fetchImagesInFolder(String folderPath) async {
    final storage = FirebaseStorage.instance;
    ListResult result = await storage.ref(folderPath).listAll();
    return result.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Container Out Details',
          style: TextStyle(
              fontSize: 30
          ),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: BackButton(
          style: ButtonStyle(
              iconSize: MaterialStateProperty.all(30)
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Column(
            children: [
              Text(
                'Prefix : ' + widget.prefix,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                ),
              ),
              Text(
                'Number : ' + widget.numbers,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                ),
              ),
              Container(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'New Prefix',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: DropdownButton(
                                  hint: const Text(
                                    'Select',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                      fontSize: 30,
                                    ),
                                  ),
                                  value: selectedDropdownValue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: dropdownItems.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDropdownValue = value;
                                    });
                                  },
                                  dropdownColor: Colors.black,
                                  iconSize: 40,
                                )),
                          ],
                        ),
                        if (selectedDropdownValue == 'Manual')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Insert Prefix',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 0,
                                height: 10,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    maxLength: 4,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold
                                    ),
                                    onChanged: (value) {
                                      manualTextControler.value = TextEditingValue(
                                          text: value.toUpperCase(),
                                          selection: manualTextControler.selection
                                      );
                                      setState(() {

                                      });
                                    },
                                    controller: manualTextControler,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'can\'t be empty';
                                      }
                                      if (text.length < 4) {
                                        return 'too short';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Number',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              height: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold
                                  ),
                                  maxLength: 7,
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.number,
                                  controller: textControler,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'can\'t be empty';
                                    }
                                    if (text.length < 7) {
                                      return 'too short';
                                    }
                                    return null;
                                  },
                                  onChanged: (text) =>
                                      setState(() => number = text),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //submit button
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: TextButton(
                              child: Text('CHANGE'),
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 35),
                                backgroundColor: Colors.blue,
                                fixedSize: Size(400, 70),
                                foregroundColor: Colors.white,
                                shape: ContinuousRectangleBorder(),
                                padding: EdgeInsets.only(
                                    left: 40.0,
                                    right: 40.0,
                                    top: 15.0,
                                    bottom: 15.0),
                              ),
                              onPressed: isSubmitButtonEnabled()
                                  ? () async {
                                if(selectedDropdownValue == 'Manual'){
                                  selectedPrefix = manualTextControler.text;
                                }else{
                                  selectedPrefix = selectedDropdownValue;
                                }
                                print(widget.imageUrl);
                                if (selectedDropdownValue != null &&
                                    isSubmitButtonEnabled()) {
                                  Future.delayed(Duration.zero,()async{
                                    final selectedNumber = textControler.text;
                                    final image = await CraniImageServices().renameFolderImage(widget.prefix, widget.numbers, selectedPrefix!, selectedNumber, widget.isDMG,widget.date);
                                    CraniDataServices().addData(Data(
                                      prefix: selectedPrefix!,
                                      numbers: selectedNumber,
                                      images: image,
                                      isDMG: widget.isDMG,
                                    ),widget.date);
                                    CraniDataServices().deleteData(Data(
                                      prefix: widget.prefix,
                                      numbers: widget.numbers,
                                      images: widget.imageUrl,
                                      isDMG: widget.isDMG,
                                    ),widget.date);
                                  });
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CraniList()
                                      ));
                                }
                              }
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );

  }
  void _showPrefixDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Select Prefix'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: dropdownItems.map((item) {
              return ListTile(
                title: Text(
                  item,
                  style: TextStyle(
                    color: Colors.black, // Adjust text color as needed
                    fontSize: 20, // Adjust font size as needed
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedDropdownValue = item;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
