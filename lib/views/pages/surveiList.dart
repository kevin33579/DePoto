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
    String date = '${selectedDate.year}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}';
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Enter Date',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => CardView(date: date)));
              },
              icon: Icon(Icons.check),
              color: Colors.black,
              iconSize: 30,
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter Date: ",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
