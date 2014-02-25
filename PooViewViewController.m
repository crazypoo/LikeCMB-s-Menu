//
//  PooViewViewController.m
//  Menu
//
//  Created by crazypoo on 2/24/14.
//  Copyright (c) 2014 crazypoo. All rights reserved.
//

#import "PooViewViewController.h"
#import "PooViewController.h"

@interface PooViewViewController ()

@end

@implementation PooViewViewController

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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
        
    UIButton *rightButtonForSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButtonForSearch.frame = CGRectMake(0, 8, 52, 28);
    rightButtonForSearch.backgroundColor = [UIColor redColor];
    [rightButtonForSearch setTitle:@"提交" forState:UIControlStateNormal];
    [rightButtonForSearch addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButtonForSearch];
}
-(void)done:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
