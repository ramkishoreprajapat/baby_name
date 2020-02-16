import 'package:baby_name/Model/AlphabetModel.dart';
import 'package:baby_name/main.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Utility{
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['games', 'pubg', 'games', 'cod', 'video', 'baby name', 'camera', 'mp3'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

 static List<AlphabetModel> getAlphabets() {


    var alphabets = <AlphabetModel>[
      AlphabetModel(id: 1, text: "A"),
      AlphabetModel(id: 2, text: "B"),
      AlphabetModel(id: 3, text: "C"),
      AlphabetModel(id: 4, text: "D"),
      AlphabetModel(id: 5, text: "E"),
      AlphabetModel(id: 6, text: "F"),
      AlphabetModel(id: 7, text: "G"),
      AlphabetModel(id: 8, text: "H"),
      AlphabetModel(id: 9, text: "I"),
      AlphabetModel(id: 10, text: "J"),
      AlphabetModel(id: 11, text: "K"),
      AlphabetModel(id: 12, text: "L"),
      AlphabetModel(id: 13, text: "M"),
      AlphabetModel(id: 14, text: "N"),
      AlphabetModel(id: 15, text: "O"),
      AlphabetModel(id: 16, text: "P"),
      AlphabetModel(id: 17, text: "Q"),
      AlphabetModel(id: 18, text: "R"),
      AlphabetModel(id: 19, text: "S"),
      AlphabetModel(id: 20, text: "T"),
      AlphabetModel(id: 21, text: "U"),
      AlphabetModel(id: 22, text: "V"),
      AlphabetModel(id: 23, text: "W"),
      AlphabetModel(id: 24, text: "X"),
      AlphabetModel(id: 25, text: "Y"),
      AlphabetModel(id: 26, text: "Z"),
    ];

    return alphabets;
  }

 static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: Utility.targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }


  static InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: Utility.targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  static loadRewardedVideoAds(){
    RewardedVideoAd.instance.load(
        adUnitId: "ca-app-pub-7524933595530752~9345165848",
        targetingInfo: targetingInfo);
  }

}

