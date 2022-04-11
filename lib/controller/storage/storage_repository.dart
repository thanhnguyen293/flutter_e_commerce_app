// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import '../../controller/storage/base_storage_repository.dart';

// class StorageRepository extends BaseStorageRepository {
//   final firebase_storage.FirebaseStorage storage =
//       firebase_storage.FirebaseStorage.instance;

//   @override
//   Future<String> getDownloadURL(String imageName) async {
//     String downloadURL =
//         await storage.ref('images/$imageName').getDownloadURL();
//     return downloadURL;
//   }
// }
