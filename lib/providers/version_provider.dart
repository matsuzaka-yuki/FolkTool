import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';
import '../models/kp_version.dart';
import '../services/version_service.dart';

class VersionProvider extends ChangeNotifier {
  final VersionService _versionService = VersionService();
  
  List<KpVersion> _availableVersions = [];
  KpVersion? _selectedVersion;
  String? _customVersionPath;
  bool _isLoading = false;
  
  List<KpVersion> get availableVersions => List.unmodifiable(_availableVersions);
  KpVersion? get selectedVersion => _selectedVersion;
  String? get customVersionPath => _customVersionPath;
  bool get isLoading => _isLoading;
  
  Future<void> loadVersions() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _availableVersions = await _versionService.getAvailableVersions();
      
      if (_availableVersions.isNotEmpty && _selectedVersion == null) {
        final defaultVersion = _availableVersions.firstWhere(
          (v) => v.version == Constants.minVersionWithUnpack,
          orElse: () => _availableVersions.first,
        );
        _selectedVersion = defaultVersion;
      }
      
      await _loadSavedVersion();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> _loadSavedVersion() async {
    final prefs = await SharedPreferences.getInstance();
    final savedVersion = prefs.getString(Constants.selectedVersionKey);
    final customPath = prefs.getString(Constants.customVersionPathKey);
    
    if (customPath != null && customPath.isNotEmpty) {
      final customVersion = await _versionService.validateCustomVersion(customPath);
      if (customVersion != null) {
        _selectedVersion = customVersion;
        _customVersionPath = customPath;
        notifyListeners();
        return;
      }
    }
    
    if (savedVersion != null && savedVersion.isNotEmpty) {
      final version = _availableVersions.where((v) => v.version == savedVersion).firstOrNull;
      if (version != null) {
        _selectedVersion = version;
        notifyListeners();
      }
    }
  }
  
  void selectVersion(KpVersion version) {
    _selectedVersion = version;
    if (!version.isCustom) {
      _customVersionPath = null;
    }
    _saveSelectedVersion();
    notifyListeners();
  }
  
  Future<bool> selectCustomVersion(String filePath) async {
    final version = await _versionService.validateCustomVersion(filePath);
    if (version == null) {
      return false;
    }
    
    _selectedVersion = version;
    _customVersionPath = filePath;
    _saveSelectedVersion();
    notifyListeners();
    return true;
  }
  
  Future<void> _saveSelectedVersion() async {
    final prefs = await SharedPreferences.getInstance();
    
    if (_selectedVersion != null) {
      if (_selectedVersion!.isCustom) {
        await prefs.setString(Constants.selectedVersionKey, 'custom');
        if (_customVersionPath != null) {
          await prefs.setString(Constants.customVersionPathKey, _customVersionPath!);
        }
      } else {
        await prefs.setString(Constants.selectedVersionKey, _selectedVersion!.version);
        await prefs.remove(Constants.customVersionPathKey);
      }
    }
  }
  
  KpVersion? getDefaultVersion() {
    if (_availableVersions.isEmpty) return null;
    
    return _availableVersions.firstWhere(
      (v) => v.version == Constants.minVersionWithUnpack,
      orElse: () => _availableVersions.first,
    );
  }
}
