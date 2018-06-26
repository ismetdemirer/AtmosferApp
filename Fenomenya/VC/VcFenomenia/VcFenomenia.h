//
//  VcFenomenia.h
//  Fenomenya
//
//  Created by Mehmet ONDER on 8.06.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "VcBase.h"
#import "TableCellFenomenia.h"
#import <FBSDKShareKit/FBSDKSharePhotoContent.h>
#import <FBSDKShareKit/FBSDKSharePhoto.h>
#import <FBSDKShareKit/FBSDKShareAPI.h>

@interface VcFenomenia : VcBase<TableCellFenomeniaDelegate,
UIDocumentInteractionControllerDelegate,
FBSDKSharingDelegate>

@property(nonatomic, strong) IBOutlet UITableView *tableList;

@property(nonatomic, strong) IBOutlet UITableView *tableMenu;
@property(nonatomic, strong) IBOutlet UILabel     *lblName;
@property(nonatomic, strong) IBOutlet UILabel     *lblDepartment;
@property(nonatomic, strong) IBOutlet UILabel     *lblPoint;

@property(nonatomic, strong) IBOutlet UIView      *viewMenu;
@property(nonatomic, strong) IBOutlet UIView      *viewSubView;


-(IBAction)OpenMenuView:(id)sender;

@end
