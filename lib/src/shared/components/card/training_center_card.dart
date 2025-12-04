import 'package:flutter/material.dart';
import 'package:edufy_mobile/src/data/models/training_center/training_center_model.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';

class TrainingCenterCard extends StatelessWidget {
  final TrainingCenterModel center;
  final VoidCallback? onTap;

  const TrainingCenterCard({
    super.key,
    required this.center,
    this.onTap,
  });

  String? get _fullAddress {
    final parts = [
      center.addressLine1,
      center.addressLine2,
      center.city,
      center.state,
      center.country,
    ].where((e) => e != null && e!.trim().isNotEmpty).cast<String>().toList();

    if (parts.isEmpty) return null;
    return parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final address = _fullAddress;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.surfaceMuted.withOpacity(0.9),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            _Avatar(center: center),

            const SizedBox(width: 12),

            // Info section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên trung tâm
                  if (center.name != null && center.name!.trim().isNotEmpty)
                    Text(
                      center.name!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),

                  const SizedBox(height: 6),

                  // Địa chỉ
                  if (address != null)
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      text: address,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final TrainingCenterModel center;

  const _Avatar({required this.center});

  @override
  Widget build(BuildContext context) {
    final avatar = center.avatar;

    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 52,
        height: 52,
        color: AppColors.surfaceMuted,
        child: avatar != null && avatar.trim().isNotEmpty
            ? Image.network(
                avatar,
                width: 52,
                height: 52,
                fit: BoxFit.cover,
              )
            : Center(
                child: Text(
                  (center.name ?? 'C').substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
          ),
        ),
      ],
    );
  }
}
