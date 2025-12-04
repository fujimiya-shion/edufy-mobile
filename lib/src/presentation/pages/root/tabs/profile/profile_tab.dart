import 'package:edufy_mobile/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:edufy_mobile/src/presentation/cubits/auth/auth_state.dart';
import 'package:edufy_mobile/src/presentation/pages/root/tabs/profile/profile_tab_cubit.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileTabCubit>(
      create: (_) => ProfileTabCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          final exception = state.exception;
          if (exception != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(exception.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return Scaffold(
              backgroundColor: AppColors.background,
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (!state.isAuthenticated || state.loggedInUser == null) {
            return Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                title: const Text('Tài khoản'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 72,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Bạn chưa đăng nhập',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Đăng nhập để theo dõi khoá học, đơn hàng\nvà nhận gợi ý phù hợp hơn.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Tiếp tục khám phá',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final user = state.loggedInUser;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              title: const Text('Tài khoản'),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _ProfileHeader(
                  name: user?.fullName ?? '',
                  email: user?.email ?? '',
                  avatarUrl: user?.avatarPath,
                ),
                const SizedBox(height: 24),
                _SectionLabel(text: 'Hoạt động'),
                const SizedBox(height: 8),
                _MenuTile(
                  icon: Icons.menu_book_rounded,
                  title: 'Khoá học của tôi',
                  onTap: () {},
                ),
                _MenuTile(
                  icon: Icons.receipt_long_rounded,
                  title: 'Đơn hàng của tôi',
                  onTap: () {},
                ),
                _MenuTile(
                  icon: Icons.bookmark_rounded,
                  title: 'Khoá học đã lưu',
                  onTap: () {},
                ),
                const SizedBox(height: 24),
                _SectionLabel(text: 'Cài đặt'),
                const SizedBox(height: 8),
                _MenuTile(
                  icon: Icons.person_rounded,
                  title: 'Thông tin cá nhân',
                  onTap: () {},
                ),
                _MenuTile(
                  icon: Icons.notifications_rounded,
                  title: 'Thông báo',
                  onTap: () {},
                ),
                _MenuTile(
                  icon: Icons.settings_rounded,
                  title: 'Tuỳ chỉnh tài khoản',
                  onTap: () {},
                ),
                const SizedBox(height: 24),
                _LogoutTile(
                  onTap: () {
                    context.read<AuthCubit>().logout();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarUrl;

  const _ProfileHeader({
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  String get initials {
    if (name.trim().isEmpty) return '';
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.characters.take(2).toString().toUpperCase();
    final first = parts.first.characters.first;
    final last = parts.last.characters.first;
    return (first + last).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.7), width: 0.6),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            backgroundImage:
                avatarUrl != null && avatarUrl!.isNotEmpty ? NetworkImage(avatarUrl!) : null,
            child: avatarUrl == null || avatarUrl!.isEmpty
                ? Text(
                    initials,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: AppColors.primary,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.isEmpty ? 'Người dùng Edufy' : name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Học viên',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
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

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _MenuTile({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutTile extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(
                Icons.logout_rounded,
                size: 22,
                color: AppColors.error,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Đăng xuất',
                  style: TextStyle(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
