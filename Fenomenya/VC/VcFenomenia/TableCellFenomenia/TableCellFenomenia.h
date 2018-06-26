//
//  TableCellFenomenia.h
//  Fenomenya
//
//  Created by Mehmet ONDER on 10.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "BaseTableCell.h"
#import "Models.h"
#define CellHeightWithoutDescription 360 * WitdhMultiplier

@class TableCellFenomenia;

@protocol TableCellFenomeniaDelegate<NSObject>
-(void)ShareOnFacebook:(TableCellFenomenia*)cell;
-(void)ShareOnTwitter:(TableCellFenomenia*)cell;
-(void)ShareOnLinkedIn:(TableCellFenomenia*)cell;
-(void)ShareOnInstagram:(TableCellFenomenia*)cell;
-(void)ShareOnWhatsapp:(TableCellFenomenia*)cell;
@end

@interface TableCellFenomenia : BaseTableCell
@property(nonatomic, assign)  Article *article;
@property(nonatomic, strong) id<TableCellFenomeniaDelegate> cellDelegate;

-(UIImage*)GetPostImage;
@end
