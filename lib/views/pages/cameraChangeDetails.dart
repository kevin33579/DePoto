part of 'pages.dart';

class RenamePrefix extends StatefulWidget {
  RenamePrefix({required this.prefix, required this.numbers, required this.isDMG
  });
  final String prefix;
  final String numbers;
  bool isDMG;

  @override
  State<RenamePrefix> createState() => _RenamePrefixState();
}

class _RenamePrefixState extends State<RenamePrefix> {
  String? selectedDropdownValue;
  TextEditingController textControler = TextEditingController();
  TextEditingController manualTextControler = TextEditingController();
  String number = '';
  List<String> capturedImagePath = [];
  String? selectedPrefix;



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
  Map<String, dynamic> getUpdatedData() {
    if (selectedDropdownValue == 'Manual') {
      selectedPrefix = manualTextControler.text;
    } else {
      selectedPrefix = selectedDropdownValue;
    }
      final selectedNumber = textControler.text;

    return {
      'prefix': selectedPrefix,
      'numbers': selectedNumber,
      'isDMG' : widget.isDMG,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Rename',
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

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     Padding(
                        //       padding: EdgeInsets.all(10),
                        //       // child: ToggleButtons(
                        //       //   children: <Widget>[
                        //       //     Padding(padding: EdgeInsets.all(5),
                        //       //       child: Text("AV",
                        //       //         style: TextStyle(
                        //       //           color: Colors.white,
                        //       //           fontSize: 35,
                        //       //           fontWeight: FontWeight.bold,
                        //       //         ),
                        //       //       ),
                        //       //     ),
                        //       //     Padding(padding: EdgeInsets.all(5),
                        //       //       child: Text("DMG",
                        //       //         style: TextStyle(
                        //       //           color: Colors.white,
                        //       //           fontSize: 35,
                        //       //           fontWeight: FontWeight.bold,
                        //       //         ),
                        //       //       ),
                        //       //     ),
                        //       //   ],
                        //       //   isSelected: [!widget.isDMG, widget.isDMG],
                        //       //   selectedColor: isSelected[0] ? Colors.green : Colors.red,
                        //       //   selectedBorderColor: isSelected[0] ? Colors.green : Colors.red,
                        //       //   borderColor: isSelected[0] ? Colors.green : Colors.red,
                        //       //   fillColor: isSelected[0] ? Colors.green : Colors.red,
                        //       //   onPressed: (int index) {
                        //       //     setState(() {
                        //       //       for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                        //       //         if (buttonIndex == index) {
                        //       //           isSelected[buttonIndex] = true;
                        //       //           widget.isDMG = index == 1;
                        //       //         } else {
                        //       //           isSelected[buttonIndex] = false;
                        //       //           widget.isDMG = false;
                        //       //         }
                        //       //       }
                        //       //     });
                        //       //   },
                        //       // ),
                        //       // Transform.scale(
                        //       //   scale: 1.5,
                        //       //   child: Switch(
                        //       //     value: isDMG,
                        //       //     onChanged: (value) {
                        //       //       setState(() {
                        //       //         isDMG = value; // Update the state of the toggle button
                        //       //       });
                        //       //     },
                        //       //     activeColor: Colors.red,
                        //       //     inactiveTrackColor: Colors.greenAccent,
                        //       //     inactiveThumbColor: Colors.green,
                        //       //
                        //       //
                        //       //   ),
                        //       // ),
                        //     ),
                        //   ],
                        // ),

                        //submit button
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: TextButton(
                              child: Text('CHANGE'),
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 35),
                                fixedSize: Size(400, 70),
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: ContinuousRectangleBorder(),
                                padding: EdgeInsets.only(
                                    left: 40.0,
                                    right: 40.0,
                                    top: 15.0,
                                    bottom: 15.0),
                              ),
                              onPressed: isSubmitButtonEnabled()
                                  ? () {
                                final updatedData = getUpdatedData();


                                Navigator.pop(context, updatedData);
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
