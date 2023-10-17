part of 'pages.dart';

class CraniCardView extends StatefulWidget {
  String date;
  CraniCardView({
    required this.date
  });

  @override
  State<CraniCardView> createState() => _CraniCardViewState();
}

class _CraniCardViewState extends State<CraniCardView> {
  @override
  Widget build(BuildContext context) {
    final userStream = FirebaseFirestore.instance.collection('DKM/OUT/${widget.date}').snapshots();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.date,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userStream,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Text('Connection Error');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text("Loading...");
          }

          if (!snapshot.hasData) {
            return Text('No data available');
          }

          final documents = snapshot.data?.docs;


          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: (context, index) {
              final document = documents?[index];
              final folderName = document?.id;
              return Padding(
                padding: EdgeInsets.all(20),
                child: ListTile(
                  title: Text(
                    folderName!,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CraniDetails(folderPath: document!.reference.path,date: widget.date,)));
                  },
                  tileColor: Colors.blue,
                ),
              );
            },
          );

        },
      ),
    );
  }
}
