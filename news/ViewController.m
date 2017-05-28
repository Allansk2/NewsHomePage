//
//  ViewController.m
//  new
//
//  Created by Regina on 2017-05-27.
//  Copyright © 2017 Regina. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) UIScrollView *titlScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"CBC News";
    
    // add title scroll view
    [self setTitleScrollView];
    
    // add content scroll view
    [self setContentScrollView];
    
    // add all child view controllers
    
    
    // set all titles
    
    
    //
}


#pragma mark - add title scroll view
-(void)setTitleScrollView
{
    // init a scrollview
    UIScrollView *titlScrollView = [[UIScrollView alloc] init];
    titlScrollView.backgroundColor = [UIColor redColor];
    CGFloat y = self.navigationController.navigationBarHidden ? 20 : 64;
    titlScrollView.frame = CGRectMake(0, y, self.view.bounds.size.width, 44);
    
    [self.view addSubview:titlScrollView];
    _titlScrollView = titlScrollView;
    
}

#pragma add content scroll view
-(void)setContentScrollView
{
    // init a scrollview
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.backgroundColor = [UIColor greenColor];
    CGFloat y = CGRectGetMaxY(self.titlScrollView.frame);
    contentScrollView.frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height - y);
    
    [self.view addSubview:contentScrollView];
    _contentScrollView = contentScrollView;
}

#pragma add all child view controllers
-(void)setupChildViewControllers
{
    //   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
