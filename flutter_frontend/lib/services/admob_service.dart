import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constants/app_constants.dart';

class AdMobService {
  static final AdMobService _instance = AdMobService._internal();
  factory AdMobService() => _instance;
  AdMobService._internal();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    await MobileAds.instance.initialize();
    _initialized = true;
  }

  RewardedAd? _rewardedAd;
  InterstitialAd? _interstitialAd;

  // Rewarded Ad
  Future<void> loadRewardedAd({
    required Function(RewardItem) onRewarded,
    Function()? onAdFailedToLoad,
    Function()? onAdDismissedFullScreenContent,
  }) async {
    await RewardedAd.load(
      adUnitId: AppConstants.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              ad.dispose();
              _rewardedAd = null;
              onAdDismissedFullScreenContent?.call();
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              ad.dispose();
              _rewardedAd = null;
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
          onAdFailedToLoad?.call();
        },
      ),
    );
  }

  Future<bool> showRewardedAd({
    required Function(RewardItem) onRewarded,
  }) async {
    if (_rewardedAd == null) {
      return false;
    }

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        onRewarded(reward);
      },
    );
    return true;
  }

  // Interstitial Ad
  Future<void> loadInterstitialAd({
    Function()? onAdLoaded,
    Function()? onAdFailedToLoad,
    Function()? onAdDismissedFullScreenContent,
  }) async {
    await InterstitialAd.load(
      adUnitId: AppConstants.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              _interstitialAd = null;
              onAdDismissedFullScreenContent?.call();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              ad.dispose();
              _interstitialAd = null;
            },
          );
          onAdLoaded?.call();
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
          onAdFailedToLoad?.call();
        },
      ),
    );
  }

  Future<bool> showInterstitialAd() async {
    if (_interstitialAd == null) {
      return false;
    }

    _interstitialAd!.show();
    return true;
  }

  void dispose() {
    _rewardedAd?.dispose();
    _interstitialAd?.dispose();
  }
}

