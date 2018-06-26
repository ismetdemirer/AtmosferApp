//
//  VcBase.m
//  Fenomenya
//
//  Created by Mehmet ONDER on 8.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "VcBase.h"
#import "Header.h"

#define ActivityWitdh 20*WitdhMultiplier

@interface VcBase ()
{
	UIActivityIndicatorView *activity;
}
@property (readonly)          UITapGestureRecognizer * editingFalse;

@end

@implementation VcBase

- (void)viewDidLoad {
    [super viewDidLoad];
	
	activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((ScreenWidth-ActivityWitdh)/2., (ScreenHeight-ActivityWitdh)/2., ActivityWitdh, ActivityWitdh)];
	activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	activity.hidesWhenStopped = YES;
	
	_editingFalse = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CloseEditing:)];
	[self.view addGestureRecognizer:self.editingFalse];
	
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

#pragma mark Close Editing
-(void)CloseEditing:(UITapGestureRecognizer *)sender
{
	[self.view endEditing:YES];
}

#pragma mark activity start stop
-(void)StartActivityWithPointY:(float)point WithSytle:(UIActivityIndicatorViewStyle)style
{
	activity.activityIndicatorViewStyle =  style;
	[self StartActivityWithPointY:point];
}
-(void)StartActivityWithPointY:(float)y
{
	CGRect activityFrame = activity.frame;
	activityFrame.origin.y = y;
	activity.frame = activityFrame;
	
	[self.view addSubview:activity];
	[activity startAnimating];
}
-(void)StopActivity
{
	[activity stopAnimating];
	[activity removeFromSuperview];
}

@end
