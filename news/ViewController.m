//
//  ViewController.m
//  new
//
//  Created by Regina on 2017-05-27.
//  Copyright © 2017 Regina. All rights reserved.
//

#import "ViewController.h"
#import "TopNewsViewController.h"
#import "HotViewController.h"
#import "VideoViewController.h"
#import "SocialViewController.h"
#import "SubscribeViewController.h"
#import "TechnologyViewController.h"

@interface ViewController ()
@property (nonatomic, weak) UIScrollView *titlScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, weak) UIButton *selectedBtn;

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
    [self setupChildViewControllers];
    
    // set all titles
    [self setupTitles];
 
}


#pragma mark - add title scroll view
-(void)setTitleScrollView
{
    // init a scrollview
    UIScrollView *titlScrollView = [[UIScrollView alloc] init];
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
    TopNewsViewController *topVC = [[TopNewsViewController alloc] init];
    topVC.title = @"Top News";
    [self addChildViewController:topVC];
    
    HotViewController *hotVC = [[HotViewController alloc] init];
    hotVC.title = @"Hot";
    [self addChildViewController:hotVC];
    
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    videoVC.title = @"Video";
    [self addChildViewController:videoVC];
    
    SocialViewController *socialVC = [[SocialViewController alloc] init];
    socialVC.title = @"Social";
    [self addChildViewController:socialVC];
    
    SubscribeViewController *subscribeVC = [[SubscribeViewController alloc] init];
    subscribeVC.title = @"Subscribe";
    [self addChildViewController:subscribeVC];
    
    TechnologyViewController *technologyVC = [[TechnologyViewController alloc] init];
    technologyVC.title = @"Tech";
    [self addChildViewController:technologyVC];
    
}

#pragma setup titles
-(void)setupTitles
{
    // add title buttons
    CGFloat btnWidth = 100;
    CGFloat btnHeight = self.titlScrollView.bounds.size.height;
    CGFloat btnX = 0;
    NSInteger count = self.childViewControllers.count;
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:vc.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnX = i * btnWidth;
        button.frame = CGRectMake(btnX, 0, btnWidth, btnHeight);
        [button addTarget:self action:@selector(titlePressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.titlScrollView addSubview:button];
        
        if (i == 0) {
            [self titlePressed:button];
        }
    }
    self.titlScrollView.contentSize = CGSizeMake(count * btnWidth, btnHeight);
    self.titlScrollView.showsHorizontalScrollIndicator = NO;
    self.titlScrollView.showsVerticalScrollIndicator = NO;
}

#pragma title pressed
-(void)titlePressed:(UIButton *)button
{
    NSInteger i = button.tag;
    // set title button text color and font
    [self selectedButton:button];
 
    // get child viewcontroller
    UIViewController *vc = self.childViewControllers[i];
    CGFloat vcX = i * [UIScreen mainScreen].bounds.size.width;
    vc.view.frame = CGRectMake(vcX, 0, [UIScreen mainScreen].bounds.size.width, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
    
    // set content scrollview offset
    self.contentScrollView.contentOffset = CGPointMake(vcX, 0);
    
     
    
}

#pragma set title button text color
-(void)selectedButton:(UIButton *)button
{
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];

    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:19.0];

    _selectedBtn = button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
