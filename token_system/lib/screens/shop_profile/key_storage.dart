import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:token_system/Services/shopService.dart';

class KeyStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/publicTest2.pem');
  }

  Future<String> readKey() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      print("Fetching already stored public key");
      return contents;

    } catch (e) {
      // If encountering an error, return 0
      String key = await downloadKey();
      return key;
    }
  }

  Future<String> downloadKey() async {
    try{
      print("Downloading public key");
      String content = await ShopService.getPublicKey().then((json){
        return json["result"];
      });
      await writeKey(content);
      return content;
    }catch (e) {
      print("Can not download key");
      //TODO: See how to handle error here
      return "ERROR";
    }
  }

  Future<File> writeKey(String key) async {
    final file = await _localFile;

    // Write the file
    print("writing to file");
    return file.writeAsString(key);
  }
}