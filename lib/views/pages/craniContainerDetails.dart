part of 'pages.dart';

class CraniContainerDetails extends StatefulWidget {
  static const String routeName = '/containerdetails';


  @override
  _CraniContainerDetailsState createState() => _CraniContainerDetailsState();
}

class _CraniContainerDetailsState extends State<CraniContainerDetails> {
  String? selectedDropdownValue;
  TextEditingController textControler = TextEditingController();
  TextEditingController prefixTextControler = TextEditingController();
  String number = '';
  List<String> capturedImagePath = [];
  bool isDMG = false;
  bool showTextField = false;
  String? selectedPrefix;
  List<bool> isSelected = [true, false];

  List<String> dropdownItems = ["Manual"];

  @override
  void initState() {
    super.initState();
    prefixData();
  }


  bool isSubmitButtonEnabled() {
    if(selectedPrefix == 'Manual') {
      return prefixTextControler.text.length == 4 &&
          textControler.text.length == 7;
    }else{
      return selectedPrefix != '' && textControler.text.length == 7;
    }

  }

  void prefixData() async {
    // Reference to the Firestore collection and document
    String collectionPath = "Prefix"; // Replace with your actual collection path
    String documentId = "hB9lUoxOLMXHwvyFTied"; // Replace with the actual document ID
    String fieldName = "prefix"; // Replace with the actual field name

    DocumentSnapshot documentSnapshot =
    await FirebaseFirestore.instance.collection(collectionPath).doc(documentId).get();

    if (documentSnapshot.exists) {
      // Access the data in the document
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      if (data.containsKey(fieldName)) {
        // Access the field data (assuming it's a List<String>)
        setState(() {
          dropdownItems = List<String>.from(data[fieldName]);
        });
      }
      print("exist");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Container Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        },
          color: Colors.white,
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    selectedDropdownValue = null;
                    textControler.clear();
                  });
                },
              )),
        ],
      ),
      body: Container(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Prefix',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 1),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(ContinuousRectangleBorder()),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                        ),
                        onPressed: () {
                          _showPrefixDialog(context);
                        },
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Text(
                                selectedDropdownValue != null ? selectedDropdownValue! :'Select' ,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 35,
                                  color: selectedDropdownValue != null ? Colors.white : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 0),
                              child:
                              Icon(Icons.keyboard_arrow_down, size: 35),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //     padding: EdgeInsets.all(10.0),
                    //     child: DropdownButton<String>(
                    //
                    //       hint: const Text(
                    //         'Select',
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.grey,
                    //           fontSize: 35,
                    //         ),
                    //       ),
                    //       value: selectedDropdownValue,
                    //       icon: const Icon(Icons.keyboard_arrow_down),
                    //       items: dropdownItems.map((String item) {
                    //         return DropdownMenuItem<String>(
                    //           value: item,
                    //           child: Text(item,
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 35,
                    //             fontWeight: FontWeight.bold
                    //           ),),
                    //         );
                    //       }).toList(),
                    //       onChanged: (value) {
                    //         setState(() {
                    //           selectedDropdownValue = value;
                    //         });
                    //       },
                    //       dropdownColor: Colors.black,
                    //       iconSize: 50,
                    //     )
                    // ),
                  ],
                ),
                if (selectedDropdownValue == 'Manual')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Prefix',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70.0, // Adjust the width as needed
                        height: 10.0, // Adjust the height as needed
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
                            maxLength: 4,
                            textAlign: TextAlign.right,
                            cursorColor: Colors.white,
                            onChanged: (value) {
                              prefixTextControler.value = TextEditingValue(
                                  text: value.toUpperCase(),
                                  selection: prefixTextControler.selection
                              );
                              setState(() {

                              });
                            },
                            controller: prefixTextControler,
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
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40.0, // Adjust the width as needed
                      height: 10.0, // Adjust the height as needed
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          maxLength: 7,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          controller: textControler,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'can\'t be empty';
                            }
                            if (text.length < 7) {
                              return 'too short';
                            }
                            return null;
                          },
                          onChanged: (text) => setState(() => number = text),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ToggleButtons(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(5),
                            child: Text("  AV  ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5),
                            child: Text("DMG",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        isSelected: isSelected,
                        selectedColor: isSelected[0] ? Colors.green : Colors.red,
                        selectedBorderColor: isSelected[0] ? Colors.green : Colors.red,
                        borderColor: isSelected[0] ? Colors.green : Colors.red,
                        fillColor: isSelected[0] ? Colors.green : Colors.red,
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                              if (buttonIndex == index) {
                                isSelected[buttonIndex] = true;
                                isDMG = true;
                              } else {
                                isSelected[buttonIndex] = false;
                                isDMG = false;
                              }
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),

                //submit button
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: TextButton(
                      child: Text('SUBMIT'),
                      style: TextButton.styleFrom(
                        fixedSize: Size(400, 70),
                        textStyle: const TextStyle(fontSize: 35),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: ContinuousRectangleBorder(),
                        padding: EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 15.0, bottom: 15.0),
                      ),
                      onPressed: isSubmitButtonEnabled()
                          ? () {
                        if(selectedDropdownValue == 'Manual'){
                          selectedPrefix = prefixTextControler.text;
                        }else{
                          selectedPrefix = selectedDropdownValue;
                        }
                        if (selectedDropdownValue != null &&
                            isSubmitButtonEnabled()) {
                          final selectedNumber = textControler.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CraniCameraScreen(
                                prefix: selectedPrefix!,
                                numbers: selectedNumber,
                                images: [],
                                isDMG: isDMG,
                              ),
                            ),
                          );
                        }
                      }
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          )),
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
