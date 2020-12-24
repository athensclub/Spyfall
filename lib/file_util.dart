import 'package:path_provider/path_provider.dart';

class FileUtils{

  /// Get the path to the local folder of this application
  static Future<String> get localPath async {
    return (await getApplicationDocumentsDirectory()).path;
  }
}