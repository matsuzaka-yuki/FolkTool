import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class DriverInfo {
  final String name;
  final String description;
  final String executableName;
  final String icon;

  const DriverInfo({
    required this.name,
    required this.description,
    required this.executableName,
    required this.icon,
  });
}

class DriverService {
  static const List<DriverInfo> drivers = [
    DriverInfo(
      name: 'qualcommDriver64',
      description: 'qualcommDriver64Desc',
      executableName: 'fastboot_driver_64.exe',
      icon: 'memory',
    ),
    DriverInfo(
      name: 'qualcommDriver32',
      description: 'qualcommDriver32Desc',
      executableName: 'fastboot_driver_32.exe',
      icon: 'memory',
    ),
    DriverInfo(
      name: 'mediatekDriver',
      description: 'mediatekDriverDesc',
      executableName: 'MTK_USB_All_v1.0.8.exe',
      icon: 'developer_board',
    ),
  ];

  Future<String> _getDriverPath(String executableName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final driverDir = p.join(appDir.path, 'FolkTool', 'drivers');
    final driverPath = p.join(driverDir, executableName);

    final file = File(driverPath);
    if (!await file.exists()) {
      await file.parent.create(recursive: true);
      final assetPath = 'drive/$executableName';
      final data = await rootBundle.load(assetPath);
      await file.writeAsBytes(data.buffer.asUint8List());
    }

    return driverPath;
  }

  Future<bool> installDriver(String executableName) async {
    try {
      final driverPath = await _getDriverPath(executableName);
      final file = File(driverPath);

      if (!await file.exists()) {
        return false;
      }

      await Process.run(driverPath, []);
      return true;
    } catch (e) {
      return false;
    }
  }
}
