//
//  WsUtil.h
//  Fenomenya
//
//  Created by Mehmet ONDER on 9.05.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
	HttpGet,
	HttpPost
}HttpMethod;

@class WsUtil;
@protocol WsUtilDelegate <NSObject>

@optional

-(void)WsCallStarted:(WsUtil*)ws;
-(void)WsCallEnded:(WsUtil*)ws;

-(void)WsCallSucceded:(WsUtil*)ws WithResponseData:(id)responseObject;
-(void)WsCallSucceded:(WsUtil*)ws WithTask:(NSURLSessionDataTask*)task;
-(void)WsCallSucceded:(WsUtil*)ws WithTask:(NSURLSessionDataTask*)task WithResponseData:(id)responseObject;

-(void)WsCallFailed:(WsUtil*)ws WithError:(NSError*)error;
-(void)WsCallFailed:(WsUtil*)ws WithTask:(NSURLSessionDataTask *)task;
-(void)WsCallFailed:(WsUtil*)ws WithTask:(NSURLSessionDataTask *)task WithError:(NSError*)error;

@end

@interface WsUtil : NSObject



-(instancetype)initWithDelegate:(id)delegate;

-(instancetype)initWithCaller:(id)caller
				WithSuccededSel:(SEL)succededSel
					 WithFailedSel:(SEL)failedSel;


-(void)WsCallWithUrl:(NSString*)urlStr;

-(void)WsCallWithUrl:(NSString*)urlStr
			  WaitWs:(bool)wait;

-(void)WsCallWithUrl:(NSString *)urlStr
	  WithHttpMethod:(HttpMethod)httpMethod;

-(void)WsCallWithUrl:(NSString *)urlStr
	  WithHttpMethod:(HttpMethod)httpMethod
			  WaitWs:(bool)wait;

-(void)WsCallWithUrl:(NSString *)urlStr
   WithBodyParamters:(NSDictionary*)bodyParameters;

-(void)WsCallWithUrl:(NSString *)urlStr
   WithBodyParamters:(NSDictionary*)bodyParameters
			  WaitWs:(bool)wait;

-(void)WsCallWithUrl:(NSString *)urlStr
	  WithHttpMethod:(HttpMethod)httpMethod
   WithBodyParamters:(NSDictionary*)bodyParameters;

-(void)WsCallWithUrl:(NSString *)urlStr
	  WithHttpMethod:(HttpMethod)httpMethod
   WithBodyParamters:(NSDictionary*)bodyParameters
			  WaitWs:(bool)wait;
@end
