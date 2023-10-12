part of 'pages.dart';

class ContainerDetails extends StatefulWidget {
  static const String routeName = '/containerdetails';

  @override
  _ContainerDetailsState createState() => _ContainerDetailsState();
}

Future<void> _initCameras() async {
  final cameras = await availableCameras();
}

class _ContainerDetailsState extends State<ContainerDetails> {
  String? selectedDropdownValue;
  TextEditingController textControler = TextEditingController();
  TextEditingController manualTextControler = TextEditingController();
  String number = '';
  List<String> capturedImagePath = [];
  bool isDMG = false;
  bool showTextField = false;
  String? selectedPrefix;
  List<bool> isSelected = [true, false];

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
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButton(
                      hint: const Text(
                        'Select',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          fontSize: 35,
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
                            fontSize: 35,
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
                      iconSize: 50,
                    )
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
                      child: Text("AV",
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
                  // Transform.scale(
                  //   scale: 1.5,
                  //   child: Switch(
                  //     value: isDMG,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         isDMG = value; // Update the state of the toggle button
                  //       });
                  //     },
                  //     activeColor: Colors.red,
                  //     inactiveTrackColor: Colors.greenAccent,
                  //     inactiveThumbColor: Colors.green,
                  //
                  //
                  //   ),
                  // ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       isDMG = !isDMG;
                //     });
                //   },
                //   child: Container(
                //     // width: Size.width * 0.35,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(30),
                //         color: Colors.green),
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Row(
                //         mainAxisAlignment:
                //         MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             width: 60,
                //             height: 30,
                //             decoration: BoxDecoration(
                //                 borderRadius:
                //                 BorderRadius.circular(30),
                //                 color: val
                //                     ? Colors.white
                //                     : kSecondaryColor),
                //             child: Center(
                //                 child: Text(
                //                   'BUY',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: val
                //                           ? Colors.black
                //                           : Colors.white),
                //                 )),
                //           ),
                //           Container(
                //             width: 60,
                //             height: 30,
                //             decoration: BoxDecoration(
                //                 borderRadius:
                //                 BorderRadius.circular(30),
                //                 color: val
                //                     ? kSecondaryColor
                //                     : Colors.white),
                //             child: Center(
                //                 child: Text(
                //                   'SELL',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: val
                //                           ? Colors.white
                //                           : Colors.black),
                //                 )),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),

            //submit button
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: TextButton(
                  child: Text('Submit'),
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20.0),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 15.0, bottom: 15.0),
                  ),
                  onPressed: isSubmitButtonEnabled()
                      ? () {
                    if(selectedDropdownValue == 'Manual'){
                      selectedPrefix = manualTextControler.text;
                    }else{
                      selectedPrefix = selectedDropdownValue;
                    }
                          if (selectedDropdownValue != null &&
                              isSubmitButtonEnabled()) {
                            final selectedNumber = textControler.text;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CameraScreen(
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
}
