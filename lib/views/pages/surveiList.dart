part of 'pages.dart';

class SurveiList extends StatefulWidget {
  static const String routeName = '/surveilist';

  @override
  State<SurveiList> createState() => _SurveiListState();
}

class _SurveiListState extends State<SurveiList> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    String date =
        '${selectedDate.year}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}';
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Enter Date',
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
            style: IconButton.styleFrom(iconSize: 35),
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter Date: ",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey
                    ),
                    child: Text(
                      date,
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardView(date: date)));
                  },
                  child: Text(
                    "Proses",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    fixedSize: MaterialStateProperty.all(Size(500, 70)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
