import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

class Constants {
  static String get appVersion => '1.5.0';
  static String get appName => 'FolkTool';
  static String get appFullName => 'FolkTool - KernelPatch 自动刷入工具';
  
  static String get _exeDir => File(Platform.resolvedExecutable).parent.path;
  
  static bool get _isReleaseMode {
    final exeFile = File(Platform.resolvedExecutable);
    final exePath = exeFile.parent.path.toLowerCase();

    if (exePath.contains(r'\debug') || exePath.contains('/debug')) {
      return false;
    }

    if (exePath.contains(r'\build\') || exePath.contains('/build/')) {
      return false;
    }

    final binDir = Directory(p.join(exeFile.parent.path, 'bin'));
    final kptoolsDir = Directory(p.join(exeFile.parent.path, 'kptools'));
    final kpVersionsDir = Directory(p.join(exeFile.parent.path, 'kp_versions'));
    
    if (binDir.existsSync() && kptoolsDir.existsSync() && kpVersionsDir.existsSync()) {
      return true;
    }

    return false;
  }
  
  static String get _assetsRoot {
    if (_isReleaseMode) {
      return File(Platform.resolvedExecutable).parent.path;
    }
    return _projectRoot;
  }
  
  static String get _projectRoot {
    // 辅助函数：通过 pubspec.yaml 查找项目根目录
    String? findProjectRootByPubspec() {
      var dir = Directory.current;
      for (int i = 0; i < 15; i++) { // 增加查找层数
        final pubspecFile = File(p.join(dir.path, 'pubspec.yaml'));
        if (pubspecFile.existsSync()) {
          // 检查是否是 FolkTool 项目（检查是否有 kp_versions 目录）
          final kpVersionsDir = Directory(p.join(dir.path, 'kp_versions'));
          if (kpVersionsDir.existsSync()) {
            return dir.path;
          }
        }
        if (dir.parent.path == dir.path) break;
        dir = dir.parent;
      }
      return null;
    }

    // 首先尝试通过 pubspec.yaml 查找项目根目录
    final projectRoot = findProjectRootByPubspec();
    if (projectRoot != null) {
      return projectRoot;
    }

    // 回退到原来的逻辑
    final currentDir = Directory.current.path;

    // 检查当前目录是否是 FolkTool 项目根目录
    final binDir = Directory(p.join(currentDir, 'bin'));
    final apkDir = Directory(p.join(currentDir, 'apk'));
    final kptoolsDir = Directory(p.join(currentDir, 'kptools'));
    final kpVersionsDir = Directory(p.join(currentDir, 'kp_versions'));

    if (binDir.existsSync() && apkDir.existsSync() && kptoolsDir.existsSync() && kpVersionsDir.existsSync()) {
      return currentDir;
    }

    // 如果当前目录不是项目根目录，尝试向上查找
    var dir = Directory(currentDir);
    for (int i = 0; i < 5; i++) {
      final testBin = Directory(p.join(dir.path, 'bin'));
      final testApk = Directory(p.join(dir.path, 'apk'));
      final testKptools = Directory(p.join(dir.path, 'kptools'));
      final testKpVersions = Directory(p.join(dir.path, 'kp_versions'));

      if (testBin.existsSync() && testApk.existsSync() && testKptools.existsSync() && testKpVersions.existsSync()) {
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
  
  static String get kpVersionsBasePath {
    if (_isReleaseMode) {
      debugPrint('[Constants] Release mode, using assets path: ${p.join(_assetsRoot, 'kp_versions')}');
      return p.join(_assetsRoot, 'kp_versions');
    }

    // 开发模式下，尝试多个可能的路径
    final potentialPaths = <String>[];

    // 1. 尝试从项目根目录查找
    potentialPaths.add(p.join(_projectRoot, 'kp_versions'));

    // 2. 尝试当前目录的 kp_versions
    potentialPaths.add(p.join(Directory.current.path, 'kp_versions'));

    // 3. 尝试上一级目录的 kp_versions（flutter run 通常在 build 目录下运行）
    try {
      final parentPath = Directory.current.parent.path;
      if (parentPath != Directory.current.path) {
        potentialPaths.add(p.join(parentPath, 'kp_versions'));
      }
    } catch (_) {}

    // 4. 尝试上上级目录
    try {
      final grandParentPath = Directory.current.parent.parent.path;
      if (grandParentPath != Directory.current.parent.path) {
        potentialPaths.add(p.join(grandParentPath, 'kp_versions'));
      }
    } catch (_) {}

    // 5. 尝试查找 pubspec.yaml 的目录
    try {
      var dir = Directory.current;
      for (int i = 0; i < 10; i++) {
        final pubspecFile = File(p.join(dir.path, 'pubspec.yaml'));
        if (pubspecFile.existsSync()) {
          final kpPath = p.join(dir.path, 'kp_versions');
          if (!potentialPaths.contains(kpPath)) {
            potentialPaths.add(kpPath);
          }
          break;
        }
        if (dir.parent.path == dir.path) break;
        dir = dir.parent;
      }
    } catch (_) {}

    // 检查每个路径，返回第一个存在的
    for (final path in potentialPaths) {
      if (Directory(path).existsSync()) {
        debugPrint('[Constants] Found kp_versions at: $path');
        return path;
      }
    }

    // 如果都不存在，返回第一个路径
    debugPrint('[Constants] No kp_versions found, trying: ${potentialPaths.first}');
    return potentialPaths.first;
  }
  static String get minVersionWithUnpack => '0.13.0';
  static String get selectedVersionKey => 'selected_kp_version';
  static String get customVersionPathKey => 'custom_kp_version_path';
  
  static String getKpVersionPath(String version) => p.join(kpVersionsBasePath, version, 'kpimg-android');
  static String getKpToolsPathForVersion(String version) {
    if (version == minVersionWithUnpack) {
      return kptoolsPath;
    }
    return kptoolsPath;
  }
}
