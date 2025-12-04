import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import '../constants/app_constants.dart';
import '../theme/app_theme.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int _currentStep = 1;
  bool _isConnecting = false;
  String? _walletAddress;
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();

  @override
  void dispose() {
    _goalController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  Future<void> _handleWalletConnect() async {
    setState(() {
      _isConnecting = true;
    });

    try {
      // Implement actual wallet connection (MetaMask, WalletConnect, etc.)
      // For now, simulate wallet connection
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock wallet address for demo
      _walletAddress = '0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6';
      
      setState(() {
        _isConnecting = false;
        _currentStep = 2;
      });
    } catch (e) {
      setState(() {
        _isConnecting = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Wallet connection failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleVerificationSubmit() async {
    final goal = _goalController.text;
    final level = _levelController.text;

    if (goal.isEmpty || level.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Save user info
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.userStorageKey, _walletAddress ?? '');
    await prefs.setString('user_goal', goal);
    await prefs.setString('user_level', level);

    // Navigate to dashboard
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.cyberBlack,
                  AppTheme.cyberDark,
                  AppTheme.cyberBlack,
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _currentStep == 1
                        ? _WalletConnectStep(
                            key: const ValueKey(1),
                            isConnecting: _isConnecting,
                            onConnect: _handleWalletConnect,
                          )
                        : _VerificationStep(
                            key: const ValueKey(2),
                            walletAddress: _walletAddress ?? '',
                            goalController: _goalController,
                            levelController: _levelController,
                            onSubmit: _handleVerificationSubmit,
                            onBack: () {
                              setState(() {
                                _currentStep = 1;
                              });
                            },
                          ),
                  ),
                  const SizedBox(height: 32),
                  _ProgressIndicator(
                    currentStep: _currentStep,
                    totalSteps: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletConnectStep extends StatelessWidget {
  final bool isConnecting;
  final VoidCallback onConnect;

  const _WalletConnectStep({
    super.key,
    required this.isConnecting,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_balance_wallet,
            size: 64,
            color: AppTheme.cyberGreen,
          ),
          const SizedBox(height: 24),
          Text(
            'Connect Your Wallet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Orbitron',
              color: AppTheme.cyberGreen,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Connect your wallet to get started with Lofit',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[300],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          NeonButton(
            text: isConnecting ? 'Connecting...' : 'Connect Wallet',
            onPressed: isConnecting ? null : onConnect,
            isLoading: isConnecting,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          ),
        ],
      ),
    );
  }
}

class _VerificationStep extends StatelessWidget {
  final String walletAddress;
  final TextEditingController goalController;
  final TextEditingController levelController;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const _VerificationStep({
    super.key,
    required this.walletAddress,
    required this.goalController,
    required this.levelController,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Complete Your Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Orbitron',
              color: AppTheme.cyberGreen,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Wallet: ${walletAddress.substring(0, 6)}...${walletAddress.substring(walletAddress.length - 4)}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[400],
              fontFamily: 'monospace',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: goalController,
            decoration: InputDecoration(
              labelText: 'Fitness Goal',
              labelStyle: TextStyle(color: AppTheme.cyberGreen),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.cyberGreen),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.cyberGreen.withValues(alpha: 0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.cyberGreen),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: levelController,
            decoration: InputDecoration(
              labelText: 'Fitness Level',
              labelStyle: TextStyle(color: AppTheme.cyberGreen),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.cyberGreen),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.cyberGreen.withValues(alpha: 0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.cyberGreen),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: NeonButton(
                  text: 'Back',
                  variant: NeonButtonVariant.secondary,
                  onPressed: onBack,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: NeonButton(
                  text: 'Continue',
                  onPressed: onSubmit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _ProgressIndicator({
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalSteps,
        (index) {
          final isActive = index + 1 == currentStep;
          final isCompleted = index + 1 < currentStep;
          
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 32 : 12,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: isCompleted || isActive
                  ? AppTheme.cyberGreen
                  : AppTheme.cyberGreen.withValues(alpha: 0.3),
            ),
          );
        },
      ),
    );
  }
}

