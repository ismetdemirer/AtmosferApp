//
//  TableCellFenomenia.m
//  Fenomenya
//
//  Created by Mehmet ONDER on 10.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "TableCellFenomenia.h"
#import "Header.h"

#define LeftMargin 5 * WitdhMultiplier
#define TopMargin  5 * WitdhMultiplier
#define IconWitdh  16 * WitdhMultiplier
#define IconHeight 20 * WitdhMultiplier
#define LblSubjectHeight 44 * WitdhMultiplier

#define BookMarkWidth  36 * WitdhMultiplier
#define BookMarkHeight 38 * WitdhMultiplier

#define LikeWidth  36 * WitdhMultiplier
#define LikeHeight 38 * WitdhMultiplier

#define TimeHeight 12 * WitdhMultiplier
#define TimeWidth 200 * WitdhMultiplier

#define SocialButtonWidth 30 * WitdhMultiplier
#define SocialButtonHeight 30 * WitdhMultiplier

#define SocialButtonInterval (ScreenWidth - 4*LeftMargin - 5*SocialButtonWidth)/4

#define ContentHeight 212 * WitdhMultiplier

#define LblShareCountHeight 15*WitdhMultiplier



@interface TableCellFenomenia()

@property(nonatomic, strong) UIImageView *imgViewIcon;
@property(nonatomic, strong) UILabel     *lblSubject;
@property(nonatomic, strong) UIButton    *btnBookMark;
@property(nonatomic, strong) UIButton    *btnLike;
@property(nonatomic, strong) UILabel     *lblTime;
@property(nonatomic, strong) UIImageView *imgContent;

@property(nonatomic, strong) UIButton    *btnFacebook;
@property(nonatomic, strong) UIButton    *btnTwitter;
@property(nonatomic, strong) UIButton    *btnLinkedIn;
@property(nonatomic, strong) UIButton    *btnInstegram;
@property(nonatomic, strong) UIButton    *btnWhatsApp;

@property(nonatomic, strong) UILabel     *lblShareCount;
@property(nonatomic, strong) UILabel     *lblContent;

@end

@implementation TableCellFenomenia

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		self.backgroundColor = [UIColor clearColor];
		self.contentView.backgroundColor = [UIColor clearColor];

		[self.contentView addSubview:self.imgViewIcon];
		[self.contentView addSubview:self.btnLike];
		[self.contentView addSubview:self.btnBookMark];
		[self.contentView addSubview:self.lblSubject];
		[self.contentView addSubview:self.lblTime];
		[self.contentView addSubview:self.imgContent];
		[self.contentView addSubview:self.btnFacebook];
		[self.contentView addSubview:self.btnTwitter];
		[self.contentView addSubview:self.btnLinkedIn];
		[self.contentView addSubview:self.btnInstegram];
		[self.contentView addSubview:self.btnWhatsApp];
		[self.contentView addSubview:self.lblShareCount];
		[self.contentView addSubview:self.lblContent];
		self.selectedBackgroundView.layer.backgroundColor = [UIColor clearColor].CGColor;
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	return self;
}

#pragma mark usercontrols
-(UIImageView*)imgViewIcon
{
	if(nil == _imgViewIcon)
	{
		_imgViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(LeftMargin, 3*TopMargin, IconWitdh, IconHeight)];
		_imgViewIcon.image = [UtilCommon imageWithName:@"albaraka.png"];
	}
	return _imgViewIcon;
}

-(UILabel*)lblSubject
{
	if(nil == _lblSubject)
	{
		float x = IconWitdh + 2*LeftMargin;
		float y = TopMargin;
		float width = self.btnBookMark.frame.origin.x - LeftMargin - x;
		
		_lblSubject = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, LblSubjectHeight)];
		_lblSubject.textAlignment = NSTextAlignmentLeft;
		_lblSubject.textColor = [UIColor colorWithRed:20./255. green:20./255. blue:20./255. alpha:1];
		_lblSubject.font = [UIFont fontWithName:FontName size:15*WitdhMultiplier];
		_lblSubject.numberOfLines = 5;
		_lblSubject.lineBreakMode = NSLineBreakByWordWrapping;
	}
	return _lblSubject;
}

-(UIButton*)btnLike
{
	if(nil == _btnLike)
	{
		float x = ScreenWidth - LeftMargin - LikeWidth;
		float y = TopMargin * 2;
		
		_btnLike = [UIButton buttonWithType:UIButtonTypeCustom];
		_btnLike.frame = CGRectMake(x, y, LikeWidth, LikeHeight);
		//[_btnLike addTarget:self action:@selector(Invite) forControlEvents:UIControlEventTouchUpInside];
		
		[_btnLike setImage:[UtilCommon imageWithName:@"like-button-inactive.png"] forState:UIControlStateNormal];
	}
	return _btnLike;
}

-(UIButton*)btnBookMark
{
	if(nil == _btnBookMark)
	{
		float x = self.btnLike.frame.origin.x - 2*LeftMargin - BookMarkWidth;
		float y = TopMargin * 2;
		
		_btnBookMark = [UIButton buttonWithType:UIButtonTypeCustom];
		_btnBookMark.frame = CGRectMake(x, y, BookMarkWidth, BookMarkHeight);
		//[_btnLike addTarget:self action:@selector(Invite) forControlEvents:UIControlEventTouchUpInside];
		
		[_btnBookMark setBackgroundImage:[UtilCommon imageWithName:@"bookmark-inactive.png"] forState:UIControlStateNormal];

	}
	return _btnBookMark;
}

-(UILabel*)lblTime
{
	if(nil == _lblTime)
	{
		float x = IconWitdh + 2*LeftMargin;
		float y = self.lblSubject.frame.origin.x + LblSubjectHeight;
		
		_lblTime = [[UILabel alloc] initWithFrame:CGRectMake(x, y, TimeWidth, TimeHeight)];
		_lblTime.textAlignment = NSTextAlignmentLeft;
		_lblTime.textColor = [UIColor colorWithRed:20./255. green:20./255. blue:20./255. alpha:1];
		_lblTime.font = [UIFont fontWithName:FontName size:8*WitdhMultiplier];
	}
	return _lblTime;
}

-(UIImageView*)imgContent
{
	if(nil == _imgContent)
	{
		float y = self.lblTime.frame.origin.y + TimeHeight;
		_imgContent = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, ScreenWidth, ContentHeight)];
	}
	return _imgContent;
}

-(UIButton*)btnFacebook
{
	if(nil == _btnFacebook)
	{
		float x = 2*LeftMargin;
		float y = self.imgContent.frame.origin.y + ContentHeight + TopMargin * 2;
		
		_btnFacebook = [UIButton buttonWithType:UIButtonTypeCustom];
		_btnFacebook.frame = CGRectMake(x, y, SocialButtonWidth, SocialButtonHeight);
		[_btnFacebook addTarget:self action:@selector(PostFacebook) forControlEvents:UIControlEventTouchUpInside];
		
		[_btnFacebook setImage:[UtilCommon imageWithName:@"facebook-active.png"] forState:UIControlStateNormal];
	}
	return _btnFacebook;
}

-(UIButton*)btnTwitter
{
	if(nil == _btnTwitter)
	{
		float x = self.btnFacebook.frame.origin.x + SocialButtonWidth + SocialButtonInterval;
		float y = self.imgContent.frame.origin.y + ContentHeight + TopMargin * 2;
		
		_btnTwitter = [UIButton buttonWithType:UIButtonTypeCustom];
		_btnTwitter.frame = CGRectMake(x, y, SocialButtonWidth, SocialButtonWidth);
		[_btnTwitter addTarget:self action:@selector(PostTwitter) forControlEvents:UIControlEventTouchUpInside];
		
		[_btnTwitter setImage:[UtilCommon imageWithName:@"twitter-active.png"] forState:UIControlStateNormal];
	}
	return _btnTwitter;
}

-(UIButton*)btnLinkedIn
{
	if(nil == _btnLinkedIn)
	{
		float x = self.btnTwitter.frame.origin.x + SocialButtonWidth + SocialButtonInterval;
		float y = self.imgContent.frame.origin.y + ContentHeight + TopMargin * 2;
		
		_btnLinkedIn = [UIButton buttonWithType:UIButtonTypeCustom];
		_btnLinkedIn.frame = CGRectMake(x, y, SocialButtonWidth, SocialButtonWidth);
		[_btnLinkedIn addTarget:self action:@selector(PostLinkedIn) forControlEvents:UIControlEventTouchUpInside];
		
		[_btnLinkedIn setImage:[UtilCommon imageWithName:@"linkedin-active.png"] forState:UIControlStateNormal];
	}
	return _btnLinkedIn;
}

-(UIButton*)btnInstegram
{
	if(nil == _btnInstegram)
	{
		float x = self.btnLinkedIn.frame.origin.x + SocialButtonWidth + SocialButtonInterval;
		float y = self.imgContent.frame.origin.y + ContentHeight + TopMargin * 2;
		
		_btnInstegram = [UIButton buttonWithType:UIButtonTypeCustom];
		_btnInstegram.frame = CGRectMake(x, y, SocialButtonWidth, SocialButtonWidth);
		[_btnInstegram addTarget:self action:@selector(PostInstagram) forControlEvents:UIControlEventTouchUpInside];
		
		[_btnInstegram setImage:[UtilCommon imageWithName:@"instagram-active.png"] forState:UIControlStateNormal];
	}
	return _btnInstegram;
}

-(UIButton*)btnWhatsApp
{
	if(nil == _btnWhatsApp)
	{
		float x = self.btnInstegram.frame.origin.x + SocialButtonWidth + SocialButtonInterval;
		float y = self.imgContent.frame.origin.y + ContentHeight + TopMargin * 2;
		
		_btnWhatsApp = [UIButton buttonWithType:UIButtonTypeCustom];
		_btnWhatsApp.frame = CGRectMake(x, y, SocialButtonWidth, SocialButtonWidth);
		[_btnWhatsApp addTarget:self action:@selector(PostWhatsApp) forControlEvents:UIControlEventTouchUpInside];
		
		[_btnWhatsApp setImage:[UtilCommon imageWithName:@"whatsapp-active.png"] forState:UIControlStateNormal];
	}
	return _btnWhatsApp;
}

-(UILabel*)lblShareCount
{
	if(nil == _lblShareCount)
	{
		float x = LeftMargin;
		float y =  self.btnFacebook.frame.origin.y + SocialButtonHeight + TopMargin;
		
		_lblShareCount = [[UILabel alloc] initWithFrame:CGRectMake(x, y, ScreenWidth, LblShareCountHeight)];
		_lblShareCount.textAlignment = NSTextAlignmentLeft;
		_lblShareCount.textColor = [UIColor colorWithRed:20./255. green:20./255. blue:20./255. alpha:1];
		_lblShareCount.font = [UIFont fontWithName:FontName size:10*WitdhMultiplier];
	}
	return _lblShareCount;
}
-(UILabel*)lblContent
{
	if(nil == _lblContent)
	{
		float x = LeftMargin;
		float y = self.lblShareCount.frame.origin.y + LblShareCountHeight + TopMargin/2;
		float width = ScreenWidth - 2*x;
		
		_lblContent = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, LblSubjectHeight)];
		_lblContent.textAlignment = NSTextAlignmentLeft;
		_lblContent.textColor = [UIColor colorWithRed:20./255. green:20./255. blue:20./255. alpha:1];
		_lblContent.font = [UIFont fontWithName:FontName size:13*WitdhMultiplier];
		_lblContent.numberOfLines = 100;
		_lblContent.lineBreakMode = NSLineBreakByWordWrapping;
	}
	return _lblContent;
}
#pragma mark set article
-(void)setArticle:(Article *)article
{
	_article = article;
	
	self.lblSubject.text = article.Title;

	if(article.IsLiked)
	{
		[self.btnLike setImage:[UtilCommon imageWithName:@"like-button-active.png"] forState:UIControlStateNormal];
	}
	else
	{
		[self.btnLike setImage:[UtilCommon imageWithName:@"like-button-inactive.png"] forState:UIControlStateNormal];
	}
	
	if(article.IsBookMarked)
	{
		[self.btnBookMark setImage:[UtilCommon imageWithName:@"bookmark-active.png"] forState:UIControlStateNormal];
	}
	else
	{
		[self.btnBookMark setImage:[UtilCommon imageWithName:@"bookmark-inactive.png"] forState:UIControlStateNormal];
	}

	self.imgContent.image = [self getImage:ArticleKeyId((long)article.Id) WithUrl:article.MediaUrl];
	
	self.lblShareCount.text = [NSString stringWithFormat:@"%ld paylaşım ve %ld beğeni", article.ShareCount, article.LikeCount];
	self.lblContent.text = article.Description;
	
	[self.lblContent sizeToFit];
	_article.ContentSizeHeight = self.lblContent.frame.size.height;
}

-(void)SetKeyId:(NSString*)keyId SetImage:(UIImage*)img
{
	if(_article != nil && _article.Id == [UtilCommon GetIdFromKeyId:keyId])
	{
		self.imgContent.image = img;
	}
}

#pragma mark Member Functions
-(UIImage*)GetPostImage
{
	return self.imgContent.image;
}
#pragma mark Button Events
-(void)PostFacebook
{
	if([self.cellDelegate respondsToSelector:@selector(ShareOnFacebook:)])
		[self.cellDelegate ShareOnFacebook:self];
}

-(void)PostTwitter
{
	if([self.cellDelegate respondsToSelector:@selector(ShareOnTwitter:)])
		[self.cellDelegate ShareOnTwitter:self];
}

-(void)PostLinkedIn
{
	if([self.cellDelegate respondsToSelector:@selector(ShareOnLinkedIn:)])
		[self.cellDelegate ShareOnLinkedIn:self];
}

-(void)PostInstagram
{
	if([self.cellDelegate respondsToSelector:@selector(ShareOnInstagram:)])
		[self.cellDelegate ShareOnInstagram:self];
}

-(void)PostWhatsApp
{
	if([self.cellDelegate respondsToSelector:@selector(ShareOnWhatsapp:)])
		[self.cellDelegate ShareOnWhatsapp: self];
}
@end
