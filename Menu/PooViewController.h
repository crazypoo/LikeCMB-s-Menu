//
//  PooViewController.h
//  Menu
//
//  Created by crazypoo on 14-2-24.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface PooViewController : UIViewController<RNFrostedSidebarDelegate>
{
    NSArray *imageArr;
    NSArray *textArr;
    
    NSArray *items;
}
@end
