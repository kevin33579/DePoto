part of '../pages.dart';

class ChangeDetailView extends StatefulWidget {
  ChangeDetailView({
    required this.prefix,
    required this.numbers,
    required this.isDMG,
  });

  final prefix;
  final numbers;
  bool isDMG;

  @override
  State<ChangeDetailView> createState() => _ChangeDetailViewState();
}

class _ChangeDetailViewState extends State<ChangeDetailView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Container Details',
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
                                    widget.isDMG = true;
                                  } else {
                                    isSelected[buttonIndex] = false;
                                    widget.isDMG = false;
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
                      ],
                    ),

                    //submit button
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: TextButton(
                          child: Text('CHANGE'),
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20.0),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.only(
                                left: 40.0,
                                right: 40.0,
                                top: 15.0,
                                bottom: 15.0),
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
                                    DataServices().deleteData(
                                        Data(
                                            prefix: widget.prefix,
                                            numbers: widget.numbers,
                                            images: [],
                                            isDMG: false),);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CameraScreen(
                                                prefix: selectedPrefix!,
                                                numbers: selectedNumber,
                                              images: [],
                                              isDMG: widget.isDMG,
                                            )));
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
}
