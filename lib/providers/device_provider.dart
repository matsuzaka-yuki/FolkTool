import 'dart:async';
import 'package:flutter/foundation.dart';
import '../config/constants.dart';
import '../models/models.dart';
import '../services/services.dart';

enum DeviceConnectionState {
  disconnected,
  adbConnected,
  fastbootConnected,
  checking,
}

class DeviceProvider extends ChangeNotifier {
  final DeviceService _deviceService = DeviceService();
  
  DeviceConnectionState _connectionState = DeviceConnectionState.disconnected;
  List<DeviceInfo> _adbDevices = [];
  List<DeviceInfo> _fastbootDevices = [];
  bool _isChecking = false;
  Timer? _monitorTimer;
  String? _errorMessage;
  bool _driverInstalled = false;
  
  DeviceConnectionState get connectionState => _connectionState;
  List<DeviceInfo> get adbDevices => _adbDevices;
  List<DeviceInfo> get fastbootDevices => _fastbootDevices;
  bool get isChecking => _isChecking;
  String? get errorMessage => _errorMessage;
  bool get driverInstalled => _driverInstalled;
  bool get hasAdbDevice => _adbDevices.isNotEmpty;
  bool get hasFastbootDevice => _fastbootDevices.isNotEmpty;

  Future<void> checkDriver() async {
    debugPrint('[DriverCheck] ADB Path: ${Constants.adbPath}');
    debugPrint('[DriverCheck] Fastboot Path: ${Constants.fastbootPath}');
    _driverInstalled = await _deviceService.checkDriverInstalled(
      onLog: (line) => debugPrint('[DriverCheck] $line'),
    );
    notifyListeners();
  }

  Future<void> refreshDevices() async {
    if (_isChecking) return;
    
    _isChecking = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      _adbDevices = await _deviceService.getAdbDevices(
        onLog: (line) => debugPrint('[ADB] $line'),
      );
      
      _fastbootDevices = await _deviceService.getFastbootDevices(
        onLog: (line) => debugPrint('[Fastboot] $line'),
      );
      
      if (_fastbootDevices.isNotEmpty) {
        _connectionState = DeviceConnectionState.fastbootConnected;
      } else if (_adbDevices.isNotEmpty) {
        _connectionState = DeviceConnectionState.adbConnected;
      } else {
        _connectionState = DeviceConnectionState.disconnected;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _connectionState = DeviceConnectionState.disconnected;
    }
    
    _isChecking = false;
    notifyListeners();
  }

  void startMonitoring({Duration interval = const Duration(seconds: 3)}) {
    stopMonitoring();
    refreshDevices();
    _monitorTimer = Timer.periodic(interval, (_) => refreshDevices());
  }

  void stopMonitoring() {
    _monitorTimer?.cancel();
    _monitorTimer = null;
  }

  Future<bool> rebootToFastboot() async {
    if (!hasAdbDevice) return false;
    
    final success = await _deviceService.rebootToFastboot(
      onLog: (line) => debugPrint('[Reboot] $line'),
    );
    
    if (success) {
      await Future.delayed(const Duration(seconds: 2));
      await waitForFastboot();
    }
    
    return success;
  }

  Future<bool> waitForFastboot({Duration timeout = const Duration(seconds: 60)}) async {
    final device = await _deviceService.waitForFastbootDevice(
      timeout: timeout,
      onLog: (line) => debugPrint('[WaitFastboot] $line'),
    );
    
    if (device != null) {
      _fastbootDevices = [device];
      _connectionState = DeviceConnectionState.fastbootConnected;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> flashBoot(String imagePath, {void Function(String)? onLog}) async {
    if (!hasFastbootDevice) return false;
    
    return await _deviceService.flashBoot(
      imagePath,
      onLog: onLog ?? (line) => debugPrint('[Flash] $line'),
    );
  }

  Future<bool> backupBoot(String outputPath, {void Function(String)? onLog}) async {
    if (!hasFastbootDevice) return false;
    
    return await _deviceService.backupBoot(
      outputPath,
      onLog: onLog ?? (line) => debugPrint('[Backup] $line'),
    );
  }

  Future<bool> rebootDevice({void Function(String)? onLog}) async {
    if (!hasFastbootDevice) return false;
    
    return await _deviceService.rebootDevice(
      onLog: onLog ?? (line) => debugPrint('[Reboot] $line'),
    );
  }

  @override
  void dispose() {
    stopMonitoring();
    super.dispose();
  }
}
