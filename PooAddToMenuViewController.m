//
//  PooAddToMenuViewController.m
//  Menu
//
//  Created by crazypoo on 14-2-24.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import "PooAddToMenuViewController.h"
#import "PooAddToMenuTableViewCell.h"
#import <objc/runtime.h>

static const char * const chooseBlock = "chooseBlock";

@interface PooAddToMenuViewController ()
@property (nonatomic, retain) UITableView *selectAdd;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) NSArray *name;
@property (nonatomic, retain) NSString *titleNameName;
@property (nonatomic, retain) NSMutableArray *currentData;
@property (nonatomic, retain) NSArray *pName;

@end

@implementation PooAddToMenuViewController
@synthesize selectAdd =_selectAdd;
@synthesize items = _items;
@synthesize name = _name;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize titleNameName = _titleNameName;
@synthesize currentData = _currentData;
@synthesize pName = _pName;

- (id)initWithTitleName:(NSString *)titleName data:(NSMutableArray *)items chooseValue:(GroupAndOperatorQueryBlock)block;
{
    if (self = [super init])
    {
        self.titleNameName = titleName;
        self.currentData = items;
        objc_setAssociatedObject(self, chooseBlock, [block copy], OBJC_ASSOCIATION_RETAIN);
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.titleNameName;
    // Do any additional setup after loading the view.
    
    UIButton *rightButtonForSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButtonForSearch.frame = CGRectMake(0, 8, 52, 28);
    rightButtonForSearch.backgroundColor = [UIColor redColor];
    [rightButtonForSearch setTitle:@"提交" forState:UIControlStateNormal];
    [rightButtonForSearch addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButtonForSearch];
    
    self.selectAdd = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    [self.selectAdd setSeparatorColor:[UIColor lightGrayColor]];
    self.selectAdd.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.selectAdd.dataSource = self;
    self.selectAdd.delegate = self;
    [self.view addSubview:self.self.selectAdd];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -about tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_currentData count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"identifier";
    PooAddToMenuTableViewCell *cell = (PooAddToMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[PooAddToMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if (indexPath.row != [_currentData count] ) {
        cell.dataTypeImageView.image = [UIImage imageNamed:[_currentData[indexPath.row] objectForKey:@"png"]];
        cell.labelName.text = (NSString *)[_currentData[indexPath.row] objectForKey:@"text"];
    }
    cell.willSelectImage.image = [UIImage imageNamed:@"close_x.png"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    PooAddToMenuTableViewCell *cell = (PooAddToMenuTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.willSelectImage.image = [UIImage imageNamed:@"favorite_add.png"];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PooAddToMenuTableViewCell *cell = (PooAddToMenuTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.willSelectImage.image = [UIImage imageNamed:@"close_x.png"];
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{

}

-(void)done:(id)sender
{
    GroupAndOperatorQueryBlock block;
    block = objc_getAssociatedObject(self, chooseBlock);
    if (block)
    {
        NSString *name = [NSString stringWithFormat:@"%@",[_currentData[self.selectedIndexPath.row] objectForKey:@"text"]];
        NSString *photoName = [NSString stringWithFormat:@"%@",[_currentData[self.selectedIndexPath.row] objectForKey:@"png"]];
        block(name,photoName);
    }
    [self.navigationController popToRootViewControllerAnimated:YES];

}
@end
