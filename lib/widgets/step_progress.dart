import 'package:flutter/material.dart';
import '../models/models.dart';
import '../generated/l10n.dart';

class StepProgress extends StatelessWidget {
  final List<OperationStep> steps;
  final int currentIndex;

  const StepProgress({
    super.key,
    required this.steps,
    required this.currentIndex,
  });

  String _getStepName(OperationStep step, S l10n) {
    switch (step.type) {
      case StepType.selectFile:
        return l10n.stepSelectBoot;
      case StepType.backupBoot:
        return l10n.stepBackupBoot;
      case StepType.patchImage:
        return l10n.stepPatchImage;
      case StepType.saveFile:
        return l10n.stepSaveFile;
      case StepType.rebootToFastboot:
        return l10n.stepRebootToFastboot;
      case StepType.flashImage:
        return l10n.stepFlashDevice;
      case StepType.rebootDevice:
        return l10n.stepRebootComplete;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text(
                l10n.operationProgress,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: steps.isEmpty ? 0 : (currentIndex + 1) / steps.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${((steps.isEmpty ? 0 : (currentIndex + 1) / steps.length) * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(steps.length, (index) {
          final step = steps[index];
          return _buildStepItem(step, index, l10n);
        }),
      ],
    );
  }

  Widget _buildStepItem(OperationStep step, int index, S l10n) {
    IconData icon;
    Color iconColor;
    Color bgColor;

    switch (step.status) {
      case StepStatus.pending:
        icon = Icons.radio_button_unchecked;
        iconColor = Colors.grey;
        bgColor = Colors.transparent;
        break;
      case StepStatus.inProgress:
        icon = Icons.pending;
        iconColor = Colors.blue;
        bgColor = Colors.blue.withOpacity(0.1);
        break;
      case StepStatus.completed:
        icon = Icons.check_circle;
        iconColor = Colors.green;
        bgColor = Colors.green.withOpacity(0.1);
        break;
      case StepStatus.failed:
        icon = Icons.error;
        iconColor = Colors.red;
        bgColor = Colors.red.withOpacity(0.1);
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              icon,
              key: ValueKey(step.status),
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getStepName(step, l10n),
                  style: TextStyle(
                    fontSize: 13,
                    color: step.status == StepStatus.pending
                        ? Colors.grey[600]
                        : Colors.grey[800],
                    fontWeight: step.status == StepStatus.inProgress
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
                if (step.errorMessage != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    step.errorMessage!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.red,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (step.status == StepStatus.inProgress)
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue[400],
              ),
            ),
        ],
      ),
    );
  }
}
