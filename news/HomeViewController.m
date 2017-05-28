//
//  HomeViewController.m
//  news
//
//  Created by Regina on 2017-05-28.
//  Copyright © 2017 Allan. All rights reserved.
//

#import "HomeViewController.h"
#import "TopNewsViewController.h"
#import "HotViewController.h"
#import "VideoViewController.h"
#import "SocialViewController.h"
#import "SubscribeViewController.h"
#import "TechnologyViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // add all child view controllers
    [self setupChildViewControllers];
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


@end
