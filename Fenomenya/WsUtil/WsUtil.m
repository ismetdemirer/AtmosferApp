//
//  WsUtil.m
//  Fenomenya
//
//  Created by Mehmet ONDER on 9.05.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "WsUtil.h"
#import "Models.h"
#import "Header.h"
#import "AFNetworking/AFNetworking.h"
#import <AFHTTPSessionManager+Synchronous.h>

@interface WsUtil()

@property(assign)    id<WsUtilDelegate> delegate;
@property(assign)    id  caller;
@property(assign)    SEL succededSelector;
@property(assign)    SEL failedSelector;

-(void)PostWsCallWithUrl:(NSString *)urlStr
WithBodyParamters:(NSDictionary*)bodyParameters
			  WaitWs:(bool)wait;

-(void)GetWsCallWithUrl:(NSString *)urlStr
	   WithBodyParamters:(NSDictionary*)bodyParameters
				  WaitWs:(bool)wait;

-(void)PostSyncWsCallWithUrl:(NSString *)urlStr
	   WithBodyParamters:(NSDictionary*)bodyParameters;

-(void)GetSyncWsCallWithUrl:(NSString *)urlStr
	   WithBodyParamters:(NSDictionary*)bodyParameters;

@end

@implementation WsUtil

-(instancetype)initWithDelegate:(id)delegate
{
	if(self = [super init])
	{
		self.delegate = delegate;
	}
	return self;
}

-(instancetype)initWithCaller:(id)caller
				WithSuccededSel:(SEL)succededSel
				  WithFailedSel:(SEL)failedSel
{
	if(self = [super init])
	{
		self.caller = caller;
		self.succededSelector = succededSel;
		self.failedSelector = failedSel;
	}
	return self;
}

-(void)WsCallWithUrl:(NSString*)urlStr
{
	[self WsCallWithUrl:urlStr WithHttpMethod:HttpGet
	  WithBodyParamters:nil WaitWs:false];
}

-(void)WsCallWithUrl:(NSString*)urlStr
			  WaitWs:(bool)wait
{
	[self WsCallWithUrl:urlStr WithHttpMethod:HttpGet
	  WithBodyParamters:nil WaitWs:wait];
}

-(void)WsCallWithUrl:(NSString *)urlStr
	  WithHttpMethod:(HttpMethod)httpMethod
{
	[self WsCallWithUrl:urlStr WithHttpMethod:httpMethod
	  WithBodyParamters:nil WaitWs:false];
}

-(void)WsCallWithUrl:(NSString *)urlStr
	  WithHttpMethod:(HttpMethod)httpMethod
			  WaitWs:(bool)wait
{
	[self WsCallWithUrl:urlStr WithHttpMethod:httpMethod
	  WithBodyParamters:nil WaitWs:wait];
}

/// Default POST
-(void)WsCallWithUrl:(NSString *)urlStr
   WithBodyParamters:(NSDictionary*)bodyParameters
{
	[self WsCallWithUrl:urlStr WithHttpMethod:HttpGet
	  WithBodyParamters:bodyParameters WaitWs:false];
}

-(void)WsCallWithUrl:(NSString *)urlStr
   WithBodyParamters:(NSDictionary*)bodyParameters
			  WaitWs:(bool)wait
{
	[self WsCallWithUrl:urlStr WithHttpMethod:HttpGet
	  WithBodyParamters:bodyParameters WaitWs:wait];
}

-(void)WsCallWithUrl:(NSString *)urlStr
	  WithHttpMethod:(HttpMethod)httpMethod
   WithBodyParamters:(NSDictionary*)bodyParameters
{
	[self WsCallWithUrl:urlStr WithHttpMethod:httpMethod
	  WithBodyParamters:bodyParameters WaitWs:false];
}

-(void)WsCallWithUrl:(NSString *)urlStr
	  WithHttpMethod:(HttpMethod)httpMethod
   WithBodyParamters:(NSDictionary*)bodyParameters
			  WaitWs:(bool)wait
{
	if([self.delegate respondsToSelector:@selector(WsCallStarted:)])
		[self.delegate WsCallStarted:self];
	
	switch (httpMethod) {
		case HttpGet:
			[self GetWsCallWithUrl:urlStr WithBodyParamters:bodyParameters WaitWs:wait];
			break;
			
		case HttpPost:
			[self PostWsCallWithUrl:urlStr WithBodyParamters:bodyParameters WaitWs:wait];
			break;
		default:
			@throw [NSException
					exceptionWithName:@"MethodNotHandled"
					reason:@"Handle edilmeyen Method"
					userInfo:nil];
			break;
	}
	
	if([self.delegate respondsToSelector:@selector(WsCallEnded:)])
		[self.delegate WsCallEnded:self];
}

#pragma mark private methods
-(void)PostWsCallWithUrl:(NSString *)urlStr
	   WithBodyParamters:(NSDictionary*)bodyParameters
				  WaitWs:(bool)wait
{
	
	if(wait)
	{
		[self PostSyncWsCallWithUrl:urlStr WithBodyParamters:bodyParameters];
		return;
	}
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	[manager.requestSerializer setValue:[[User sharedUser] Token] forHTTPHeaderField:Authorization];
	
	[manager POST:SERVER_URL(urlStr)
	   parameters:bodyParameters
		 progress:^(NSProgress * uploadProgress)
	 {}
		  success: ^(NSURLSessionDataTask *task, id responseObject)
	 {
		 if(self.delegate != nil)
		 {
			 if([self.delegate respondsToSelector:@selector(WsCallSucceded:WithResponseData:)])
				 [self.delegate WsCallSucceded:self WithResponseData:responseObject];
			 
			 if([self.delegate respondsToSelector:@selector(WsCallSucceded:WithTask:)])
				 [self.delegate WsCallSucceded:self WithTask:task];
			 
			 if([self.delegate respondsToSelector:@selector(WsCallSucceded:WithTask:WithResponseData:)])
				 [self.delegate WsCallSucceded:self WithTask:task WithResponseData:responseObject];
		 }
		 
		 if(self.caller != nil && self.succededSelector != nil &&
			[self.caller respondsToSelector:self.succededSelector])
		 {
			 [self.caller performSelector:self.succededSelector withObject:self withObject:responseObject];
		 }
		 
	 }
		  failure: ^(NSURLSessionDataTask *task, NSError *error)
	 {
		 if(self.delegate != nil)
		 {
			 if([self.delegate respondsToSelector:@selector(WsCallFailed:WithTask:)])
				 [self.delegate WsCallFailed:self WithTask:task];
			 
			 if([self.delegate respondsToSelector:@selector(WsCallFailed:WithError:)])
				 [self.delegate WsCallFailed:self WithError:error];
			 
			 if([self.delegate respondsToSelector:@selector(WsCallFailed:WithTask:WithError:)])
				 [self.delegate WsCallFailed:self WithTask:task WithError:error];
		 }
		 
		 if(self.caller != nil && self.failedSelector != nil &&
			[self.caller respondsToSelector:self.failedSelector])
		 {
			 [self.caller performSelector:self.failedSelector withObject:self withObject:error];
		 }
	 }
	 ];
}

-(void)PostSyncWsCallWithUrl:(NSString *)urlStr
		   WithBodyParamters:(NSDictionary*)bodyParameters
{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	[manager.requestSerializer setValue:[[User sharedUser] Token] forHTTPHeaderField:Authorization];
	
	NSError *error = nil;
	
	NSData *responseData = [manager syncPOST:SERVER_URL(urlStr)
								  parameters:bodyParameters task:NULL error:&error];
	
	if(error == nil)
	{
		NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:responseData
															 options:kNilOptions error:&error];
		
		if( self.delegate != nil &&
		    [self.delegate respondsToSelector:@selector(WsCallSucceded:WithResponseData:)]
		   )
		{
			[self.delegate WsCallSucceded:self WithResponseData:responseObject];
		}
		
		if(self.caller != nil && self.succededSelector != nil &&
		   [self.caller respondsToSelector:self.succededSelector])
		{
			[self.caller performSelector:self.succededSelector withObject:self withObject:responseObject];
		}
	}
	else
	{
		if( self.delegate != nil &&
		   [self.delegate respondsToSelector:@selector(WsCallFailed:WithError:)]
		   )
		{
			[self.delegate WsCallFailed:self WithError:error];
		}
		
		if(self.caller != nil && self.failedSelector != nil &&
		   [self.caller respondsToSelector:self.failedSelector])
		{
			[self.caller performSelector:self.failedSelector withObject:self withObject:error];
		}
	}
	
}


-(void)GetWsCallWithUrl:(NSString *)urlStr
	   WithBodyParamters:(NSDictionary*)bodyParameters
				  WaitWs:(bool)wait
{
	if(wait)
	{
		[self GetSyncWsCallWithUrl:urlStr WithBodyParamters:bodyParameters];
		return;
	}
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	[manager.requestSerializer setValue:[[User sharedUser] Token] forHTTPHeaderField:Authorization];
	
	[manager GET:SERVER_URL(urlStr)
	   parameters:bodyParameters
		 progress:^(NSProgress * uploadProgress)
	 {}
		 success: ^(NSURLSessionDataTask *task, id responseObject)
	 {
		 if(self.delegate != nil)
		 {
			 if([self.delegate respondsToSelector:@selector(WsCallSucceded:WithResponseData:)])
				 [self.delegate WsCallSucceded:self WithResponseData:responseObject];
			 
			 if([self.delegate respondsToSelector:@selector(WsCallSucceded:WithTask:)])
				 [self.delegate WsCallSucceded:self WithTask:task];
			 
			 if([self.delegate respondsToSelector:@selector(WsCallSucceded:WithTask:WithResponseData:)])
				 [self.delegate WsCallSucceded:self WithTask:task WithResponseData:responseObject];
		 }
		 
		 if(self.caller != nil && self.succededSelector != nil &&
			[self.caller respondsToSelector:self.succededSelector])
		 {
			 [self.caller performSelector:self.succededSelector withObject:self withObject:responseObject];
		 }
		 
	 }
		 failure: ^(NSURLSessionDataTask *task, NSError *error)
	 {
		 if(self.delegate != nil)
		 {
			 if([self.delegate respondsToSelector:@selector(WsCallFailed:WithTask:)])
				 [self.delegate WsCallFailed:self WithTask:task];
			 
			 if([self.delegate respondsToSelector:@selector(WsCallFailed:WithError:)])
				 [self.delegate WsCallFailed:self WithError:error];
			 
			 if([self.delegate respondsToSelector:@selector(WsCallFailed:WithTask:WithError:)])
				 [self.delegate WsCallFailed:self WithTask:task WithError:error];
			 
		 }
		 
		 if(self.caller != nil && self.failedSelector != nil &&
			[self.caller respondsToSelector:self.failedSelector])
		 {
			 [self.caller performSelector:self.failedSelector withObject:self withObject:error];
		 }
	 }
	 ];
}

-(void)GetSyncWsCallWithUrl:(NSString *)urlStr
		  WithBodyParamters:(NSDictionary*)bodyParameters
{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	[manager.requestSerializer setValue:[[User sharedUser] Token] forHTTPHeaderField:Authorization];
	
	NSError *error = nil;
	
	NSData *responseData = [manager syncGET:SERVER_URL(urlStr)
								  parameters:bodyParameters task:NULL error:&error];
	
	if(error == nil)
	{
		NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:responseData
																	   options:kNilOptions error:&error];
		
		if( self.delegate != nil &&
		    [self.delegate respondsToSelector:@selector(WsCallSucceded:WithResponseData:)]
		   )
		{
			[self.delegate WsCallSucceded:self WithResponseData:responseObject];
		}
		
		if(self.caller != nil && self.succededSelector != nil &&
		   [self.caller respondsToSelector:self.succededSelector])
		{
			[self.caller performSelector:self.succededSelector withObject:self withObject:responseObject];
		}
	}
	else
	{
		if( self.delegate != nil &&
		    [self.delegate respondsToSelector:@selector(WsCallFailed:WithError:)]
		   )
		{
			[self.delegate WsCallFailed:self WithError:error];
		}
		
		if(self.caller != nil && self.failedSelector != nil &&
		   [self.caller respondsToSelector:self.failedSelector])
		{
			[self.caller performSelector:self.failedSelector withObject:self withObject:error];
		}
	}
}

@end
