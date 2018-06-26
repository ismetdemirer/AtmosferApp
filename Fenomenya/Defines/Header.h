//
//  Header.h
//  Fenomenya
//
//  Created by Mehmet ONDER on 7.05.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#ifndef Header_h
#define Header_h



#define HOST @"http://mobileapi.fenomenya.net/api/"
#define SERVER_URL(url) [NSString stringWithFormat:@"%@%@", HOST, url]

#define OS @"iOS"
#define IOS_VERSION [[UIDevice currentDevice] systemVersion]

#define BRAND @"Apple"
#define VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]

#define CARRIER [[[[CTTelephonyNetworkInfo alloc] init] subscriberCellularProvider] carrierName]

#define Authorization @"Authorization"

#define STATUS_CODE 200

#define VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define HeightMultiplier ScreenHeight / 480.
#define WitdhMultiplier ScreenWidth / 320.

#define FontName @"Avenir-Book"
#define FontNameBold @"Avenir-Book"

#define ArticleKeyId(id) [NSString stringWithFormat:@"Article_%ld", id]

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "WsUtil.h"
#import "Models.h"
#import "VcFenomenia.h"
#import "UtilCommon.h"
#import "VcWelcome.h"
#import "TableCellFenomenia.h"


#endif /* Header_h */
