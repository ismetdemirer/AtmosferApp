//
//  UtilCommon.h
//  Fenomenya
//
//  Created by Mehmet ONDER on 8.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UtilCommon : NSObject

//Get Bundle Image
+(UIImage*)imageWithName:(NSString*)imgBundleName;
+(UIImage*)KeyIdImage:(NSString*)keyId;
+(NSString*)GetKeyIdImageUrl:(NSString*)keyId;

//Save Image
+(void)SaveImage:(UIImage*)img WithKeyId:(NSString*)KeyId;

//Alert View
+(void)AlertMessageIn:(UIViewController*)controller WithCaption:(NSString*)caption WithMessageText:(NSString*)messageText;
+(void)AlertMessageIn:(UIViewController*)controller WithCaption:(NSString*)caption WithMessageText:(NSString*)messageText popView:(BOOL)pop dismissView:(BOOL)dismiss Function:(SEL)myAction;

//Device Model
+(NSString*)deviceModelName;

//Connection error
+(bool)ShowConnectionError:(NSError*)error VC:(UIViewController*)vcController;

//Language
+(NSString*)GetCultureTxtForKey:(NSString*)key DefaultValue:(NSString*)value;
+(NSString*)GetCultureTxtForKey:(NSString *)key;

//isValid Email
+(bool)isValidMail:(NSString*)email;

//isValid PassWord
+(bool)isValidPass:(NSString*)pass;

+(NSInteger)GetIdFromKeyId:(NSString*)keyId;
@end
