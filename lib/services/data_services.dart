part of 'services.dart';

class DataServices{
  static CollectionReference DataCollection = FirebaseFirestore.instance.collection('DKM/IN');
  static DocumentReference? DataDocument;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Reference? ref;
  static UploadTask? uploadTask;

  final now = DateTime.now();



  Future<void> addData(Data data) async{
    final formattedDate = DateFormat('yyyy/MM/dd').format(now);
    final finalFolderName;

    if(data.isDMG == false) {
      finalFolderName = '${data.prefix+data.numbers}';
    }else {
      finalFolderName = '${data.prefix + data.numbers}_DMG';
    }

    try {
      // Split formattedDate into year, month, and day
      List<String> dateParts = formattedDate.split('/');
      String year = dateParts[0];
      String month = dateParts[1];
      String day = dateParts[2];



      final dkmDocRef = _firestore.collection('DKM/IN/$year/$month/$day').doc(finalFolderName);

      await dkmDocRef.set({
        'prefix': data.prefix,
        'number': data.numbers,
        'images': data.images,
        'isDMG' : data.isDMG
      });
    } catch (e) {
      print('Error saving data to Firestore: $e');
      throw e;
    }
  }

  Future<void> deleteData(Data data) async{
    final formattedDate = DateFormat('yyyy/MM/dd').format(now);
    try{
      List<String> dateParts = formattedDate.split('/');
      String year = dateParts[0];
      String month = dateParts[1];
      String day = dateParts[2];
      String oldFolderName;

      if(data.isDMG == false){
        oldFolderName = '${data.prefix+data.numbers}';
      }else{
        oldFolderName = '${data.prefix+data.numbers}_DMG';
      }

     final doc = await _firestore.collection('/DKM/IN/$year/$month/$day').doc(oldFolderName);
     doc.delete();

    }catch (e) {
      print('Error saving data to Firestore: $e');
      throw e;
    }
  }


}