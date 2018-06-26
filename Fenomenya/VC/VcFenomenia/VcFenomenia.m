//
//  VcFenomenia.m
//  Fenomenya
//
//  Created by Mehmet ONDER on 8.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "VcFenomenia.h"
#import "Header.h"
#import <MGInstagram/MGInstagram.h>


#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/UIImageView+AFNetworking.h"

@interface VcFenomenia ()
@property                      NSInteger                  page;

@property (readonly)           UISwipeGestureRecognizer * recognizer_close;
@property (readonly)           UISwipeGestureRecognizer * recognizer_close2;
@property (readonly)           UISwipeGestureRecognizer * recognizer_open;
@property(nonatomic, strong)   NSMutableArray<Article*> *articleList;
@property(nonatomic, strong)   NSMutableArray           *menuList;

@property(nonatomic, strong)   MGInstagram              *instagram;
@end

@implementation VcFenomenia

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self SetGestures];
	[self GetArticles];
	
	self.lblName.text = [NSString stringWithFormat:@"%@ %@", [User sharedUser].Name, [User sharedUser].Surname];
	self.lblDepartment.text = [User sharedUser].DepartmentName;
	self.lblPoint.text = [NSString stringWithFormat:@"%ld", [User sharedUser].Point];
	
	/*[[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/permissions/email"
									   parameters:nil
									   HTTPMethod:@"DELETE"]
	 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
		 // ...
	 }];
	[[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/permissions/public_profile"
									   parameters:nil
									   HTTPMethod:@"DELETE"]
	 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
		 // ...
	 }];*/
	//[[FBSDKLoginManager new] logOut];
	if (![[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
		// User is logged in, do work such as go to next view controller
	}
	else
	{
		[self ConnectByFacebook];
	}
	
	/*if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
		// TODO: publish content.
	} else {
		FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
		[loginManager logInWithPublishPermissions:@[@"publish_actions"]
							   fromViewController:self
										  handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
											  //TODO: process error or result.
										  }];
	}*/
}

-(void)SetGestures
{
	_recognizer_close = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(CloseMenu:)];
	_recognizer_close.direction = UISwipeGestureRecognizerDirectionLeft;
	[self.viewMenu addGestureRecognizer:_recognizer_close];
	
	_recognizer_open = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(OpenMenu:)];
	_recognizer_open.direction = UISwipeGestureRecognizerDirectionRight;
	
	[self.view addGestureRecognizer:_recognizer_open];
	_recognizer_close2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(CloseMenu:)];
	_recognizer_close2.direction = UISwipeGestureRecognizerDirectionLeft;
	[self.view addGestureRecognizer:_recognizer_close2];

}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	CGRect frame = self.viewMenu.frame;
	frame.origin.x = -self.viewMenu.frame.size.width;
	self.viewMenu.frame = frame;
	
	self.page = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
-(NSMutableArray<Article*>*)articleList
{
	if(nil == _articleList)
		_articleList = [[NSMutableArray alloc] init];
	
	return _articleList;
}
-(NSMutableArray*)menuList
{
	if(nil == _menuList)
		_menuList = [[NSMutableArray alloc] initWithObjects:
					 @"Paylaşımlar",@"Paylaştıklarım",@"Kaydettiklerim",@"Bildirimlerim",@"Paylaşım Öner",@"Puan Tablosu",@"Ayarlar", nil];
	
	return _menuList;
}

-(MGInstagram*)instagram
{
	if(nil == _instagram)
	{
		_instagram = [[MGInstagram alloc] init];
	}
	return _instagram;
}

#pragma mark Table Delegate


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(((indexPath.row + 1) == self.articleList.count)
	   && self.page > 1)
		[self GetArticles];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView == self.tableList)
	{
		Article *article = [self.articleList objectAtIndex:indexPath.row];
		return CellHeightWithoutDescription + article.ContentSizeHeight;
	}
	
	return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	
	return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}



#pragma mark Table DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(tableView == self.tableList)
		return self.articleList.count;
	
	return self.menuList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView == self.tableList)
	{
		static NSString *identifier = @"tableCellFenomenia";
		TableCellFenomenia *cell = (TableCellFenomenia*)[tableView dequeueReusableCellWithIdentifier:identifier];
		
		if(nil == cell)
		{
			cell = [[TableCellFenomenia alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
			cell.cellDelegate = self;
			
		}
		cell.article = [self.articleList objectAtIndex:indexPath.row];
		
		return cell;
	}
	static NSString *identifierMenu = @"tableCellMenu";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMenu];
	if(nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierMenu];
	}
	
	cell.textLabel.text = [self.menuList objectAtIndex:indexPath.row];
	
	return cell;
}

#pragma mark Get Articles
-(void)GetArticles
{
	if(self.page == 1)
	{
		[self.articleList removeAllObjects];
		[self.tableList reloadData];
	}
	
	NSDictionary *params = @
	{
		@"Page":@(self.page),
		@"MemberId":@([User sharedUser].Id)

	};
	
	[self StartActivityWithPointY:500*HeightMultiplier];
	
	[[[WsUtil alloc]
	  initWithCaller:self
	  WithSuccededSel:@selector(GetArticles:WithResponse:)
	  WithFailedSel:@selector(GetArticles:WithError:)]
	 WsCallWithUrl:@"Article/GetAll"
	 WithHttpMethod:HttpPost
	 WithBodyParamters:params];
}
-(void)GetArticles:(WsUtil*)ws WithResponse:(NSDictionary*)response
{
	NSDictionary *dictResponse = response;
	if(nil != dictResponse)
	{
		NSDictionary *data = [dictResponse valueForKey:@"Data"];
		NSMutableArray * articleArray = (NSMutableArray*)[data valueForKey:@"ArticleList"];
		self.page = [[data valueForKey:@"Next"] integerValue];
		
		for (NSDictionary* dict in articleArray) {
			Article *article = [[Article alloc] init];
			article.Id = [[dict valueForKey:@"Id"] integerValue];
		
			article.Title = [dict valueForKey:@"Title"];
			article.Description = [dict valueForKey:@"Description"];
			article.MediaUrl = [dict valueForKey:@"MediaUrl"];
			article.Point = [[dict valueForKey:@"Point"] integerValue];
			article.IsLiked = [[dict valueForKey:@"IsLiked"] boolValue];
			article.IsBookMarked = [[dict valueForKey:@"IsBookMarked"] boolValue];
			article.Link = [dict valueForKey:@"Link"];
			article.TypeId = (ArticleType)[[dict valueForKey:@"TypeId"] integerValue];
			article.ShareCount = [[dict valueForKey:@"ShareCount"] integerValue];
			article.LikeCount = [[dict valueForKey:@"LikeCount"] integerValue];
			article.CreatedDate = [dict valueForKey:@"CreatedDate"];
			
			[self.articleList addObject:article];
			article = nil;
		}
		/*if(statusCode == STATUS_CODE)
		{
			[[User sharedUser] SetUserWithData:data];
			
		}
		else
		{
			[self StopActivity];
			NSString *returnMessage = [dictResponse valueForKey:@"ErrorMessage"];
			[UtilCommon AlertMessageIn:self WithCaption:@"" WithMessageText:returnMessage];
		}*/
		[self StopActivity];
		[self.tableList reloadData];
	}
	ws = nil;
}

-(void)GetArticles:(WsUtil*)ws WithError:(NSError*)error
{
	[self StopActivity];
	
	if([UtilCommon ShowConnectionError:error VC:self])
		[UtilCommon AlertMessageIn:self WithCaption:@"" WithMessageText:error.description];
	
	ws = nil;
}

#pragma mark Open Menu View
-(IBAction)OpenMenuView:(id)sender
{
	[self OpenViewMenu];
}

#pragma mark Open - Close Menu functions
-(void)OpenViewMenu
{
	CGPoint point = self.viewMenu.frame.origin;
	if(point.x ==  0)
	{
		[self CloseViewMenu];
		return;
	}
	else {
		
		self.viewMenu.hidden = NO;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		
		CGSize sizeMenu = self.viewMenu.frame.size;
		//CGSize sizeMain = self.viewMain.frame.size;
		[self.viewMenu setFrame:CGRectMake(0, 0, sizeMenu.width, sizeMenu.height)];
		
		
		[UIView commitAnimations];
		
	}
}

-(void)CloseViewMenu
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(CloseAnimationStopped:finished:context:)];
	CGSize sizeMenu = self.viewMenu.frame.size;
	
	
	[self.viewMenu setFrame:CGRectMake(-sizeMenu.width, 0, sizeMenu.width, sizeMenu.height)];
	
	[UIView commitAnimations];
}
-(void)CloseAnimationStopped:(NSString *)animationID
					finished:(NSNumber *)finished
					 context:(void *)context {
	self.viewMenu.hidden = YES;
}

-(void)CloseMenu:(UISwipeGestureRecognizer *)sender
{
	[self.view endEditing:YES];
	[self CloseViewMenu];
}


-(void)OpenMenu:(UISwipeGestureRecognizer *)sender
{
	[self.view endEditing:YES];
	[self OpenViewMenu];
}
-(void)CloseEditing:(UITapGestureRecognizer *)sender
{
	[self.view endEditing:YES];
	[self CloseViewMenu];
	[super CloseEditing:sender];
}

#pragma mark
#pragma mark Facebook Login
-(void)ConnectByFacebook
{
	FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
	[login setLoginBehavior:FBSDKLoginBehaviorSystemAccount];
	[login
	 //logInWithReadPermissions: @[@"public_profile",@"email",@"user_birthday"]
	 logInWithPublishPermissions:@[@"publish_actions"]
	 fromViewController:self
	 handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
		 if (error) {
			 [self StopActivity];
			 
			 if(error.code == -1009)
				 [UtilCommon AlertMessageIn:self WithCaption:@"" WithMessageText:[error.userInfo valueForKey:@"NSLocalizedDescription"]];
			 
			 [UtilCommon AlertMessageIn:self WithCaption:@"" WithMessageText:[UtilCommon GetCultureTxtForKey:@"alertFbConnectionError" DefaultValue:@"Facebook girişi Haga Aldı."]];
		 } else if (result.isCancelled) {
			 [self StopActivity];
			 [UtilCommon AlertMessageIn:self WithCaption:@"" WithMessageText:[UtilCommon GetCultureTxtForKey:@"alertFbConnectionCancel" DefaultValue:@"Facebook Girişi İptal edildi"]];
		 } else {
			 
		 }
	 }];
}

#pragma mark
#pragma mark TableCellFenomenia Delegate
-(void)ShareOnFacebook:(TableCellFenomenia*)cell
{
	
	/*NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	
	//Image must be saved as .igo to phoe directory in order to work.  This will be removed on the doc interaction controller delegate
	NSString *instagramTempImagePath = [documentsDirectory stringByAppendingPathComponent:@"InstagramImage.png"];
	
	//este metodo getNSDataFromImage es de es una clase helper pero basicamente solo es sacar el NSData de una UIImage
	
	[UIImagePNGRepresentation([cell GetPostImage]) writeToFile:instagramTempImagePath atomically:YES];
	NSURL *imageUrl = [NSURL fileURLWithPath:instagramTempImagePath];
	
	
	NSString *url = @"https://graph.facebook.com/me/photos";
	
	NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
		NSError *error;
		[formData appendPartWithFileURL:imageUrl name:@"file" fileName:@"file" mimeType:@"image/png" error:&error];
		
	} error:nil];
	
	[request setValue:[FBSDKAccessToken currentAccessToken].tokenString forHTTPHeaderField:@"access_token"];
	
	AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	
	NSURLSessionUploadTask *uploadTask;
	uploadTask = [manager
				  uploadTaskWithStreamedRequest:request
				  progress:^(NSProgress * _Nonnull uploadProgress) {
					  // This is not called back on the main queue.
					  // You are responsible for dispatching to the main queue for UI updates
					  dispatch_async(dispatch_get_main_queue(), ^{
						  //Update the progress view
						  
					  });
				  }
				  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
					  if (error) {
						  NSLog(@"Error: %@", error);
					  } else {
						  NSLog(@"%@ %@", response, responseObject);
					  }
				  }];
	
	[uploadTask resume];*/
	
	FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
	// image is a UIImage.
	
	content.photos = @[[FBSDKSharePhoto photoWithImage:[cell GetPostImage] userGenerated:YES]];
	[FBSDKShareAPI shareWithContent:content delegate:self];
	
	/*FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
								  initWithGraphPath:@"/me/photos" //As many fields as you need
								  parameters:@{@"picture":[cell GetPostImage],
											   @"no_story":@(true),
											   @"published":@(false),
											   }
								  
								  tokenString:[FBSDKAccessToken currentAccessToken].tokenString version:nil HTTPMethod:@"POST"];
	[request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
										  id result,
										  NSError *error) {
		if (!error){
			NSDictionary *picture = [(NSDictionary*)result objectForKey:@"picture"];
			NSDictionary *data = [picture objectForKey:@"data"];
			NSString *url = [data objectForKey:@"url"];
			
			
		}
	}];*/
}

-(void)ShareOnTwitter:(TableCellFenomenia*)cell
{}
-(void)ShareOnLinkedIn:(TableCellFenomenia*)cell
{}
-(void)ShareOnInstagram:(TableCellFenomenia*)cell
{
	//[self.instagram postImage:[cell GetPostImage] withCaption:cell.article.Description inView:self.view];
	
	[self postImage:[cell GetPostImage] withCaption:cell.article.Description inView:self.view delegate:nil];
}
-(void)ShareOnWhatsapp:(TableCellFenomenia*)cell
{}

- (NSString*)photoFilePath {
	return [NSString stringWithFormat:@"%@/%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],@"tempinstgramphoto.igo"];
}
- (void)postImage:(UIImage*)image withCaption:(NSString*)caption inView:(UIView*)view delegate:(id<UIDocumentInteractionControllerDelegate>)delegate {
	NSParameterAssert(image);
	
	if (!image) {
		return;
	}
	
	/*[UIImageJPEGRepresentation(image, 1.0) writeToFile:[self photoFilePath] atomically:YES];
	
	NSURL *fileURL = [NSURL fileURLWithPath:[self photoFilePath]];
	UIDocumentInteractionController *documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
	documentInteractionController.UTI = @"com.instagram.exclusivegram";
	documentInteractionController.delegate = delegate;
	if (caption) {
		documentInteractionController.annotation = @{@"InstagramCaption" : caption};
	}
	[documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:view animated:YES];*/
	
	//Instagram URL Scheme
	NSURL *instagramURL = [NSURL URLWithString:@"instagram://location?id=1"];
	if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
	{
		NSString *message = @"";
		
		NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
		
		//Image must be saved as .igo to phoe directory in order to work.  This will be removed on the doc interaction controller delegate
		NSString *instagramTempImagePath = [documentsDirectory stringByAppendingPathComponent:@"InstagramImage.igo"];
		
		//este metodo getNSDataFromImage es de es una clase helper pero basicamente solo es sacar el NSData de una UIImage

		[UIImageJPEGRepresentation(image, 1.0) writeToFile:instagramTempImagePath atomically:YES];
		NSURL *imageUrl = [NSURL fileURLWithPath:instagramTempImagePath];
		
		

			UIDocumentInteractionController *docInterationController = [[UIDocumentInteractionController alloc] init];

		docInterationController.delegate = self;
		docInterationController.UTI = @"com.instagram.exclusivegram";
		docInterationController.URL = imageUrl;
		docInterationController.annotation = [NSDictionary dictionaryWithObject:message forKey:@"InstagramCaption"];
		//[docInterationController presentPreviewAnimated:YES];
		[docInterationController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
		//[docInterationController presentOptionsMenuFromRect:CGRectZero inView:self.view animated:YES];
	}
}

#pragma mark - Delegate Methods

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
	
	return  self;
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application {
	
	NSLog(@"Starting to send this puppy to %@", application);
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
	
	NSLog(@"We're done sending the document.");
}
- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller
{
	
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
	
}

/**
 Sent to the delegate when the sharer encounters an error.
 - Parameter sharer: The FBSDKSharing that completed.
 - Parameter error: The error.
 */
- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
	
}

@end
