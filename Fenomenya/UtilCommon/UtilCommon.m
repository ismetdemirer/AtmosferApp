//
//  UtilCommon.m
//  Fenomenya
//
//  Created by Mehmet ONDER on 8.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "UtilCommon.h"
#import <sys/utsname.h>
#import "Header.h"

@implementation UtilCommon


#pragma mark Get Bundle Image
+(UIImage*)imageWithName:(NSString*)imgBundleName
{
	
	return [UIImage imageNamed:imgBundleName];
}

+(UIImage*)KeyIdImage:(NSString*)keyId
{
	return [UIImage imageWithContentsOfFile:[UtilCommon GetKeyIdImageUrl:keyId]];
}
+(NSString*)GetKeyIdImageUrl:(NSString*)keyId
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", keyId]];
}

#pragma mark save image
+(void)SaveImage:(UIImage*)img WithKeyId:(NSString*)KeyId
{
	@autoreleasepool {
		NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
		
		NSData * binaryImageData = UIImagePNGRepresentation(img);
		
		NSString *imgName = [NSString stringWithFormat:@"%@.png", KeyId];
		[binaryImageData writeToFile:[basePath stringByAppendingPathComponent:imgName] atomically:YES];
	}
	
}
#pragma mark Alert View
+(void)AlertMessageIn:(UIViewController*)controller WithCaption:(NSString*)caption WithMessageText:(NSString*)messageText
{
	[UtilCommon AlertMessageIn:controller WithCaption:caption WithMessageText:messageText popView:NO dismissView:NO Function:nil];
}

+(void)AlertMessageIn:(UIViewController*)controller WithCaption:(NSString*)caption WithMessageText:(NSString*)messageText popView:(BOOL)pop dismissView:(BOOL)dismiss Function:(SEL)myAction
{
	UIAlertController * alert = [UIAlertController
								 alertControllerWithTitle:caption
								 message:messageText
								 preferredStyle:UIAlertControllerStyleAlert];
	
	
	UIAlertAction* yesButton = [UIAlertAction
								actionWithTitle:[UtilCommon GetCultureTxtForKey:@"lblOK" DefaultValue:@"Tamam"]
								style:UIAlertActionStyleDefault
								handler:^(UIAlertAction * action) {
									//Handle your yes please button action here
									
									if(myAction)
										[controller performSelector:myAction];
									
									if(pop)
										[controller.navigationController popViewControllerAnimated:YES];
									
									if(dismiss)
										[controller dismissViewControllerAnimated:YES completion:nil];
									
								}];
	
	
	
	[alert addAction:yesButton];
	
	[controller presentViewController:alert animated:YES completion:nil];
	
	alert = nil;
}


#pragma mark Device Model Name
+(NSString*)deviceModelName
{
	struct utsname systemInfo;
	uname(&systemInfo);
	
	return [NSString stringWithCString:systemInfo.machine
							  encoding:NSUTF8StringEncoding];
}


#pragma mark Language
+(NSString*)GetCultureTxtForKey:(NSString*)key DefaultValue:(NSString*)value
{
	NSString * result = value;
	@try {
		result = [[User sharedUser].language valueForKey:key];
	} @catch (NSException *exception) {
		result = value;
	} @finally {
		
		if(result.length < 1) result = value;
	}
	
	return result;
}

+(NSString*)GetCultureTxtForKey:(NSString *)key
{
	return [UtilCommon GetCultureTxtForKey:key DefaultValue:key];
}

#pragma mark Connection error
+(bool)ShowConnectionError:(NSError*)error VC:(UIViewController*)vcController
{
	bool returnValue = true;
	switch (error.code) {
		case -1001:
		case -1009:
		case -1005:
		case -1006:
		case -1020:
			[UtilCommon AlertMessageIn:vcController WithCaption:@"" WithMessageText:[error.userInfo valueForKey:@"NSLocalizedDescription"]];
			returnValue = false;
			break;
			
		default:
			break;
	}
	return returnValue;
}


#pragma mark isValid Email
+(bool)isValidMail:(NSString*)email
{
	BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
	NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
	NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
	NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:email];
}

#pragma mark isValid PassWord
+(bool)isValidPass:(NSString*)passWord
{	
	return passWord.length > 3;
}

#pragma mark GetId FromKeyId
+(NSInteger)GetIdFromKeyId:(NSString*)keyId
{
	NSRange index = [keyId rangeOfString:@"_"];
	return [[keyId substringFromIndex:index.location + index.length] integerValue];
}


@end
