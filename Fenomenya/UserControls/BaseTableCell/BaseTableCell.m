//
//  BaseTableCell.m
//  Fenomenya
//
//  Created by Mehmet ONDER on 10.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "BaseTableCell.h"
#import "UtilCommon.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/UIImageView+AFNetworking.h"
#import "AFNetworking/AFImageDownloader.h"


@implementation BaseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
-(UIImage*)getPlayerImage:(NSInteger)playerId WithUrl:(NSString*)url
{
	UIImage *playerImg = [UtilCommon  GetUserProfile:playerId];
	
	if(nil != playerImg)
	{
		return playerImg;
	}
	else
	{
		if(url.length != 0 && ![url isEqual: [NSNull null]])
			[self GetImageFromServer:playerId WithUrl:url];
		playerImg = [GCCUtility imageWithName:@"profil-pic.png"];
	}
	
	return playerImg;
}*/

-(UIImage*)getImage:(NSString*)keyId WithUrl:(NSString*)url
{
	UIImage *img = [UtilCommon  KeyIdImage:keyId];
	
	if(nil != img)
	{
		return img;
	}
	else
	{
		if(url.length != 0 && ![url isEqual: [NSNull null]])
			[self GetImageFromServer:keyId WithUrl:url];
		img = [UtilCommon imageWithName:@"profil-pic.png"];//todo
	}
	
	return img;
}
-(void)GetImageFromServer:(NSString*)keyId  WithUrl:(NSString*)url
{
	@autoreleasepool {
		
		__block NSString *_keyId = keyId;
		AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
		manager.responseSerializer = [AFImageResponseSerializer serializer];
		AFImageDownloader * imgDownloader = [[AFImageDownloader alloc] initWithSessionManager:manager
																	   downloadPrioritization:AFImageDownloadPrioritizationFIFO
																	   maximumActiveDownloads:2
																				   imageCache:nil];
		
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
		[imgDownloader downloadImageForURLRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse  *response, UIImage *responseObject)
		 {
			 [UtilCommon SaveImage:responseObject WithKeyId:_keyId];
			 
			 @try {
				 [self SetKeyId:(NSString *)_keyId SetImage:responseObject];
				 
			 } @catch (NSException *exception) {
				 
			 } @finally {
			 }
		 }
										  failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error)
		 {
			 
		 }];
	}
}
-(void)SetPlayerId:(NSInteger)playerId SetImage:(UIImage*)img{}
@end
