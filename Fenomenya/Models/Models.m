//
//  Models.m
//  Fenomenya
//
//  Created by Mehmet ONDER on 7.05.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "Models.h"


static User * user = nil;
@implementation User

+ (instancetype)sharedUser
{
	static User *sharedUser= nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		NSData *userDecoded = [[NSUserDefaults standardUserDefaults] objectForKey:@"FenomeniaUser"];
		sharedUser = [NSKeyedUnarchiver unarchiveObjectWithData:userDecoded];
		if(nil == sharedUser)
		{
			sharedUser = [[User alloc] init];
		}
		// Do any other initialisation stuff here
	});
	return sharedUser;
}

-(void)Save
{
	NSData *encodedUser = [NSKeyedArchiver archivedDataWithRootObject:self];
	[[NSUserDefaults standardUserDefaults] setObject:encodedUser forKey:@"FenomeniaUser"];
}

-(void)SetUserWithData:(NSDictionary*)data
{

	if(nil != [data valueForKey:@"Id"])
	{
		self.Id = [[data valueForKey:@"Id"] integerValue];
	}
	
	if(nil != [data valueForKey:@"Code"])
	{
		self.Code = [data valueForKey:@"Code"];
	}
	
	if(nil != [data valueForKey:@"Name"])
	{
		self.Name = [data valueForKey:@"Name"];
	}
	
	if(nil != [data valueForKey:@"Surname"])
	{
		self.Surname = [data valueForKey:@"Surname"];
	}
	
	if(nil != [data valueForKey:@"DepartmentName"])
	{
		self.DepartmentName = [data valueForKey:@"DepartmentName"];
	}
	
	if(nil != [data valueForKey:@"Email"])
	{
		self.Email = [data valueForKey:@"Email"];
	}
	
	if(nil != [data valueForKey:@"Token"])
	{
		self.Token = [data valueForKey:@"Token"];
	}
	
	if(nil != [data valueForKey:@"ProfilePic"])
	{
		self.ProfilePic = [data valueForKey:@"ProfilePic"];
	}	
	
	if(nil != [data valueForKey:@"UnReadMessageCount"])
	{
		self.UnReadMessageCount = [[data valueForKey:@"UnReadMessageCount"] integerValue];
	}
	
	if(nil != [data valueForKey:@"Point"])
	{
		self.Point = [[data valueForKey:@"Point"] integerValue];
	}
	
	if(nil != [data valueForKey:@"FacebookUserId"])
	{
		self.FacebookUserId = [data valueForKey:@"FacebookUserId"];
	}
	
	if(nil != [data valueForKey:@"GoogleUserId"])
	{
		self.GoogleUserId = [data valueForKey:@"GoogleUserId"];
	}
	
	if(nil != [data valueForKey:@"LinkedInUserId"])
	{
		self.LinkedInUserId = [data valueForKey:@"LinkedInUserId"];
	}
	
	if(nil != [data valueForKey:@"TwitterUserId"])
	{
		self.TwitterUserId = [data valueForKey:@"TwitterUserId"];
	}

	if(nil != [data valueForKey:@"InstagramUserId"])
	{
		self.InstagramUserId = [data valueForKey:@"InstagramUserId"];
	}
}

-(NSString*)DeviceToken
{
	if(nil ==_DeviceToken)
		_DeviceToken = @"";
	return _DeviceToken;
}


-(void)LogoutUser
{
	_Id = -1;
	_Code = nil;
	_Name = nil;
	_Surname = nil;;
	_Email = nil;;
	_Token = nil;;
	_ProfilePic = nil;;
	_UnReadMessageCount = -1;
	_Point = -1;
	_FacebookUserId = nil;;
	_GoogleUserId = nil;;
	_LinkedInUserId = nil;;
	_TwitterUserId = nil;;
	_InstagramUserId = nil;;
	
	_DeviceToken = nil;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	
	[encoder encodeInteger:self.Id forKey:@"Id"];
	[encoder encodeObject:self.Code forKey:@"Code"];	
	[encoder encodeObject:self.Name forKey:@"Name"];
	[encoder encodeObject:self.Surname forKey:@"Surname"];
	[encoder encodeObject:self.DepartmentName forKey:@"DepartmentName"];
	[encoder encodeObject:self.Email forKey:@"Email"];
	[encoder encodeObject:self.Token forKey:@"Token"];
	[encoder encodeObject:self.ProfilePic forKey:@"ProfilePic"];

	[encoder encodeObject:self.FacebookUserId forKey:@"FacebookUserId"];
	[encoder encodeObject:self.GoogleUserId forKey:@"GoogleUserId"];
	[encoder encodeObject:self.LinkedInUserId forKey:@"LinkedInUserId"];
	[encoder encodeObject:self.TwitterUserId forKey:@"TwitterUserId"];
	[encoder encodeObject:self.InstagramUserId forKey:@"InstagramUserId"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if((self = [super init])) {
		
		self.Id = [decoder decodeIntegerForKey:@"Id"];
		self.Code = [decoder decodeObjectForKey:@"Code"];
		self.Name = [decoder decodeObjectForKey:@"Name"];
		self.Surname = [decoder decodeObjectForKey:@"Surname"];
		self.DepartmentName = [decoder decodeObjectForKey:@"DepartmentName"];
		self.Email = [decoder decodeObjectForKey:@"Email"];
		self.Token = [decoder decodeObjectForKey:@"Token"];
		self.ProfilePic = [decoder decodeObjectForKey:@"ProfilePic"];
		
		self.FacebookUserId = [decoder decodeObjectForKey:@"FacebookUserId"];
		self.GoogleUserId = [decoder decodeObjectForKey:@"GoogleUserId"];
		self.LinkedInUserId = [decoder decodeObjectForKey:@"LinkedInUserId"];
		self.TwitterUserId = [decoder decodeObjectForKey:@"TwitterUserId"];
		self.InstagramUserId = [decoder decodeObjectForKey:@"InstagramUserId"];
	}
	return self;
}


-(void)dealloc
{
	_Code = nil;
	_Name = nil;
	_Surname = nil;
	_Email = nil;
	_Token = nil;
	_ProfilePic = nil;
	_FacebookUserId = nil;
	_GoogleUserId = nil;
	_LinkedInUserId = nil;
	_TwitterUserId = nil;
	_InstagramUserId = nil;
	
	_DeviceToken = nil;
}

@end

@implementation Article
-(void)dealloc
{
	_Title = nil;
	_Description = nil;
	_MediaUrl = nil;
	_Link = nil;
	_CreatedDate = nil;
}
@end
