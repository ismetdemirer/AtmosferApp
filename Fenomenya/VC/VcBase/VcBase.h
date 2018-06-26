//
//  VcBase.h
//  Fenomenya
//
//  Created by Mehmet ONDER on 8.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VcBase : UIViewController

-(void)CloseEditing:(UITapGestureRecognizer *)sender;

// activity start / stop
-(void)StartActivityWithPointY:(float)point
					 WithSytle:(UIActivityIndicatorViewStyle)style;
-(void)StartActivityWithPointY:(float)point;
-(void)StopActivity;

@end
