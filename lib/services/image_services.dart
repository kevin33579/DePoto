part of 'services.dart';

class ImageServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(
      io.File imageFile, String folderPath, String imageName) async {
    try {
      final Reference storageRef =
          _storage.ref().child(folderPath).child(imageName);
      await storageRef.putFile(imageFile);
      final String downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  String generateCustomImageName(String prefix, String numbers) {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyyMMdd').format(now);
    final formattedDateFolder = DateFormat('yyyy/MM/dd/').format(now);
    final formattedSeconds = DateFormat('ss').format(now);
    final formattedMilliseconds = DateFormat('SSS').format(now);

    return '${prefix + numbers + '_' + formattedDate + '_' + formattedSeconds + '_' + formattedMilliseconds}.jpg';
  }

  String generateFolderPath(String prefix, String numbers) {
    final now = DateTime.now();
    final formattedDateFolder = DateFormat('yyyy/MM/dd/').format(now);
    return '/DKM/IN/$formattedDateFolder/$prefix$numbers';
  }

  Future<void> updateImageNamesAndFolders(
      String newPrefix, String newNumbers, List<io.File> images) async {
    for (var imageFile in images) {
      final newImageName = generateCustomImageName(newPrefix, newNumbers);
      final newFolderPath = generateFolderPath(newPrefix, newNumbers);

      await uploadImage(imageFile, newFolderPath, newImageName);

      // If you want to delete the old image, uncomment the next line.
      // await _storage.ref().child(currentFolderPath).child(currentImageName).delete();

      print("Image updated: $newFolderPath/$newImageName");
    }
  }



  Future<List<String>> listFilesInFolder(String folderPath) async {
    List<String> fileNames = [];

    final Reference storageRef = FirebaseStorage.instance.ref().child(folderPath);
    final ListResult result = await storageRef.list();


    for (final item in result.items) {
      fileNames.add(item.name);
    }

    return fileNames;
  }

  Future<String> renameFile(String oldFilePath, String newFilePath) async {
    final Reference oldRef = FirebaseStorage.instance.ref().child(oldFilePath);
    final Reference newRef = FirebaseStorage.instance.ref().child(newFilePath);


    try {
      final oldFile = await oldRef.getData();
      await newRef.putData(oldFile!).whenComplete(() {
        oldRef.delete().then((_) {
          print('Renamed file from $oldFilePath to $newFilePath');
        });
      });

      return await newRef.getDownloadURL();
    } catch (e) {
      print('Error renaming file: $e');
      return '';
    }
  }


  Future<List<String>> renameFolderImage(String oldPrefix, String oldNumbers, String newPrefix, String newNumbers,bool isDMG,String date) async {
    final folderPath = 'DKM/IN/$date/';
    print(date);
    var folderPathOld = '$folderPath$oldPrefix$oldNumbers';
    if(isDMG== true){
      folderPathOld = '$folderPath$oldPrefix${oldNumbers}DMG';
    }else{
      folderPathOld = '$folderPath$oldPrefix${oldNumbers}';
    }
    List<String> imageUrls = [];

    final files = await listFilesInFolder(folderPathOld);

    for (final file in files) {
      if (file.startsWith('$oldPrefix$oldNumbers')) {
        var newFileName;
        if(isDMG == true){
          newFileName =file.replaceFirst('$oldPrefix${oldNumbers}DMG', '$newPrefix${newNumbers}DMG');
        }else{
          newFileName = file.replaceFirst('$oldPrefix${oldNumbers}', '$newPrefix${newNumbers}');
        }
        String oldFilePath = '$folderPathOld/$file';
        String newFilePath;
        if(isDMG == true){
          newFilePath = '$folderPath/$newPrefix${newNumbers}DMG/$newFileName';
        }else{
          newFilePath = '$folderPath/$newPrefix${newNumbers}/$newFileName';
        }


        final imageUrl = await renameFile(oldFilePath, newFilePath);

        imageUrls.add(imageUrl);
      }
    }
    return imageUrls;


  }
  Future<List<String>> renameFolderImageOnIsDmg(String prefix, String numbers,bool isDMG,String date) async {
    final folderPath = 'DKM/IN/$date/';
    print(date);
    var folderPathOld;
    if(isDMG== true){
      folderPathOld = '$folderPath$prefix${numbers}';
    }else{
      folderPathOld = '$folderPath$prefix${numbers}DMG';
    }
    List<String> imageUrls = [];

    final files = await listFilesInFolder(folderPathOld);
    print(files);

    for (final file in files) {
      if (file.startsWith('$prefix$numbers')) {
        var newFileName;
        if(isDMG == true){
          newFileName = file.replaceFirst('$prefix${numbers}', '$prefix${numbers}DMG');
        }else{
          newFileName = file.replaceFirst('$prefix${numbers}DMG', '$prefix${numbers}');
        }
        String oldFilePath = '$folderPathOld/$file';
        String newFilePath;
        if(isDMG == true){
          newFilePath = '$folderPath$prefix${numbers}DMG/$newFileName';
        }else{
          newFilePath = '$folderPath$prefix${numbers}/$newFileName';
        }


        final imageUrl = await renameFile(oldFilePath, newFilePath);
        imageUrls.add(imageUrl);
      }
    }
    return imageUrls;


  }
}
