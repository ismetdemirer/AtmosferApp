//
//  VcWelcome.h
//  Fenomenya
//
//  Created by Mehmet ONDER on 8.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "VcBase.h"

@interface VcWelcome : VcBase

@property(nonatomic) IBOutlet UIScrollView  *scrView;
@property(nonatomic) IBOutlet UIPageControl *pageControl;


-(IBAction)PageControlValueChanged:(id)sender;

-(IBAction)ActionLogin:(id)sender;
-(IBAction)ActionRegister:(id)sender;



@end
