import 'package:flutter/material.dart';
import '../services/interstitial_ad_helper.dart';

/// Helper widget to show interstitial ads at specific points
/// Usage: Wrap a button or action with InterstitialAdTrigger
class InterstitialAdTrigger extends StatelessWidget {
  final Widget child;
  final VoidCallback? onAdDismissed;
  final VoidCallback? onAdFailed;
  final bool showAdBeforeAction;

  const InterstitialAdTrigger({
    super.key,
    required this.child,
    this.onAdDismissed,
    this.onAdFailed,
    this.showAdBeforeAction = true,
  });

  @override
  Widget build(BuildContext context) {
    if (child is GestureDetector || child is InkWell || child is TextButton) {
      return child;
    }

    return GestureDetector(
      onTap: () async {
        if (showAdBeforeAction) {
          await InterstitialAdHelper.loadAndShow(
            onAdDismissed: onAdDismissed,
            onAdFailed: onAdFailed,
          );
        }
      },
      child: child,
    );
  }
}

/// Show interstitial ad after navigation
Future<void> showInterstitialAfterNavigation(BuildContext context) async {
  await InterstitialAdHelper.loadAndShow();
}

