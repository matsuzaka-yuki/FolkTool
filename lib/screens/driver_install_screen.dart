import 'package:flutter/material.dart';
import '../services/services.dart';
import '../generated/l10n.dart';

class DriverInstallScreen extends StatefulWidget {
  const DriverInstallScreen({super.key});

  @override
  State<DriverInstallScreen> createState() => _DriverInstallScreenState();
}

class _DriverInstallScreenState extends State<DriverInstallScreen> {
  final DriverService _driverService = DriverService();
  String? _installingDriver;
  String? _installedDriver;

  Future<void> _installDriver(DriverInfo driver) async {
    final l10n = S.of(context);

    setState(() {
      _installingDriver = driver.executableName;
    });

    final success = await _driverService.installDriver(driver.executableName);

    setState(() {
      _installingDriver = null;
      if (success) {
        _installedDriver = driver.executableName;
      }
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? l10n.installDriverSuccess : l10n.installDriverFailed(''),
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.driverInstallPage),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDriverCard(
              driver: DriverService.drivers[0],
              title: l10n.qualcommDriver64,
              description: l10n.qualcommDriver64Desc,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildDriverCard(
              driver: DriverService.drivers[1],
              title: l10n.qualcommDriver32,
              description: l10n.qualcommDriver32Desc,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            _buildDriverCard(
              driver: DriverService.drivers[2],
              title: l10n.mediatekDriver,
              description: l10n.mediatekDriverDesc,
              color: Colors.purple,
            ),
            const SizedBox(height: 16),
            _buildDriverCard(
              driver: DriverService.drivers[3],
              title: l10n.oneplusAdbDriver,
              description: l10n.oneplusAdbDriverDesc,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            _buildDriverCard(
              driver: DriverService.drivers[4],
              title: l10n.oppoAdbDriver,
              description: l10n.oppoAdbDriverDesc,
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverCard({
    required DriverInfo driver,
    required String title,
    required String description,
    required Color color,
  }) {
    final l10n = S.of(context);
    final isInstalling = _installingDriver == driver.executableName;
    final isInstalled = _installedDriver == driver.executableName;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.usb,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isInstalled)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green[600], size: 18),
                    const SizedBox(width: 8),
                    Text(
                      l10n.installDriverSuccess,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isInstalling ? null : () => _installDriver(driver),
                  icon: isInstalling
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.download, size: 18),
                  label: Text(
                    isInstalling ? l10n.installing : l10n.installDriver,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
