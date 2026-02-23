import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

class Constants {
  static String get appVersion => '1.0.0';
  static String get appName => 'FolkTool';
  static String get appFullName => 'FolkTool - KernelPatch 自动刷入工具';
  
  static String get _exeDir => File(Platform.resolvedExecutable).parent.path;
  
  static String get _projectRoot {
    final exeFile = File(Platform.resolvedExecutable);
    var dir = exeFile.parent;
    
    for (int i = 0; i < 10; i++) {
      if (!dir.existsSync()) break;
      final baseName = p.basename(dir.path).toLowerCase();
      if (baseName == 'folktool_app' || baseName == 'FolkTool-Windows-Release') {
        return dir.path;
      }
      final parent = dir.parent;
      if (parent.path == dir.path) break;
      dir = parent;
    }
    
    return _exeDir;
  }
  
  static String get kptoolsPath => p.join(_projectRoot, 'kptools', 'kptools.exe');
  static String get adbPath => p.join(_projectRoot, 'bin', 'adb.exe');
  static String get fastbootPath => p.join(_projectRoot, 'bin', 'fastboot.exe');
  static String get kpimgPath => p.join(_projectRoot, 'assets', 'kpimg');
  
  static String get outputDirName => 'FolkTool/patched';
  static String get logsDirName => 'FolkTool/logs';
  static String get backupDirName => 'FolkTool/backup';
  
  static int get adbTimeout => 30;
  static int get fastbootTimeout => 60;
  static int get flashTimeout => 120;
  static int get rebootWaitTime => 5;
  
  static String get defaultSuperKey => '';
  static int get maxRecentFiles => 10;
  
  static String get superKeyKey => 'last_super_key';
  static String get recentFilesKey => 'recent_files';
}
