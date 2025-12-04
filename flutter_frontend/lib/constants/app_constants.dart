class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'http://localhost:3001/api';
  static const String contractAddress = '0xd43dc5f84320B34149Be4D0602F862DdD61A45CF';
  static const String rpcUrl = 'https://rpc.testnet.citrea.xyz';
  
  // AdMob Configuration
  static const String admobPublisherId = 'pub-4242107986577223';
  
  // Test Ad Unit IDs (Replace with real IDs from AdMob console)
  // For testing, use Google's test IDs:
  static const String rewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917'; // Test Rewarded Ad
  static const String interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712'; // Test Interstitial Ad
  static const String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111'; // Test Banner Ad
  // Replace above with your actual ad unit IDs from AdMob console
  
  // Colors
  static const int cyberGreenValue = 0xFF39FF14;
  static const int cyberBlackValue = 0xFF0F0F1A;
  static const int cyberDarkValue = 0xFF1A1A2E;
  static const int cyberBlueValue = 0xFF0F3460;
  
  // Storage keys
  static const String userStorageKey = 'cyberfit_user';
  static const String walletAddressKey = 'wallet_address';
  
  // App Info
  static const String appName = 'Lofit';
  static const String appTagline = 'It pays to get fit. Incentivise fitness';
}
