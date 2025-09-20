import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileSystem {
  static String imageDirectory = "";
  static String downloadDirectory = "";
  static String dataDirectory = "";
  static String rootDirectory = "";
  static String cacheDirectory = "";
  static String tempDirectory = "";

  static const String resourcesFolderName = "Resources";
  static const String playFolderName = "Play";
  static const String learningToolsFolderName = "LearningTools";
  static const String assignmentsFolderName = "Assignments";
  static const String teacherCornerFolderName = "TeacherCorner";
  static const String oupiRootRepositoryFolderName = "OUPI_RootRepository";

  static init() async {
    Directory directory = await getApplicationSupportDirectory();

    imageDirectory =
        (await Directory('${directory.path}/ImageRepo').create(recursive: true))
            .path;
    downloadDirectory =
        (await Directory('${directory.path}/Downloads').create(recursive: true))
            .path;

    dataDirectory =
        (await Directory('${directory.path}/Data').create(recursive: true))
            .path;

    rootDirectory =
        (await Directory(directory.path).create(recursive: true)).path;

    var appCacheDirectory = await getApplicationCacheDirectory();
    cacheDirectory =
        (await Directory(appCacheDirectory.path).create(recursive: true)).path;

    String appRootDirectory =
        Directory(directory.parent.path ?? "").parent.path;
    tempDirectory =
        (await Directory(appRootDirectory).create(recursive: true)).path;
  }
}
