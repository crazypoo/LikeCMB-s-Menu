//
//  PooAddToMenuViewController.h
//  Menu
//
//  Created by crazypoo on 14-2-24.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//
typedef void (^GroupAndOperatorQueryBlock)(NSString *name, NSString *photoName);

#import <UIKit/UIKit.h>

@interface PooAddToMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (id)initWithTitleName:(NSString *)titleName data:(NSMutableArray *)items chooseValue:(GroupAndOperatorQueryBlock)block ;
//-(id)initWithIconAndName:(NSMutableArray *)items;
@end
