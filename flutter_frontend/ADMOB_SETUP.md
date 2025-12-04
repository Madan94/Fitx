# Google AdMob Setup Guide

## Publisher ID
Your Publisher ID: `pub-4242107986577223`

## Configuration

The AdMob configuration is set up in `lib/constants/app_constants.dart`. You need to replace the placeholder ad unit IDs with your actual Ad Unit IDs from the AdMob console.

### Steps to Get Your Ad Unit IDs

1. Go to [AdMob Console](https://apps.admob.com/)
2. Select your app or create a new one
3. Go to "Ad units" in the sidebar
4. Create ad units for:
   - **Rewarded Ad** - Use this for rewards/coins
   - **Interstitial Ad** - Use this for full-screen ads between screens
   - **Banner Ad** - Use this for banner ads at bottom/top of screen
5. Copy the Ad Unit IDs and replace them in `app_constants.dart`:

```dart
static const String rewardedAdUnitId = 'ca-app-pub-4242107986577223/YOUR_REWARDED_AD_ID';
static const String interstitialAdUnitId = 'ca-app-pub-4242107986577223/YOUR_INTERSTITIAL_AD_ID';
static const String bannerAdUnitId = 'ca-app-pub-4242107986577223/YOUR_BANNER_AD_ID';
```

## Usage Examples

### 1. Rewarded Ads

```dart
import 'package:lofit/widgets/rewarded_ad_button.dart';

RewardedAdButton(
  buttonText: 'Watch Ad for 100 Coins',
  onRewarded: (reward) {
    // Give user reward (coins, points, etc.)
    print('User earned: ${reward.amount} ${reward.type}');
  },
  onAdFailedToLoad: () {
    print('Ad failed to load');
  },
)
```

### 2. Interstitial Ads

```dart
import 'package:lofit/services/interstitial_ad_helper.dart';

// Show ad before navigation
await InterstitialAdHelper.loadAndShow(
  onAdDismissed: () {
    Navigator.pushNamed(context, '/next-screen');
  },
);

// Or preload for later
await InterstitialAdHelper.preload();
await InterstitialAdHelper.showIfLoaded();
```

### 3. Banner Ads

```dart
import 'package:lofit/widgets/banner_ad_widget.dart';

// Standard banner
BannerAdWidget()

// Large banner
BannerAdWidget(adSize: AdSize.largeBanner)

// Medium rectangle
BannerAdWidget(adSize: AdSize.mediumRectangle)
```

## Platform-Specific Setup

### Android

1. Add to `android/app/build.gradle`:
```gradle
dependencies {
    implementation 'com.google.android.gms:play-services-ads:22.6.0'
}
```

2. Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-4242107986577223~YOUR_APP_ID"/>
```

### iOS

1. Add to `ios/Runner/Info.plist`:
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-4242107986577223~YOUR_APP_ID</string>
```

## Testing

Use test ad unit IDs for development:

- **Rewarded**: `ca-app-pub-3940256099942544/5224354917`
- **Interstitial**: `ca-app-pub-3940256099942544/1033173712`
- **Banner**: `ca-app-pub-3940256099942544/6300978111`

Replace with your actual IDs before production release!

## Integration Points

Suggested places to show ads:

1. **Rewarded Ads**:
   - Dashboard (earn coins button)
   - After workout completion
   - Daily reward claim

2. **Interstitial Ads**:
   - Between page navigations
   - After contest completion
   - Before closing app

3. **Banner Ads**:
   - Bottom of dashboard
   - Bottom of contests page
   - Profile page footer

