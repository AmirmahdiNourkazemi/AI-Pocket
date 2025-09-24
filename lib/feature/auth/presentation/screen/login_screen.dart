import 'package:appro_chat/core/locator/locator.dart';
import 'package:appro_chat/core/widgets/loading_dialog.dart';
import 'package:appro_chat/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:appro_chat/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/widgets/show_toast.dart';
import '../bloc/auth_event.dart';
import '../bloc/login_status.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AuthBloc>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.authStatus is LoginSuccess) {
              setState(() => _isLoading = false);
              hideLoadingDialog(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/home',
                (route) => false,
              );
            } else if (state.authStatus is LoginError) {
              setState(() => _isLoading = false);
              LoginError error = state.authStatus as LoginError;
              hideLoadingDialog(context);
              showToast(
                context,
                "خطا در ورود",
                error.message,
                ToastificationType.error,
              );
            } else if (state.authStatus is LoginLoading) {
              setState(() => _isLoading = true);
              showLoadingDialog(context);
            }
          },
          builder: (context, state) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                   Expanded(child: _buildWelcomeSection(context)),

                   Expanded(
                    flex: 1,
                    child: SingleChildScrollView(child: _buildBenefitsSection())),
                  
                  
                  // Login Button Section
                  _buildLoginButtonSection(context),
                  // const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Column(
      children: [
        // App Logo/Icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            Icons.psychology_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 40,
          ),
        ),
        const SizedBox(height: 24),
        
        // Welcome Text
        Text(
          "به کیف هوش مصنوعی خوش آمدید",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        
        Text(
          "با اتصال امن از طریق گوگل، از تمامی قابلیت‌های هوش مصنوعی بهره‌مند شوید",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBenefitsSection() {
    return Column(
      children: [
        _buildBenefitItem(
          icon: Icons.psychology_outlined,
          title: "دسترسی به هوش مصنوعی",
          subtitle: "تفسیر قرآن، مشاوره، پیشنهادات و...",
        ),
        const SizedBox(height: 16),
        _buildBenefitItem(
          icon: Icons.security_outlined,
          title: "ورود امن و سریع",
          subtitle: "با حساب گوگل، بدون نیاز به رمز عبور",
        ),
        const SizedBox(height: 16),
        _buildBenefitItem(
          icon: Icons.share,
          title: "اشتراک اطلاعات",
          subtitle: "امکان اشتراک اطلاعات با دیگر کاربران",
        ),
      ],
    );
  }

  Widget _buildBenefitItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButtonSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('برای ورود اینجا کلیک کنید', style: Theme.of(context).textTheme.bodySmall!.copyWith(
           color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
        ),),
        const SizedBox(height: 12), 
        // Google Login Button
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: ElevatedButton(
            onPressed: _isLoading ? null : () {
              BlocProvider.of<AuthBloc>(context).add(LoginOtpEvent());
            },
            style: ElevatedButton.styleFrom(
              // overlayColor: Theme.of(context).colorScheme.primaryContainer,
              backgroundColor: Theme.of(context).colorScheme.surface,
            disabledBackgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Colors.grey[800],
              minimumSize: const Size(double.infinity, 56),
              elevation: 2,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
              shadowColor: Colors.black12,
            ),
            child: _isLoading 
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const  Icon(IonIcons.logo_google, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        "ورود با گوگل",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        // const SizedBox(height: 16),
         Center(
                    child: TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'https://www.freeprivacypolicy.com/live/485664d7-5b2a-4ef4-94d3-a3498d22c536'));
                      },
                      child: Text(
                        'شرایط و قوانین',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
        // Privacy Policy Text
        // Text(
        //   "با ورود، شرایط استفاده و حریم خصوصی را می‌پذیرید",
        //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
        //     color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
        //   ),
        //   textAlign: TextAlign.center,
        // ),
      ],
    );
  }
}