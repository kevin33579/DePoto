part of 'pages.dart';

class CameraView extends StatefulWidget {
  CameraView(
      {required this.imagesUrl,
      required this.prefix,
      required this.number,
      required this.isDMG});

  List<String> imagesUrl;
  String prefix;
  String number;
  bool isDMG;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  DataServices dataServices = DataServices();
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Image Preview",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: widget.imagesUrl.length,
        itemBuilder: (context, index) {
          final imagePath = widget.imagesUrl[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: CachedNetworkImage(
              imageUrl: imagePath,
              width: 25,
              height: 400,
              fit: BoxFit.contain,// Optional error widget
              placeholder: (context, url) => CircularProgressIndicator(), // Optional placeholder widget while loading
              errorWidget: (context, url, error) => Icon(Icons.error), // Optional error widget
            ),
          );
        },
      ),
    );
  }
}
