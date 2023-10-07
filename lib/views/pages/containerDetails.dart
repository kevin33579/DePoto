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
      appBar: AppBar(
        title: Text('Container Details'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: BackButton(onPressed: () {
          Navigator.pushReplacementNamed(context, MainMenu.routeName);
        }),
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
                      fontSize: 25,
                      color: Colors.black,
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
                          fontSize: 25,
                        ),
                      ),
                      value: selectedDropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: dropdownItems.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDropdownValue = value;
                        });
                      },
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        maxLength: 4,
                        textAlign: TextAlign.right,
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
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
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
                  child: Text(
                    'Damage: $isDMG',
                    // Display the current state of the toggle button
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Switch(
                    value: isDMG,
                    onChanged: (value) {
                      setState(() {
                        isDMG = value; // Update the state of the toggle button
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
