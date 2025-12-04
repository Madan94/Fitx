import '../services/admob_service.dart';

class InterstitialAdHelper {
  static final AdMobService _adMobService = AdMobService();

  static Future<void> loadAndShow({
    Function()? onAdDismissed,
    Function()? onAdFailed,
  }) async {
    await _adMobService.loadInterstitialAd(
      onAdLoaded: () async {
        final shown = await _adMobService.showInterstitialAd();
        if (!shown) {
          onAdFailed?.call();
        }
      },
      onAdFailedToLoad: () {
        onAdFailed?.call();
      },
      onAdDismissedFullScreenContent: () {
        onAdDismissed?.call();
        // Load next ad for future use
        _adMobService.loadInterstitialAd();
      },
    );
  }

  static Future<void> preload() async {
    await _adMobService.loadInterstitialAd();
  }

  static Future<bool> showIfLoaded({
    Function()? onAdDismissed,
  }) async {
    final shown = await _adMobService.showInterstitialAd();
    if (shown) {
      // Load next ad for future use
      _adMobService.loadInterstitialAd(
        onAdDismissedFullScreenContent: () {
          onAdDismissed?.call();
        },
      );
    }
    return shown;
  }
}

