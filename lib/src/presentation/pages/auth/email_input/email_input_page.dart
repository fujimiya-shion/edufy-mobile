import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/data/repositories/remote/auth/i_auth_repository.dart';
import 'package:edufy_mobile/src/routes/app_router.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'email_input_cubit.dart';
import 'email_input_state.dart';

class EmailInputPage extends StatefulWidget {
  const EmailInputPage({super.key});

  @override
  State<EmailInputPage> createState() => _EmailInputPageState();
}

class _EmailInputPageState extends State<EmailInputPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmailInputCubit(authRepository: locator.get<IAuthRepository>()),
      child: BlocConsumer<EmailInputCubit, EmailInputState>(
        listener: (context, state) {
          if (state.exception != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.exception?.message ?? 'Đã có lỗi xảy ra'),
                backgroundColor: AppColors.error,
              ),
            );
          }

          if(state.isGoogleSuccess && !state.isGoogleLoading) {
            context.go(AppRouter.root);
          }

          if (state.isSuccess) {
            // TODO: điều hướng sang bước tiếp theo (OTP / chọn phương thức / v.v.)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Thành công!'),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<EmailInputCubit>();

          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              title: const Text('Đăng nhập'),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Chào mừng bạn 👋',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Đăng nhập bằng email nội bộ hoặc SSO Google.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                  ),
                  const SizedBox(height: 20),

                  // Email input
                  _Label(title: 'Email'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onChanged: cubit.setEmail,
                    onSubmitted: (_) async {
                      await context.read<EmailInputCubit>().submitEmail();
                    },
                    decoration: InputDecoration(
                      hintText: 'vd: shion@company.com',
                      filled: true,
                      fillColor: AppColors.surface,
                      prefixIcon: const Icon(Icons.email_outlined),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      errorText: state.email.isEmpty || state.isEmailValid
                          ? null
                          : 'Email không hợp lệ',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Continue button
                  SizedBox(
                    height: 48,
                    child: FilledButton(
                      onPressed: (state.isLoading || state.isGoogleLoading)
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              await context.read<EmailInputCubit>().submitEmail();
                            },
                      child: state.isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Tiếp tục'),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Divider "or"
                  Row(
                    children: [
                      const Expanded(child: Divider(height: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'hoặc',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textMuted,
                              ),
                        ),
                      ),
                      const Expanded(child: Divider(height: 1)),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Google SSO
                  SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: (state.isLoading || state.isGoogleLoading)
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              cubit.signInWithGoogle();
                            },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: state.isGoogleLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.g_mobiledata_rounded, size: 28),
                      label: Text(
                        'Đăng nhập với Google',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Helper note
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.info, size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Nếu bạn dùng email nội bộ, hệ thống có thể gửi link/OTP để xác thực. '
                            'Nếu dùng Google SSO, bạn sẽ được chuyển thẳng vào hệ thống.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.35,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String title;

  const _Label({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
