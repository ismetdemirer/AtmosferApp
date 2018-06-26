//
//  GradientButton.m
//  Fenomenya
//
//  Created by Mehmet ONDER on 10.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "GradientButton.h"

//IB_DESIGNABLE

@implementation GradientButton

- (void)drawRect:(CGRect)rect
{
	/*CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents
	(colorSpace,
	 (const CGFloat[8]){1.0f, 0.0f, 0.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f},
	 (const CGFloat[2]){0.0f,1.0f},
	 2);
	
	CGContextDrawLinearGradient(context,
								gradient,
								CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds)),
								CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds)),
								0);
	
	CGColorSpaceRelease(colorSpace);
	CGContextRestoreGState(context);*/
	
	/*CAGradientLayer *gradient = [[CAGradientLayer alloc] init];
	gradient.frame = CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
	gradient.colors = @[(id)self.startColor.CGColor, (id)self.endColor.CGColor];
	gradient.zPosition = -1;
	[self.layer addSublayer:gradient];*/
	
	self.layer.cornerRadius = 20;
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.zPosition = -1;
	gradientLayer.frame = self.layer.bounds;
	
	UIColor *startColor = [UIColor colorWithRed:251./255. green:63./255. blue:70./255. alpha:1];
	
	UIColor *endColor = [UIColor colorWithRed:253./255. green:170./255. blue:86/255. alpha:1];
	
	gradientLayer.colors = [NSArray arrayWithObjects:
							(id)startColor.CGColor,
							(id)endColor.CGColor,
							nil];
	
	gradientLayer.locations = [NSArray arrayWithObjects:
							   [NSNumber numberWithFloat:0.0f],
							   [NSNumber numberWithFloat:1.0f],
							   nil];
	
	gradientLayer.startPoint = CGPointMake(1.0, 0.5);
	gradientLayer.endPoint = CGPointMake(0.0, 0.5);
	
	gradientLayer.cornerRadius = self.layer.cornerRadius;
	[self.layer addSublayer:gradientLayer];
}

@end
