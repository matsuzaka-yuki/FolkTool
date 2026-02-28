import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import '../config/constants.dart';
import '../models/kp_version.dart';

class VersionService {
  Future<List<KpVersion>> getAvailableVersions() async {
    final versions = <KpVersion>[];
    final versionsDir = Directory(Constants.kpVersionsBasePath);

    // 调试日志
    debugPrint('[VersionService] kpVersionsBasePath: ${Constants.kpVersionsBasePath}');
    debugPrint('[VersionService] Directory.exists: ${await versionsDir.exists()}');

    if (!await versionsDir.exists()) {
      debugPrint('[VersionService] kp_versions directory not found!');
      return versions;
    }
    
    final dirs = await versionsDir.list().toList();
    debugPrint('[VersionService] Found ${dirs.length} entities in kp_versions');

    for (var entity in dirs) {
      if (entity is Directory) {
        final versionName = p.basename(entity.path);
        final kpimgPath = Constants.getKpVersionPath(versionName);
        debugPrint('[VersionService] Checking version: $versionName, kpimgPath: $kpimgPath, exists: ${await File(kpimgPath).exists()}');

        if (await File(kpimgPath).exists()) {
          versions.add(KpVersion(
            version: versionName,
            kpimgPath: kpimgPath,
            isCustom: false,
          ));
          debugPrint('[VersionService] Added version: $versionName');
        }
      }
    }

    debugPrint('[VersionService] Total versions loaded: ${versions.length}');
    
    versions.sort((a, b) => _compareVersions(b.version, a.version));
    
    return versions;
  }
  
  Future<KpVersion?> validateCustomVersion(String filePath) async {
    final file = File(filePath);

    if (!await file.exists()) {
      return null;
    }

    // 不再限制文件名，允许任何文件作为自定义版本
    return KpVersion(
      version: 'custom',
      kpimgPath: filePath,
      isCustom: true,
    );
  }
  
  int _compareVersions(String v1, String v2) {
    final parts1 = v1.split('.').map((p) => int.tryParse(p) ?? 0).toList();
    final parts2 = v2.split('.').map((p) => int.tryParse(p) ?? 0).toList();
    
    final maxLen = parts1.length > parts2.length ? parts1.length : parts2.length;
    
    for (var i = 0; i < maxLen; i++) {
      final p1 = i < parts1.length ? parts1[i] : 0;
      final p2 = i < parts2.length ? parts2[i] : 0;
      
      if (p1 != p2) {
        return p1.compareTo(p2);
      }
    }
    
    return 0;
  }
  
  bool isVersionSupportsUnpack(String version) {
    return _compareVersions(version, Constants.minVersionWithUnpack) >= 0;
  }
}
