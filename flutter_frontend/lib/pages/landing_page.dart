import 'package:flutter/material.dart';
import '../widgets/neon_button.dart';
import '../widgets/glass_card.dart';
import '../widgets/particle_background.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Particle background
          const ParticleBackground(),
          
          // Content
          SingleChildScrollView(
            child: Column(
              children: [
                // Hero Section
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated title
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 800),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, 50 * (1 - value)),
                                child: child,
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 64,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Orbitron',
                                    color: Colors.white,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Lofit'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                AppConstants.appTagline,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[300],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Feature badges
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _FeatureBadge(
                              icon: Icons.track_changes,
                              text: 'Stake',
                            ),
                            const SizedBox(width: 32),
                            _FeatureBadge(
                              icon: Icons.fitness_center,
                              text: 'Sweat',
                            ),
                            const SizedBox(width: 32),
                            _FeatureBadge(
                              icon: Icons.emoji_events,
                              text: 'Earn',
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 48),
                        
                        // CTA Button
                        NeonButton(
                          text: 'Enter the Challenge',
                          onPressed: () {
                            Navigator.pushNamed(context, '/auth');
                          },
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Features Section
                Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Text(
                        'The Future of Fitness',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.cyberGreen,
                          fontFamily: 'Orbitron',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Revolutionary blockchain-powered fitness platform where your commitment pays off',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[300],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      
                      // Feature cards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _FeatureCard(
                              icon: Icons.flash_on,
                              title: 'Smart Staking',
                              description:
                                  'Stake your crypto on fitness challenges. Complete them to reclaim your stake plus rewards.',
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _FeatureCard(
                              icon: Icons.fitness_center,
                              title: 'AI Verification',
                              description:
                                  'Advanced computer vision tracks your workouts in real-time with precision accuracy.',
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _FeatureCard(
                              icon: Icons.emoji_events,
                              title: 'Prize Pools',
                              description:
                                  'Compete in tournaments and betting pools to win big from community prize funds.',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // CTA Section
                Container(
                  padding: const EdgeInsets.all(64),
                  child: Column(
                    children: [
                      Text(
                        'Ready to Transform Your Fitness?',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Orbitron',
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Join thousands of crypto athletes already earning while they train',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[300],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      NeonButton(
                        text: 'Start Earning Now',
                        onPressed: () {
                          Navigator.pushNamed(context, '/auth');
                        },
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 16,
                        ),
                      ),
                    ],
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

class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureBadge({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.cyberGreen, size: 24),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Orbitron',
            color: AppTheme.cyberGreen,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glowEffect: true,
      child: Column(
        children: [
          Icon(icon, size: 48, color: AppTheme.cyberGreen),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Orbitron',
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[300],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

