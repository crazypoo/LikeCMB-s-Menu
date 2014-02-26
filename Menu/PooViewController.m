//
//  PooViewController.m
//  Menu
//
//  Created by crazypoo on 14-2-24.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import "PooViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GMGridView.h"
#import "GMGridViewCell+Extended.h"
#import "PooAddToMenuViewController.h"
#import "GMGridViewCell.h"
#import "PooViewViewController.h"
#define NUMBER_ITEMS_ON_LOAD 14
#define NUMBER_ITEMS_ON_LOAD2 30
//////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark ViewController (privates methods)
//////////////////////////////////////////////////////////////

@interface PooViewController () <GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewTransformationDelegate, GMGridViewActionDelegate>
{
//    __gm_weak GMGridView *_gmGridView;
    UINavigationController *_optionsNav;
    UIPopoverController *_optionsPopOver;
    
    NSMutableArray *_data;
    NSMutableArray *_data2;
    NSMutableArray *_currentData;
    NSInteger _lastDeleteItemIndexAsked;
}
@property (nonatomic, retain) RNFrostedSidebar *callout;
@property (nonatomic, retain) NSMutableArray *AfterCurrentData;
@property (nonatomic, retain) GMGridView *gmGridView;

- (void)addMoreItem;
@end


//////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark ViewController implementation
//////////////////////////////////////////////////////////////

@implementation PooViewController
@synthesize callout = _callout;
@synthesize AfterCurrentData = _AfterCurrentData;
@synthesize gmGridView = _gmGridView;

- (id)init
{
    if ((self =[super init]))
    {
        self.title = @"銷售助手";
        
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editItem:)];
        self.navigationItem.leftBarButtonItem = editButton;
        
        UIBarButtonItem *optionsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(onBurger:)];
        
        if ([self.navigationItem respondsToSelector:@selector(rightBarButtonItems)]) {
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:optionsButton, nil];
        }else {
            self.navigationItem.rightBarButtonItem = optionsButton;
        }
        
        NSDictionary *data1 = @{@"png": @"分析中心.png",@"text":@"分析中心"};
        NSDictionary *data2 = @{@"png": @"国债计算器.png",@"text":@"国债计算器"};
        NSDictionary *data3 = @{@"png": @"合买大厅.png",@"text":@"合买大厅"};
        NSDictionary *data4 = @{@"png": @"基金净值.png" ,@"text":@"基金净值"};
        NSDictionary *data5 = @{@"png": @"基金资讯.png" ,@"text":@"基金资讯"};
        NSDictionary *data6 = @{@"png": @"卡片管理.png" ,@"text":@"卡片管理"};
        NSDictionary *data7 = @{@"png": @"其他缴费.png" ,@"text":@"其他缴费"};
        NSDictionary *data8 = @{@"png": @"商户查询.png" ,@"text":@"商户查询"};
        NSDictionary *data9 = @{@"png": @"商旅预订.png" ,@"text":@"商旅预订"};
        NSDictionary *data10 = @{@"png": @"售汇.png" ,@"text":@"售汇"};
        NSDictionary *data11 = @{@"png": @"外汇管理.png" ,@"text":@"外汇管理"};
        NSDictionary *data12 = @{@"png": @"外汇汇率.png" ,@"text":@"外汇汇率"};
        NSDictionary *data13 = @{@"png": @"外汇计算器.png" ,@"text":@"外汇计算器"};
        NSDictionary *data14 = @{@"png": @"外汇资讯.png",@"text":@"外汇资讯"};
        
        items = @[data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,data14];
        _currentData = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < 8; i++) {
            [_currentData addObject:items[i]];
        }
        NSArray *AfterItems = [items subarrayWithRange:NSMakeRange(8,6)];
        self.AfterCurrentData = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < 6; i++) {
            [self.AfterCurrentData addObject:AfterItems[i]];
        }
    }
    
    return self;
}
- (void)editItem:(UIBarButtonItem *)sender
{
    _gmGridView.editing = !_gmGridView.editing;
}

//////////////////////////////////////////////////////////////
#pragma mark controller events
//////////////////////////////////////////////////////////////

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSInteger spacing = INTERFACE_IS_PHONE ? 10 : 15;
    
    _gmGridView = [[GMGridView alloc] initWithFrame:self.view.bounds];
    _gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _gmGridView.backgroundColor = [UIColor clearColor];    
    _gmGridView.style = GMGridViewStyleSwap;
    _gmGridView.itemSpacing = spacing;
    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    _gmGridView.centerGrid = NO;
    _gmGridView.actionDelegate = self;
    _gmGridView.sortingDelegate = self;
    _gmGridView.transformDelegate = self;
    _gmGridView.dataSource = self;
    [self.view addSubview:_gmGridView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _gmGridView.mainSuperView = self.navigationController.view;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [_gmGridView addGestureRecognizer:tapGesture];
}

- (void)tapGesture:(UITapGestureRecognizer *)sender
{
    _gmGridView.editing = NO;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    _gmGridView = nil;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

//////////////////////////////////////////////////////////////
#pragma mark memory management
//////////////////////////////////////////////////////////////

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}

//////////////////////////////////////////////////////////////
#pragma mark orientation management
//////////////////////////////////////////////////////////////

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}


//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [_currentData count] + 1;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(170, 135);
        }
        else
        {
            return CGSizeMake(65, 85);
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(285, 205);
        }
        else
        {
            return CGSizeMake(230, 175);
        }
    }
//    return CGSizeMake(65, 85);
}


- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        cell.deleteButtonIcon = [UIImage imageNamed:@"close_x.png"];
        cell.deleteButtonOffset = CGPointMake(-15, -15);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        //        view.backgroundColor = [UIColor redColor];
        view.layer.masksToBounds = NO;
        
        view.layer.cornerRadius = 8;
        cell.contentView = view;
    }
    
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGRect frame = cell.contentView.bounds;
    ;
    UIImage *image ;
    
    if (index != [_currentData count] ) {
        image  = [UIImage imageNamed: [_currentData[index] objectForKey:@"png"]];
    } else {
        image  = [UIImage imageNamed:@"favorite_add.png"];
        cell.deleteButton = nil;
        cell.contentView.tag = 9999;
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                              CGRectMake((size.width-58)/2,(size.height-(58))/2,58,58)];
    [imageView setImage:image];
    [cell.contentView addSubview:imageView];
    
    
    frame.origin.y += 43;
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (index != [_currentData count] ) {
        label.text = (NSString *)[_currentData[index] objectForKey:@"text"];
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:13];
    [cell.contentView addSubview:label];
    
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return YES; //index % 2 == 0;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    NSLog(@"Did tap at index %ld", (long)position);
    
    GMGridViewCell *cell = [gridView cellForItemAtIndex:position];
 
    if ((cell.contentView.tag == 9999) ) {
        if (position != [items count]) {
            PooAddToMenuViewController *temp = [[PooAddToMenuViewController alloc] initWithTitleName:@"添加你喜歡的" data:self.AfterCurrentData chooseValue:^(NSString *name,NSString *photoName) {
                NSDictionary *data = @{@"png":photoName,@"text":name};
                [_currentData addObject:data];
                [self.AfterCurrentData removeObject:data];
                [_gmGridView insertObjectAtIndex:[_currentData count] - 1 withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
            }];
            [self.navigationController pushViewController:temp animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没有项目了" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
    else
    {
        NSString *label = [NSString stringWithFormat:@"%@",(NSString *)[_currentData[position] objectForKey:@"text"]];
        if ([label isEqualToString:@"分析中心"]) {
            PooViewViewController *view = [[PooViewViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
        else if ([label isEqualToString:@"国债计算器"])
        {
            NSString *aasdasd = [NSString stringWithFormat:@"操你妈妈"];
            UIAlertView *hi = [[UIAlertView alloc] initWithTitle:aasdasd message:@"dasda" delegate:self cancelButtonTitle:@"hi" otherButtonTitles:nil, nil];
            [hi show];
        }
    }
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認" message:@"你確定要刪除？" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    
    [alert show];
    
    _lastDeleteItemIndexAsked = index;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString *name = [NSString stringWithFormat:@"%@",[_currentData[_lastDeleteItemIndexAsked] objectForKey:@"text"]];
        NSString *photoName = [NSString stringWithFormat:@"%@",[_currentData[_lastDeleteItemIndexAsked] objectForKey:@"png"]];
        NSDictionary *data = @{@"png":photoName,@"text":name};
        [_currentData removeObjectAtIndex:_lastDeleteItemIndexAsked];
        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
        [self.AfterCurrentData addObject:data];

    }
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewSortingDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
 
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor clearColor];
                         cell.contentView.layer.shadowOpacity = 1;
                     }
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor clearColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}

- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    if (index != [_currentData count])
        return YES;
    return NO;
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    if (oldIndex != [_currentData count]) {
        NSObject *object = [_currentData objectAtIndex:oldIndex];
        [_currentData removeObject:object];
        [_currentData insertObject:object atIndex:newIndex];
    }
    
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    if (index1 != [_currentData count] && index2 != [_currentData count]) {
        [_currentData exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
    }
}


//////////////////////////////////////////////////////////////
#pragma mark DraggableGridViewTransformingDelegate
//////////////////////////////////////////////////////////////

- (CGSize)GMGridView:(GMGridView *)gridView sizeInFullSizeForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index inInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(320, 210);
        }
        else
        {
            return CGSizeMake(300, 310);
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(700, 530);
        }
        else
        {
            return CGSizeMake(600, 500);
        }
    }
}

- (UIView *)GMGridView:(GMGridView *)gridView fullSizeViewForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    UIView *fullView = [[UIView alloc] init];
    fullView.backgroundColor = [UIColor yellowColor];
    fullView.layer.masksToBounds = NO;
    fullView.layer.cornerRadius = 8;
    
    CGSize size = [self GMGridView:gridView sizeInFullSizeForCell:cell atIndex:index inInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    fullView.bounds = CGRectMake(0, 0, size.width, size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:fullView.bounds];
    label.text = [NSString stringWithFormat:@"Fullscreen View for cell at index %ld", (long)index];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (INTERFACE_IS_PHONE)
    {
        label.font = [UIFont boldSystemFontOfSize:15];
    }
    else
    {
        label.font = [UIFont boldSystemFontOfSize:20];
    }
    
    [fullView addSubview:label];
    
    
    return fullView;
}

- (void)GMGridView:(GMGridView *)gridView didStartTransformingCell:(GMGridViewCell *)cell
{
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor blueColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEndTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEnterFullSizeForCell:(UIView *)cell
{
    
}


//////////////////////////////////////////////////////////////
#pragma mark private methods
//////////////////////////////////////////////////////////////

- (void)addMoreItem
{
    // Example: adding object at the last position
    [_currentData addObject:items[[_currentData count]]];
    [_gmGridView insertObjectAtIndex:[_currentData count] - 1 withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
}

#pragma mark - RNFrostedSidebarDelegate
- (void)onBurger:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"globe"]
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1]
                        ];
    
    self.callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:nil borderColors:colors];
    self.callout.delegate = self;
    self.callout.showFromRight = YES;
    [self.callout show];
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %lu",(unsigned long)index);
    if (index == 0) {
        PooViewViewController *view = [[PooViewViewController alloc] init];
        [self.navigationController pushViewController:view animated:NO];
        view.title = @"asdadsasd";
        [self.callout dismiss];
    }
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
    }
    else {
    }
}

@end
