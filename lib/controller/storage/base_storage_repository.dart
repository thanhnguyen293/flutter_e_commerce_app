abstract class BaseStorageRepository {
  //Future<void> uploadImage(Xfile image);
  Future<String> getDownloadURL(String imageName);
}
