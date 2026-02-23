import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../generated/l10n.dart';

class DeviceStatusCard extends StatelessWidget {
  final bool showRefreshButton;
  final VoidCallback? onRefresh;

  const DeviceStatusCard({
    super.key,
    this.showRefreshButton = true,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    
    return Consumer<DeviceProvider>(
      builder: (context, deviceProvider, child) {
        return Card(
          elevation: 2,
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
                    Icon(
                      Icons.devices,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.deviceStatus,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    const Spacer(),
                    if (showRefreshButton)
                      SizedBox(
                        height: 32,
                        child: deviceProvider.isManualChecking
                            ? Center(
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              )
                            : TextButton.icon(
                                onPressed: deviceProvider.isChecking
                                    ? null
                                    : () {
                                        if (onRefresh != null) {
                                          onRefresh!();
                                        } else {
                                          deviceProvider.manualRefreshDevices();
                                        }
                                      },
                                icon: const Icon(Icons.refresh, size: 18),
                                label: Text(l10n.refresh),
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                      ),
                  ],
                ),
                const Divider(height: 24),
                _buildStatusContent(context, deviceProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusContent(BuildContext context, DeviceProvider provider) {
    final l10n = S.of(context);
    
    if (!provider.driverInstalled) {
      return _buildWarningItem(
        l10n.checkingDriver,
        l10n.checkingDriverDesc,
        Colors.orange,
      );
    }

    switch (provider.connectionState) {
      case DeviceConnectionState.disconnected:
        return _buildDisconnected(context);
      case DeviceConnectionState.adbConnected:
        return _buildAdbConnected(context, provider);
      case DeviceConnectionState.fastbootConnected:
        return _buildFastbootConnected(context, provider);
      case DeviceConnectionState.checking:
        return _buildChecking(context);
    }
  }

  Widget _buildDisconnected(BuildContext context) {
    final l10n = S.of(context);
    
    return Column(
      children: [
        _buildStatusItem(
          l10n.noDeviceDetected,
          l10n.noDeviceDetectedDesc,
          Colors.grey,
          Icons.usb_off,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.help_outline, size: 16, color: Colors.blue[700]),
                  const SizedBox(width: 6),
                  Text(
                    l10n.deviceConnectionTips,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                l10n.deviceConnectionTipsDesc,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.blue[700],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdbConnected(BuildContext context, DeviceProvider provider) {
    final l10n = S.of(context);
    final device = provider.adbDevices.first;
    return _buildStatusItem(
      l10n.adbConnected,
      l10n.serial(device.serial),
      Colors.green,
      Icons.android,
    );
  }

  Widget _buildFastbootConnected(BuildContext context, DeviceProvider provider) {
    final l10n = S.of(context);
    final device = provider.fastbootDevices.first;
    return _buildStatusItem(
      l10n.fastbootConnected,
      l10n.serial(device.serial),
      Colors.green,
      Icons.phone_android,
    );
  }

  Widget _buildChecking(BuildContext context) {
    final l10n = S.of(context);
    return _buildStatusItem(
      l10n.checking,
      l10n.scanning,
      Colors.blue,
      Icons.search,
    );
  }

  Widget _buildStatusItem(
    String title,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
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
    );
  }

  Widget _buildWarningItem(String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.warning_amber, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
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
    );
  }
}
