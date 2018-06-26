//
//  VcLogin.h
//  Fenomenya
//
//  Created by Mehmet ONDER on 8.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "VcBase.h"

@interface VcLogin : VcBase

@property(nonatomic) IBOutlet UIImageView *imgViewUserName;
@property(nonatomic) IBOutlet UIImageView *imgViewUserPassWord;

@property(nonatomic) IBOutlet UITextField *txtUserName;
@property(nonatomic) IBOutlet UITextField *txtPassWord;


-(IBAction)ActionLogin:(id)sender;
-(IBAction)ActionRegister:(id)sender;
-(IBAction)ActionForgetPassword:(id)sender;
@end
