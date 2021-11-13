import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:truthywallet/assets/TYAssetsPage.dart';
import 'package:truthywallet/nft_assets/TYNFTAssetsPage.dart';
// import 'package:truthywallet/exchange/TYExchangePage.dart';
// import 'package:truthywallet/explore/TYExplorePage.dart';
// import 'package:truthywallet/home/TYHomePage.dart';
// import 'package:truthywallet/market/TYMarketPage.dart';
import 'package:truthywallet/settings/TYSettingsPage.dart';
import 'package:truthywallet/utility/NotificationCenter.dart';
import 'package:truthywallet/utility/UserDefaults.dart';
import 'package:truthywallet/utility/common/Console.dart';
import 'package:truthywallet/utility/common/Device.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';
import 'package:truthywallet/utility/core/TYLogger.dart';   
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {

  String selectedLanguageCode = "en";

  _MyAppState() { 
    _setData();

    NotificationCenter().subscribe(
        name: NotificationCenterNotifierName.languageChanged,
        callback: (parameter) => _languageChangedSubscriber(parameter),);
  }

  void _setData() async { 
    final langCode = await UserDefaults.getString(kCurrentSelectedLanguageCodeKey) ?? "en"; 
    if (mounted) {
      setState(() {
        selectedLanguageCode = langCode;
      });
    }
    Console.log("当前选中的语言：$selectedLanguageCode"); 
  }

  /// 通知事件：语言修改
  void _languageChangedSubscriber(Map<String, dynamic> parameter) {
    final langCode = parameter["code"] as String?;
    if (langCode != null) { 
      setState(() {
        selectedLanguageCode = langCode;
        Console.log("切换后选中的语言：$selectedLanguageCode");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit orientations to portrait up and down.
    // 设置App的仅竖屏模式
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // 设置顶部状态栏的颜色
    if (Device.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.white));
    }
    return CupertinoApp(
      debugShowCheckedModeBanner: false, // 首页右上角的debug显示
      supportedLocales: [Locale("en", ""), Locale("de", "")],
      localizationsDelegates: [  
        AppLocalizations.delegate, 
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(selectedLanguageCode),
      title: 'ShibaWallet',
      // theme: const CupertinoThemeData(brightness: Brightness.light),
      home: MyHomePage(),
      builder: EasyLoading.init(),
    );
  }
}

// Main Screen
class MyHomePage extends StatefulWidget {

  MyHomePage() {
    _init3rdSDK();
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();


  void _init3rdSDK() async {
    await TYLogger.initUmeng();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _pages = [
    TYAssetsPage(),
    // TYExchangePage(),
    // TYMarketPage(),
    TYNFTAssetsPage(),
    TYSettingsPage(),
    // TYHomePage(),
    // TYExplorePage(),
  ];
  late CupertinoTabBar _tabBar;
  final CupertinoTabController _tabController = CupertinoTabController();
  late int _lastTabIndex = 0;

  @override
  void initState() {
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
    _tabBar = CupertinoTabBar(
      backgroundColor: PublicColors.pureWhite,
      activeColor: PublicColors.mainBlue,
      inactiveColor: PublicColors.tabBarGray, //.withOpacity(.50),
      items: [
        // BottomNavigationBarItem(
        //   label: "Home",
        //   icon: Icon(Icons.home_outlined),
        //   activeIcon: Icon(Icons.home)
        // ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.wallet,
          icon: Icon(Icons.account_balance_wallet_outlined),
          activeIcon: Icon(Icons.account_balance_wallet_rounded)
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.myNFTs,
          icon: Icon(Icons.auto_graph_outlined),
          activeIcon: Icon(Icons.auto_graph_rounded)
        ),
        // BottomNavigationBarItem(
        //   label: "DEX",
        //   icon: Icon(Icons.swap_vertical_circle_outlined),
        //   activeIcon: Icon(Icons.swap_vertical_circle_rounded)
        // ),
        // BottomNavigationBarItem(
        //   label: "Markets",
        //   icon: Image.asset("assets/images/tabbar-markets-icon.png"),
        //   activeIcon: Image.asset("assets/images/tabbar-markets-selected-icon.png"),
        // ),
        // BottomNavigationBarItem(
        //   label: "Notifications",
        //   icon: Icon(Icons.notifications_none),
        //   activeIcon: Icon(Icons.notifications)
        // ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.settings,
          icon: Icon(Icons.admin_panel_settings_outlined),
          activeIcon: Icon(Icons.admin_panel_settings)
        ),
      ],
    );
    final pageScaffold = CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        tabBar: _tabBar,
        controller: _tabController,
        tabBuilder: (BuildContext context, index) {
          if (_tabController.index != _lastTabIndex) {
            HapticFeedback.mediumImpact(); 
            NotificationCenter().post(name: NotificationCenterNotifierName.tabBarChange, parameter: {"index":_tabController.index});
            _sendNotification(_tabController.index);
          }
          _lastTabIndex = _tabController.index;
          return _pages[index];
        },
      ),
    );
    return pageScaffold;
  }

  void _sendNotification(int index) {
    // Console.log("当前Tab切换，currentIndex=$index");
    if (index == 0) {
      // 点击首页时
      _sendTabLog("home_page");
    } else if (index == 1) {
      // 点击个人页时
      _sendTabLog("mynft_page"); 
    }  else if (index == 2) {
      // 点击个人页时
      _sendTabLog("profile_page"); 
    } 
  }

  void _sendTabLog(String eventName) {
    TYLogger.sendEvent(eventName);
  }
}

 