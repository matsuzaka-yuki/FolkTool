import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

class Constants {
  static String get appVersion => '1.2.1';
  static String get appName => 'FolkTool';
  static String get appFullName => 'FolkTool - KernelPatch 自动刷入工具';
  
  static String get _exeDir => File(Platform.resolvedExecutable).parent.path;
  
  static bool get _isReleaseMode {
    final exeFile = File(Platform.resolvedExecutable);
    final dataDir = Directory(p.join(exeFile.parent.path, 'data', 'flutter_assets', 'bin'));
    return dataDir.existsSync();
  }
  
  static String get _assetsRoot {
    if (_isReleaseMode) {
      final exeFile = File(Platform.resolvedExecutable);
      return p.join(exeFile.parent.path, 'data', 'flutter_assets');
    }
    return _projectRoot;
  }
  
  static String get _projectRoot {
    // 在开发环境中，使用当前工作目录
    final currentDir = Directory.current.path;
    
    // 检查当前目录是否是 FolkTool 项目根目录
    final binDir = Directory(p.join(currentDir, 'bin'));
    final apkDir = Directory(p.join(currentDir, 'apk'));
    final kptoolsDir = Directory(p.join(currentDir, 'kptools'));
    
    if (binDir.existsSync() && apkDir.existsSync() && kptoolsDir.existsSync()) {
      return currentDir;
    }
    
    // 如果当前目录不是项目根目录，尝试向上查找
    var dir = Directory(currentDir);
    for (int i = 0; i < 5; i++) {
      final testBin = Directory(p.join(dir.path, 'bin'));
      final testApk = Directory(p.join(dir.path, 'apk'));
      final testKptools = Directory(p.join(dir.path, 'kptools'));
      
      if (testBin.existsSync() && testApk.existsSync() && testKptools.existsSync()) {
        return dir.path;
      }
      
      if (dir.parent.path == dir.path) break;
      dir = dir.parent;
    }
    
    // 发布版本的查找逻辑
    final exeFile = File(Platform.resolvedExecutable);
    dir = exeFile.parent;
    
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
  
  static String get kptoolsPath => p.join(_assetsRoot, 'kptools', 'kptools.exe');
  static String get adbPath => p.join(_assetsRoot, 'bin', 'adb.exe');
  static String get fastbootPath => p.join(_assetsRoot, 'bin', 'fastboot.exe');
  static String get kpimgPath => p.join(_assetsRoot, 'assets', 'kpimg');
  
  static String get apatchApkPath => p.join(_assetsRoot, 'apk', 'APatch.apk');
  static String get folkpatchApkPath => p.join(_assetsRoot, 'apk', 'FolkPatch.apk');
  
static const String apatchPackageName = 'me.bmax.apatch';
static const String folkpatchPackageName = 'me.yuki.folk';
  
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
