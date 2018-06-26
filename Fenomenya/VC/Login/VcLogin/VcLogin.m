//
//  VcLogin.m
//  Fenomenya
//
//  Created by Mehmet ONDER on 8.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "VcLogin.h"
#import "Header.h"

@interface VcLogin ()

@end

@implementation VcLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Action Login
-(IBAction)ActionLogin:(id)sender
{
	[self.view endEditing:YES];
	
	NSString *eMail = [self.txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if(![UtilCommon isValidMail:eMail])
	{
		[UtilCommon AlertMessageIn:self WithCaption:@"" WithMessageText:[UtilCommon GetCultureTxtForKey:@"alertValidEmail" DefaultValue:@"Geçerli bir mail adresi giriniz."]];
		
		self.imgViewUserName.image = [UtilCommon imageWithName:@"text-field-bg-error"];
		
		return;
		
	}
	
	self.imgViewUserName.image = [UtilCommon imageWithName:@"text-field-bg"];
	
	NSString *passWord = [self.txtPassWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if(![UtilCommon isValidPass:passWord])
	{
		[UtilCommon AlertMessageIn:self WithCaption:@"" WithMessageText:[UtilCommon GetCultureTxtForKey:@"alertValidPassWord" DefaultValue:@"Şifre en az 3 karakter olmalıdır."]];
		
		self.imgViewUserPassWord.image = [UtilCommon imageWithName:@"text-field-bg-error"];
		
		return;
	}
	
	self.imgViewUserPassWord.image = [UtilCommon imageWithName:@"text-field-bg"];
	
	
	NSDictionary *params = @
	{
		@"Email":eMail,
		@"Password":passWord,
		@"Operator":(CARRIER.length == 0) ? @"":CARRIER,
		@"Os":OS,
		@"OsVersion":IOS_VERSION,
		@"Brand":BRAND,
		@"Model":[UtilCommon deviceModelName],
		@"DeviceToken":[[User sharedUser] DeviceToken],
		@"AppVersion":VERSION
	};
	
	[self StartActivityWithPointY:500*HeightMultiplier];
	
	[[[WsUtil alloc]
	  initWithCaller:self
	  WithSuccededSel:@selector(Login:WithResponse:)
	  WithFailedSel:@selector(Login:WithError:)]
	 WsCallWithUrl:@"Member/Login"
	 WithHttpMethod:HttpPost
	 WithBodyParamters:params];
}
-(void)Login:(WsUtil*)ws WithResponse:(NSDictionary*)response
{
	NSDictionary *dictResponse = response;
	if(nil != dictResponse)
	{
		NSDictionary *data = [dictResponse valueForKey:@"Data"];
		
		NSInteger statusCode = [[dictResponse valueForKey:@"StatusCode"] integerValue];
		
		if(statusCode == STATUS_CODE)
		{
			[[User sharedUser] SetUserWithData:data];
			
			[self dismissViewControllerAnimated:YES completion:^
			 {
				 [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisterByMail" object:nil userInfo:nil];

			 }];
		}
		else
		{
			[self StopActivity];
			NSString *returnMessage = [dictResponse valueForKey:@"ErrorMessage"];
			[UtilCommon AlertMessageIn:self WithCaption:@"" WithMessageText:returnMessage];
		}
	}
	ws = nil;
}

-(void)Login:(WsUtil*)ws WithError:(NSError*)error
{
	[self StopActivity];
	
	if([UtilCommon ShowConnectionError:error VC:self])
		[UtilCommon AlertMessageIn:self WithCaption:@"" WithMessageText:error.description];
	
	ws = nil;
}
#pragma mark Action Register
-(IBAction)ActionRegister:(id)sender
{

	
}

#pragma mark Action ForgetPassword
-(IBAction)ActionForgetPassword:(id)sender
{
	
}

#pragma mark TextFieldDelegations
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if(textField == self.txtUserName)
	{
		if([string isEqualToString:@"@"])
		{
			textField.text = [NSString stringWithFormat:@"%@%@", textField.text, @"@albarakaturk.com.tr"];
			
			return NO;
		}
	}
	return YES;
}

@end
