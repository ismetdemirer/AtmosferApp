//
//  BaseTableCell.h
//  Fenomenya
//
//  Created by Mehmet ONDER on 10.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableCell : UITableViewCell

-(UIImage*)getImage:(NSString*)keyId WithUrl:(NSString*)url;
-(void)SetKeyId:(NSString*)keyId SetImage:(UIImage*)img;
@end
