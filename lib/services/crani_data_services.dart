part of 'services.dart';

class CraniDataServices{
  static CollectionReference dataCollection = FirebaseFirestore.instance.collection('DKM/OUT');
  static DocumentReference? dataDocument;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Reference? ref;
  static UploadTask? uploadTask;

  final now = DateTime.now();



  Future<void> updateData(Data data,String date) async{
    final finalFolderName;

    if(data.isDMG == false) {
      finalFolderName = '${data.prefix+data.numbers}';
    }else {
      finalFolderName = '${data.prefix + data.numbers}DMG';
    }

    try {
      // Split formattedDate into year, month, and day



      final dkmDocRef = _firestore.collection('DKM/OUT/$date').doc(finalFolderName);

      await dkmDocRef.update({
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
  Future<void> addData(Data data,String date) async{
    final finalFolderName;

    if(data.isDMG == false) {
      finalFolderName = '${data.prefix+data.numbers}';
    }else {
      finalFolderName = '${data.prefix + data.numbers}DMG';
    }

    try {



      final dkmDocRef = _firestore.collection('DKM/OUT/$date').doc(finalFolderName);

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

  Future<void> deleteData(Data data,String date) async{
    try{
      String oldFolderName;

      if(data.isDMG == false){
        oldFolderName = '${data.prefix+data.numbers}';
      }else{
        oldFolderName = '${data.prefix+data.numbers}DMG';
      }

      final doc = await _firestore.collection('/DKM/OUT/$date').doc(oldFolderName);
      doc.delete();

    }catch (e) {
      print('Error saving data to Firestore: $e');
      throw e;
    }
  }

  Future<void> updateDataWithNewPrefixAndNumbers(
      String oldPrefix,
      String oldNumbers,
      String newPrefix,
      String newNumbers,
      bool isDMG,
      String date,) async {
    try {
      // 1. Retrieve existing image URLs from Firestore
      final finalFolderName =
      isDMG ? '$newPrefix$newNumbers'+'DMG' : '$newPrefix$newNumbers';
      final oldFolderName =
      isDMG ? '$newPrefix$newNumbers'+'DMG' : '$newPrefix$newNumbers';
      final dataCollection = FirebaseFirestore.instance.collection('DKM/OUT/$date');
      final dataDocument = dataCollection.doc(oldFolderName);
      final dataNewDocument = dataCollection.doc(finalFolderName);
      final data = await dataDocument.get();
      final List<String> imageLinks = (data['images'] as List).cast<String>();


      // 2. Update the Firestore document with the new prefix and numbers
      await dataNewDocument.set({
        'prefix': newPrefix,
        'number': newNumbers,
        'images': imageLinks,
        'isDMG': isDMG,
      });

      // 3. Loop through existing image URLs and update/rename them
      for (String imageUrl in imageLinks) {
        // Extract the image name from the URL
        final imageName = imageUrl.split('/').last;

        // 4. Copy the images to the new storage references
        final oldStorageRef = FirebaseStorage.instance.ref().child(imageName);
        final newStorageRef = FirebaseStorage.instance
            .ref()
            .child('/DKM/OUT/$date/$finalFolderName/$imageName');

        await oldStorageRef.writeToFile((await newStorageRef.getDownloadURL()) as io.File);

        // 5. If needed, delete the old images
        // Delete the old image after copying if desired
        await oldStorageRef.delete();
      }

      // 6. Update the Firestore document with the new image URLs
      final updatedImageLinks = imageLinks
          .map((imageUrl) => '/DKM/OUT/$date/$finalFolderName/${imageUrl.split('/').last}')
          .toList();
      await dataDocument.update({'images': updatedImageLinks});
    } catch (e) {
      print('Error updating data in Firestore and Firebase Storage: $e');
    }
  }


}