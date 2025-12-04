import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/admob_service.dart';
import '../widgets/neon_button.dart';

class RewardedAdButton extends StatefulWidget {
  final String buttonText;
  final Function(RewardItem)? onRewarded;
  final VoidCallback? onAdFailedToLoad;
  final VoidCallback? onAdDismissed;

  const RewardedAdButton({
    super.key,
    required this.buttonText,
    this.onRewarded,
    this.onAdFailedToLoad,
    this.onAdDismissed,
  });

  @override
  State<RewardedAdButton> createState() => _RewardedAdButtonState();
}

class _RewardedAdButtonState extends State<RewardedAdButton> {
  final AdMobService _adMobService = AdMobService();
  bool _isLoading = false;
  bool _isAdReady = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  Future<void> _loadAd() async {
    setState(() {
      _isAdReady = false;
    });

    await _adMobService.loadRewardedAd(
      onRewarded: (RewardItem reward) {
        widget.onRewarded?.call(reward);
      },
      onAdFailedToLoad: () {
        widget.onAdFailedToLoad?.call();
      },
      onAdDismissedFullScreenContent: () {
        setState(() {
          _isAdReady = false;
        });
        _loadAd(); // Load next ad
        widget.onAdDismissed?.call();
      },
    );

    setState(() {
      _isAdReady = true;
    });
  }

  Future<void> _showAd() async {
    if (!_isAdReady) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ad is loading, please wait...'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final shown = await _adMobService.showRewardedAd(
      onRewarded: (RewardItem reward) {
        widget.onRewarded?.call(reward);
      },
    );

    setState(() {
      _isLoading = false;
      _isAdReady = false;
    });

    if (!shown) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to show ad. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      await _loadAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeonButton(
      text: _isLoading ? 'Loading Ad...' : widget.buttonText,
      onPressed: _isLoading ? null : _showAd,
      isLoading: _isLoading,
      icon: Icons.play_circle_outline,
    );
  }
}

