//
//  Models.h
//  Fenomenya
//
//  Created by Mehmet ONDER on 7.05.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
	ArticleGroupNone = 0,
	ArticleGroupWeb  = 1,
	ArticleGroupMobile  = 2
} ArticleGroup;

typedef enum ArticleType
{
	ArticleTypeNone = 0,
	ArticleTypeText = 1,
	ArticleTypeImage = 2,
	ArticleTypeLink = 3,
	ArticleTypeVideo = 4
}ArticleType;

typedef enum
{
	ArticleShareTypeNone = 0,
	ArticleShareTypeWhatsApp = 1,
	ArticleShareTypeFacebook = 2,
	ArticleShareTypeLinkedIn = 3,
	ArticleShareTypeTwitter = 4,
	ArticleShareTypeInstagram = 5
}ArticleShareType;

typedef enum ArticlePointType
{
	ArticlePointTypeNone = 0,
	ArticlePointTypeWhatsApp = 1,
	ArticlePointTypeFacebook = 2,
	ArticlePointTypeLinkedIn = 3,
	ArticlePointTypeTwitter = 4,
	ArticlePointTypeInstagram = 5
}ArticlePointType;


@interface User : NSObject
@property                                  NSInteger Id;
@property(nonatomic, strong)               NSString *Code;
@property(nonatomic, strong)               NSString *Name;
@property(nonatomic, strong)               NSString *Surname;
@property(nonatomic, strong)               NSString *DepartmentName;
@property(nonatomic, strong)               NSString *Email;
@property(nonatomic, strong)               NSString *Token;
@property(nonatomic, strong)               NSString *ProfilePic;
@property                                  NSInteger UnReadMessageCount;
@property                                  NSInteger Point;
@property(nonatomic, strong)               NSString *FacebookUserId;
@property(nonatomic, strong)               NSString *GoogleUserId;
@property(nonatomic, strong)               NSString *LinkedInUserId;
@property(nonatomic, strong)               NSString *TwitterUserId;
@property(nonatomic, strong)               NSString *InstagramUserId;

@property(nonatomic,strong)                NSString *DeviceToken;

@property(nonatomic, strong)               NSDictionary *language;

-(void)SetUserWithData:(NSDictionary*)data;
-(void)Save;
-(void)LogoutUser;
+(instancetype)sharedUser;

@end

@interface Article : NSObject
@property                                  NSInteger    Id;
@property(nonatomic, strong)               NSString    *Title;
@property(nonatomic, strong)               NSString    *Description;
@property(nonatomic, strong)               NSString    *MediaUrl;
@property                                  NSInteger    Point;
@property                                  bool         IsLiked;
@property                                  bool         IsBookMarked;
@property(nonatomic, strong)               NSString    *Link;
@property                                  ArticleType  TypeId;
@property                                  NSInteger    ShareCount;
@property                                  NSInteger    LikeCount;
@property(nonatomic, strong)               NSString    *CreatedDate;
@property(nonatomic, assign)               NSInteger    ContentSizeHeight;
@end

