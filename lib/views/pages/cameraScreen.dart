part of 'pages.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({required this.prefix, required this.numbers,
  required this.images, required this.isDMG});

  String prefix;
  String numbers;
  final List<String> images;
  bool isDMG;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

ImageData createImageData(String prefix, String numbers, XFile images) {
  return ImageData(prefix: prefix, numbers: numbers, images: images);
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  List<XFile> capturedImage = [];
  late Data data;

  DataServices dataServices = DataServices(); // Track the upload progress

  double zoomLevel = 1.0;

  void setZoomLevel(double level) async {
    if (level >= 1.0 && level <= 5.0) {
      await _controller.setZoomLevel(level);
      setState(() {
        zoomLevel = level;
      });
    }
  }

  void increaseZoom() {
    if (zoomLevel < 5.0) {
      setZoomLevel(zoomLevel + 0.2);
    }
  }

  void decreaseZoom() {
    if (zoomLevel > 1.0) {
      setZoomLevel(zoomLevel - 0.2);
    }
  }

  void togglePressedState() {
    setState(() {
      widget.isDMG = !widget.isDMG;
    });
  }

  Future<void> _navigateToRenamePrefix() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RenamePrefix(
          prefix: widget.prefix,
          numbers: widget.numbers,
          isDMG: widget.isDMG,
        ),
      ),
    );


    if (updatedData != null) {
      final selectedPrefix = updatedData['prefix'] as String?;
      final selectedNumber = updatedData['numbers'] as String?;
      final isDMG = updatedData['isDMG'] as bool;

      if (selectedPrefix != null && selectedNumber != null) {
        setState(() {
          widget.prefix = selectedPrefix;
          widget.numbers = selectedNumber;
          widget.isDMG = isDMG;
        });
      }
    }
  }


  Future<String?> _uploadImageToFirebaseStorage(XFile images, String imageName,
      String folderName, String folderPath) async {
    try {
      // Mengubah file gambar menjadi tipe File

      final File imageFile = File(images.path);
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('/DKM/IN/$folderPath/$folderName/$imageName');

      // Melakukan pengunggahan gambar ke Firebase Storage
      await storageRef.putFile(imageFile);

      // Mendapatkan URL gambar yang diunggah
      final String downloadURL = await storageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      // Handle error jika terjadi kesalahan saat mengunggah gambar
      print("Error uploading image: $e");
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("Access was denied");
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      showDialog(
        context: context,
        barrierDismissible: false,
        // Jangan biarkan pengguna menutup dialog dengan tap di luar
        builder: (context) {
          return AlertDialog(
            title: Text('Success',
            textAlign: TextAlign.center,
            style: TextStyle(

            ),),
            content: Wrap(
              alignment: WrapAlignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ],
            ), // Indicator loading
          );
        },
      );

      await _controller.setExposureMode(ExposureMode.locked);
      await _controller.setFocusMode(FocusMode.locked);
      XFile image = await _controller.takePicture();

      await _controller.setExposureMode(ExposureMode.auto);
      await _controller.setFocusMode(FocusMode.auto);
      capturedImage.add(image);


      Navigator.of(context).pop();
      print(DateTime.now().microsecondsSinceEpoch);
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          child: CameraPreview(_controller!),
        ),


        //DMG value
        Align(
          alignment: Alignment.topRight,
          child: widget.isDMG ?Padding(
            padding: EdgeInsets.only(right: 10,top: 30),
            child: Container(
              child: Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 2,
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                    child:Text('DAMAGE',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.red,
                    ),),
                  ),
                ],
              ),
            ),
          ):null,
        ),

        //Zoom in Zoom out
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
                  icon: Icon(Icons.zoom_out,
                  size: 50,),
                  onPressed: decreaseZoom,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
                ),

          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.zoom_in,
                size: 50,
              ),
              onPressed: increaseZoom,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
          ),
        ),

        //Jenis barang
        Align(
          alignment: Alignment.bottomLeft,
          child: TextButton(
            onPressed: (){
              _navigateToRenamePrefix();
              },
            child: Padding(
              padding: EdgeInsets.only(bottom: 20, left: 10),
              child: Container(
                color: Colors.blue,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 2,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 7, left: 7, right: 7),
                      child: Text(
                        widget.prefix,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 7, left: 7, right: 7),
                      child: Text(
                        widget.numbers,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ),

        //tombol kamera
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: IconButton(
              icon: Icon(
                Icons.camera_alt_outlined,
                size: 35,
              ),
              padding: EdgeInsets.all(20),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () async {
                if (!_controller!.value.isInitialized) {
                  return null;
                }
                if (_controller!.value.isTakingPicture) {
                  return null;
                }

                try {
                  _takePicture();
                } on CameraException catch (e) {
                  debugPrint("Error occured while taking picture : $e");
                  return null;
                }
              },
              color: Colors.white,
            ),
          ),
        ),

        //tombol Next
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(25),
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 35,
              ),
              padding: EdgeInsets.all(20),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  // Jangan biarkan pengguna menutup dialog dengan tap di luar
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Upload data, mohon tunggu...'),
                      content: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ],
                      ), // Indicator loading
                    );
                  },
                );
                Future.delayed(Duration.zero,() async{

                  for(var images in capturedImage){
                    final data = createImageData(widget.prefix, widget.numbers, images);
                    final now = DateTime.now();
                    final formattedDate = DateFormat('yyyyMMdd').format(now);
                    final formattedDateFolder = DateFormat('yyyy/MM/dd/').format(now);
                    final String formattedSeconds = DateFormat('ss').format(now);
                    final String formattedMilliseconds = DateFormat('SSS').format(now);
                    final String customImageName =
                        '${data.prefix + data.numbers + '_' + formattedDate + '_' + formattedSeconds + '_' + formattedMilliseconds}';
                    final String customImageNames = customImageName + '.jpg';
                    final String folderName = '${data.prefix + data.numbers}';
                    final String folderPath = '$formattedDateFolder';

                    var urlList = (await _uploadImageToFirebaseStorage(
                        images, customImageNames, folderName, folderPath))!;

                    setState(() {});

                    widget.images.add(urlList);
                  }// Close the dialog
                  final data = Data(
                      prefix: widget.prefix,
                      numbers: widget.numbers,
                      images: widget.images,
                      isDMG: widget.isDMG);
                  dataServices.addData(data);
                });

                Navigator.pushReplacementNamed(
                  context, Survei.routeName
                );
              },
            ),
          ),
        )
      ],
    ));
  }
}
