// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(version) => "FolkTool v${version}";

  static String m1(path) => "ADB executable does not exist: ${path}";

  static String m2(error) => "Backup exception: ${error}";

  static String m3(error) => "Driver check failed: ${error}";

  static String m4(path) => "Fastboot executable does not exist: ${path}";

  static String m5(error) => "Flash exception: ${error}";

  static String m6(error) => "Flash failed: ${error}";

  static String m7(error) => "Failed to get ADB devices: ${error}";

  static String m8(error) => "Failed to get Fastboot devices: ${error}";

  static String m9(path) => "Input file does not exist: ${path}";

  static String m10(path) => "Kpimg file does not exist: ${path}";

  static String m11(path) => "Kptools file does not exist: ${path}";

  static String m12(error) => "Patch exception: ${error}";

  static String m13(error) => "Patch failed: ${error}";

  static String m14(error) => "Reboot exception: ${error}";

  static String m15(error) => "Reboot failed: ${error}";

  static String m16(error) => "Unpack failed: ${error}";

  static String m17(name) => "${name} installation failed";

  static String m18(name) => "${name} installed successfully";

  static String m19(path) => "Boot backup complete: ${path}";

  static String m20(path) => "Backup successful: ${path}";

  static String m21(error) => "Failed to clean temporary files: ${error}";

  static String m22(path) => "Copied to ${path}";

  static String m23(cmd) => "Executing: ${cmd}";

  static String m24(serial) => "Fastboot device detected: ${serial}";

  static String m25(path) => "File saved: ${path}";

  static String m26(path) => "Flashing: ${path}";

  static String m27(path) => "Input file: ${path}";

  static String m28(path) => "Kpimg path: ${path}";

  static String m29(module) => "KPM Module: ${module}";

  static String m30(path) => "Kptools path: ${path}";

  static String m31(error) => "Failed to list patch info: ${error}";

  static String m32(error) => "Operation error: ${error}";

  static String m33(path) => "Output file: ${path}";

  static String m34(path) => "Patch complete: ${path}";

  static String m35(error) => "Patch exception: ${error}";

  static String m36(error) => "Patch failed: ${error}";

  static String m37(error) => "Repack exception: ${error}";

  static String m38(path, size) => "Repacked: ${path} (${size} MB)";

  static String m39(error) => "Unpack exception: ${error}";

  static String m40(path) => "Unpacked kernel: ${path}";

  static String m41(timeout) =>
      "Waiting for fastboot device (${timeout} seconds)";

  static String m42(dir) => "Working directory: ${dir}";

  static String m43(path) => "Logs saved: ${path}";

  static String m44(count) => "Selected (${count})";

  static String m45(serial) => "Serial: ${serial}";

  static String m46(error) => "Unable to open link: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "aboutDescription": MessageLookupByLibrary.simpleMessage(
      "KernelPatch Auto Flash Tool",
    ),
    "aboutDescription2": MessageLookupByLibrary.simpleMessage(
      "This tool is for automatically patching boot.img and flashing to device",
    ),
    "aboutTitle": MessageLookupByLibrary.simpleMessage("About"),
    "aboutTooltip": MessageLookupByLibrary.simpleMessage("About"),
    "adbConnected": MessageLookupByLibrary.simpleMessage("ADB Connected"),
    "apatchDesc": MessageLookupByLibrary.simpleMessage(
      "Android kernel-level root solution",
    ),
    "appFullName": MessageLookupByLibrary.simpleMessage(
      "FolkTool - KernelPatch Auto Flash Tool",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("FolkTool"),
    "appVersion": m0,
    "backupWarning": MessageLookupByLibrary.simpleMessage(
      "Please backup original boot partition before flashing",
    ),
    "cancelOperation": MessageLookupByLibrary.simpleMessage("Cancel Operation"),
    "checking": MessageLookupByLibrary.simpleMessage("Checking..."),
    "checkingDriver": MessageLookupByLibrary.simpleMessage("Checking Driver"),
    "checkingDriverDesc": MessageLookupByLibrary.simpleMessage(
      "Checking ADB/Fastboot driver...",
    ),
    "clearAllModules": MessageLookupByLibrary.simpleMessage("Clear All"),
    "clearLogs": MessageLookupByLibrary.simpleMessage("Clear Logs"),
    "clickToSelectFile": MessageLookupByLibrary.simpleMessage(
      "Click to select file...",
    ),
    "clientCheck": MessageLookupByLibrary.simpleMessage("Client Detection"),
    "copyLogs": MessageLookupByLibrary.simpleMessage("Copy Logs"),
    "deviceConnectionTips": MessageLookupByLibrary.simpleMessage(
      "Device Connection Tips",
    ),
    "deviceConnectionTipsDesc": MessageLookupByLibrary.simpleMessage(
      "1. Ensure device is connected to PC via USB\n2. Enable developer options and USB debugging on device\n3. For Fastboot, enter Bootloader mode first",
    ),
    "deviceInFastboot": MessageLookupByLibrary.simpleMessage(
      "Device in Fastboot",
    ),
    "deviceStatus": MessageLookupByLibrary.simpleMessage("Device Status"),
    "enterSuperKey": MessageLookupByLibrary.simpleMessage("Enter SuperKey"),
    "errAdbNotAvailable": MessageLookupByLibrary.simpleMessage(
      "ADB is not available",
    ),
    "errAdbNotExist": m1,
    "errBackupException": m2,
    "errDriverCheckFailed": m3,
    "errFastbootNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Fastboot is not available",
    ),
    "errFastbootNotExist": m4,
    "errFlashBootFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to flash boot partition",
    ),
    "errFlashException": m5,
    "errFlashFailed": m6,
    "errGetAdbFailed": m7,
    "errGetFastbootFailed": m8,
    "errInputNotExist": m9,
    "errKernelNotFound": MessageLookupByLibrary.simpleMessage(
      "Kernel file not found",
    ),
    "errKpimgNotExist": m10,
    "errKptoolsNotExist": m11,
    "errOutputKernelNotFound": MessageLookupByLibrary.simpleMessage(
      "Output kernel not found",
    ),
    "errPatchException": m12,
    "errPatchFailed": m13,
    "errRebootException": m14,
    "errRebootFailed": m15,
    "errRepackFailed": MessageLookupByLibrary.simpleMessage("Repack failed"),
    "errSelectBootFirst": MessageLookupByLibrary.simpleMessage(
      "Please select boot.img file first",
    ),
    "errSuperKeyContainsSpaces": MessageLookupByLibrary.simpleMessage(
      "SuperKey must not contain spaces",
    ),
    "errSuperKeyInvalidChars": MessageLookupByLibrary.simpleMessage(
      "SuperKey must contain only numbers and letters",
    ),
    "errSuperKeyLength": MessageLookupByLibrary.simpleMessage(
      "SuperKey must be 8-63 characters",
    ),
    "errUnpackFailed": m16,
    "exportLogs": MessageLookupByLibrary.simpleMessage("Export Logs"),
    "exportLogsTooltip": MessageLookupByLibrary.simpleMessage("Export Logs"),
    "fastbootConnected": MessageLookupByLibrary.simpleMessage(
      "Fastboot Connected",
    ),
    "fileSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "File saved successfully",
    ),
    "flashBoot": MessageLookupByLibrary.simpleMessage("Flash boot"),
    "flashComplete": MessageLookupByLibrary.simpleMessage("Flash Complete"),
    "flashCompleteDesc": MessageLookupByLibrary.simpleMessage(
      "Reboot device now?",
    ),
    "flashFile": MessageLookupByLibrary.simpleMessage("Flash File"),
    "flashSuccess": MessageLookupByLibrary.simpleMessage("Flash successful!"),
    "flashing": MessageLookupByLibrary.simpleMessage("Flashing..."),
    "folkpatchDesc": MessageLookupByLibrary.simpleMessage(
      "An excellent KernelPatch management client",
    ),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "install": MessageLookupByLibrary.simpleMessage("Install"),
    "installFailed": m17,
    "installSuccess": m18,
    "installed": MessageLookupByLibrary.simpleMessage("Installed"),
    "installing": MessageLookupByLibrary.simpleMessage("Installing..."),
    "kpmModules": MessageLookupByLibrary.simpleMessage(
      "KPM Modules (Optional)",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "logAutoRebootFailed": MessageLookupByLibrary.simpleMessage(
      "Auto reboot to fastboot failed",
    ),
    "logAutoRebootFailed2": MessageLookupByLibrary.simpleMessage(
      "Auto reboot failed",
    ),
    "logBackingUpBoot": MessageLookupByLibrary.simpleMessage(
      "Backing up boot partition...",
    ),
    "logBackingUpPartition": MessageLookupByLibrary.simpleMessage(
      "Backing up partition...",
    ),
    "logBackupComplete": m19,
    "logBackupFailed": MessageLookupByLibrary.simpleMessage(
      "Boot backup failed",
    ),
    "logBackupFailedTryAlt": MessageLookupByLibrary.simpleMessage(
      "Backup failed, trying alternative method...",
    ),
    "logBackupKernel": MessageLookupByLibrary.simpleMessage(
      "Backing up kernel...",
    ),
    "logBackupSuccess": m20,
    "logCancelling": MessageLookupByLibrary.simpleMessage(
      "Cancelling operation...",
    ),
    "logCheckAdb": MessageLookupByLibrary.simpleMessage("Checking ADB..."),
    "logCheckFastboot": MessageLookupByLibrary.simpleMessage(
      "Checking Fastboot...",
    ),
    "logCheckingFile": MessageLookupByLibrary.simpleMessage("Checking file..."),
    "logCleanWorkDir": MessageLookupByLibrary.simpleMessage(
      "Cleaning temporary files...",
    ),
    "logCleanWorkDirFailed": m21,
    "logConsole": MessageLookupByLibrary.simpleMessage("Log Console"),
    "logCopied": m22,
    "logCopyBoot": MessageLookupByLibrary.simpleMessage(
      "Copying boot image...",
    ),
    "logDeviceInFastboot": MessageLookupByLibrary.simpleMessage(
      "Device is in fastboot mode",
    ),
    "logDeviceNotFastboot": MessageLookupByLibrary.simpleMessage(
      "Device not in fastboot mode",
    ),
    "logDeviceRebooting": MessageLookupByLibrary.simpleMessage(
      "Device is rebooting...",
    ),
    "logDriverCheckPassed": MessageLookupByLibrary.simpleMessage(
      "Driver check passed",
    ),
    "logEntries": MessageLookupByLibrary.simpleMessage("entries"),
    "logExecuteCmd": m23,
    "logFastbootDetected": m24,
    "logFileSaved": m25,
    "logFlashBootSuccess": MessageLookupByLibrary.simpleMessage(
      "Flash completed successfully",
    ),
    "logFlashFailed": MessageLookupByLibrary.simpleMessage("Flash failed"),
    "logFlashSuccess": MessageLookupByLibrary.simpleMessage("Flash successful"),
    "logFlashingBoot": MessageLookupByLibrary.simpleMessage(
      "Flashing boot image...",
    ),
    "logFlashingBootPath": m26,
    "logInputFile": m27,
    "logKpimgPath": m28,
    "logKpmModule": m29,
    "logKptoolsPath": m30,
    "logListPatchInfoFailed": m31,
    "logNoAdbDevice": MessageLookupByLibrary.simpleMessage(
      "No ADB device detected",
    ),
    "logOneClickComplete": MessageLookupByLibrary.simpleMessage(
      "One-click flash completed!",
    ),
    "logOperationError": m32,
    "logOutput": MessageLookupByLibrary.simpleMessage("Log Output"),
    "logOutputFile": m33,
    "logPatchComplete": m34,
    "logPatchException": m35,
    "logPatchFailed": m36,
    "logPatchSuccess": MessageLookupByLibrary.simpleMessage(
      "Kernel patched successfully",
    ),
    "logPatchingBoot": MessageLookupByLibrary.simpleMessage(
      "Patching boot image...",
    ),
    "logPatchingKernel": MessageLookupByLibrary.simpleMessage(
      "Patching kernel...",
    ),
    "logRebootCmdSent": MessageLookupByLibrary.simpleMessage(
      "Reboot command sent",
    ),
    "logRebootSuccess": MessageLookupByLibrary.simpleMessage(
      "Device rebooted successfully",
    ),
    "logRebootingDevice": MessageLookupByLibrary.simpleMessage(
      "Rebooting device...",
    ),
    "logRebootingToFastboot": MessageLookupByLibrary.simpleMessage(
      "Rebooting to fastboot mode...",
    ),
    "logRepackException": m37,
    "logRepackSuccess": m38,
    "logRepacking": MessageLookupByLibrary.simpleMessage(
      "Repacking boot image...",
    ),
    "logSavingFile": MessageLookupByLibrary.simpleMessage(
      "Saving patched file...",
    ),
    "logStartPatching": MessageLookupByLibrary.simpleMessage(
      "Starting patch operation...",
    ),
    "logUnpackException": m39,
    "logUnpackSuccess": m40,
    "logUnpacking": MessageLookupByLibrary.simpleMessage(
      "Unpacking boot image...",
    ),
    "logWaitFastboot": m41,
    "logWaitFastbootTimeout": MessageLookupByLibrary.simpleMessage(
      "Wait for fastboot timeout",
    ),
    "logWorkDir": m42,
    "logsSaved": m43,
    "manuallyEnterFastboot": MessageLookupByLibrary.simpleMessage(
      "Please manually enter Fastboot mode",
    ),
    "manuallyEnterFastbootDesc": MessageLookupByLibrary.simpleMessage(
      "1. Power off device\n2. Hold Volume Down + Power button\n3. Connect USB cable to PC",
    ),
    "matsuzakaYuki": MessageLookupByLibrary.simpleMessage("Matsuzaka Yuki"),
    "nextStep": MessageLookupByLibrary.simpleMessage("Next"),
    "noDeviceDetected": MessageLookupByLibrary.simpleMessage(
      "No device detected",
    ),
    "noDeviceDetectedDesc": MessageLookupByLibrary.simpleMessage(
      "Please ensure device is connected and USB debugging is enabled",
    ),
    "noFastbootDevice": MessageLookupByLibrary.simpleMessage(
      "No Fastboot device detected",
    ),
    "noKpmModules": MessageLookupByLibrary.simpleMessage("No modules selected"),
    "noLogs": MessageLookupByLibrary.simpleMessage("No logs"),
    "oneClickFlash": MessageLookupByLibrary.simpleMessage("One-Click Flash"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("Operation Failed"),
    "operationProgress": MessageLookupByLibrary.simpleMessage(
      "Operation Progress",
    ),
    "patchOnlyComplete": MessageLookupByLibrary.simpleMessage(
      "Patch complete!",
    ),
    "patchedFile": MessageLookupByLibrary.simpleMessage("Patched File"),
    "patching": MessageLookupByLibrary.simpleMessage("Patching..."),
    "pleaseSelectFile": MessageLookupByLibrary.simpleMessage(
      "Please select boot.img file first",
    ),
    "previousStep": MessageLookupByLibrary.simpleMessage("Previous"),
    "quickPatch": MessageLookupByLibrary.simpleMessage("One-Click Flash"),
    "quickPatchComplete": MessageLookupByLibrary.simpleMessage(
      "One-click flash completed!",
    ),
    "quickPatchSubtitle": MessageLookupByLibrary.simpleMessage(
      "Automatically complete patch, reboot, and flash process",
    ),
    "rebootLater": MessageLookupByLibrary.simpleMessage("Reboot Later"),
    "rebootNow": MessageLookupByLibrary.simpleMessage("Reboot Now"),
    "rebootToFastboot": MessageLookupByLibrary.simpleMessage(
      "Reboot to Fastboot",
    ),
    "recentFiles": MessageLookupByLibrary.simpleMessage("Recent Files"),
    "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
    "removeModule": MessageLookupByLibrary.simpleMessage("Remove"),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "restart": MessageLookupByLibrary.simpleMessage("Restart"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "saveAs": MessageLookupByLibrary.simpleMessage("Save As"),
    "savePatchedFile": MessageLookupByLibrary.simpleMessage(
      "Save Patched File",
    ),
    "saveToFile": MessageLookupByLibrary.simpleMessage("Save to File"),
    "scanning": MessageLookupByLibrary.simpleMessage("Scanning devices..."),
    "selectBootImage": MessageLookupByLibrary.simpleMessage(
      "Select boot.img File",
    ),
    "selectKpmModules": MessageLookupByLibrary.simpleMessage(
      "Select KPM modules...",
    ),
    "selectMode": MessageLookupByLibrary.simpleMessage("Select Operation Mode"),
    "selectSaveLocation": MessageLookupByLibrary.simpleMessage(
      "Select save location",
    ),
    "selectedModules": m44,
    "serial": m45,
    "simplePatch": MessageLookupByLibrary.simpleMessage("Simple Patch"),
    "simplePatchSubtitle": MessageLookupByLibrary.simpleMessage(
      "Patch boot.img only, save file manually",
    ),
    "startFlash": MessageLookupByLibrary.simpleMessage("Start Flash"),
    "startPatch": MessageLookupByLibrary.simpleMessage("Start Patch"),
    "step1": MessageLookupByLibrary.simpleMessage("Step 1: Patch boot.img"),
    "step1Desc": MessageLookupByLibrary.simpleMessage(
      "Select file and execute patch",
    ),
    "step2": MessageLookupByLibrary.simpleMessage("Step 2: Save Patched File"),
    "step2Desc": MessageLookupByLibrary.simpleMessage(
      "Confirm patched file is saved",
    ),
    "step3": MessageLookupByLibrary.simpleMessage("Step 3: Enter Fastboot"),
    "step3Desc": MessageLookupByLibrary.simpleMessage(
      "Reboot device to Fastboot mode",
    ),
    "step4": MessageLookupByLibrary.simpleMessage("Step 4: Flash boot.img"),
    "step4Desc": MessageLookupByLibrary.simpleMessage(
      "Flash patched file to device",
    ),
    "stepBackupBoot": MessageLookupByLibrary.simpleMessage("Backup Boot"),
    "stepFlashDevice": MessageLookupByLibrary.simpleMessage("Flash to Device"),
    "stepOperation": MessageLookupByLibrary.simpleMessage("Step-by-Step"),
    "stepPatch": MessageLookupByLibrary.simpleMessage("Step-by-Step"),
    "stepPatchImage": MessageLookupByLibrary.simpleMessage("Patch Image"),
    "stepPatchSubtitle": MessageLookupByLibrary.simpleMessage(
      "Manually execute each step, more flexible",
    ),
    "stepRebootComplete": MessageLookupByLibrary.simpleMessage("Reboot Device"),
    "stepRebootToFastboot": MessageLookupByLibrary.simpleMessage(
      "Reboot to Fastboot",
    ),
    "stepSaveFile": MessageLookupByLibrary.simpleMessage("Save File"),
    "stepSelectBoot": MessageLookupByLibrary.simpleMessage("Select Boot File"),
    "superKey": MessageLookupByLibrary.simpleMessage("SuperKey"),
    "superKeyValidationError": MessageLookupByLibrary.simpleMessage(
      "SuperKey should be 8-63 characters, containing only numbers and letters, no special characters allowed",
    ),
    "switchToChinese": MessageLookupByLibrary.simpleMessage("切换为中文"),
    "switchToEnglish": MessageLookupByLibrary.simpleMessage(
      "Switch to English",
    ),
    "unableToOpenLink": m46,
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
  };
}
