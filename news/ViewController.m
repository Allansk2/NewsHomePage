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


#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *titlScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *titlBtns;

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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //
 
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
    
    self.titlScrollView.showsHorizontalScrollIndicator = NO;
    self.titlScrollView.showsVerticalScrollIndicator = NO;
}

#pragma add content scroll view
-(void)setContentScrollView
{
    // init a scrollview
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    CGFloat y = CGRectGetMaxY(self.titlScrollView.frame);
    contentScrollView.frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height - y);
    
    [self.view addSubview:contentScrollView];
    _contentScrollView = contentScrollView;
    
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;

    self.contentScrollView.delegate = self;
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
        
        // calculate button x position
        btnX = i * btnWidth;
        button.frame = CGRectMake(btnX, 0, btnWidth, btnHeight);
        [button addTarget:self action:@selector(titlePressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        
        // add button to title scrollview
        [self.titlScrollView addSubview:button];
        
        // set default select button
        if (i == 0) {
            [self titlePressed:button];
        }
        
        // add button to array
        [self.titlBtns addObject:button];
    }
    
    
    self.titlScrollView.contentSize = CGSizeMake(count * btnWidth, 0);
    self.contentScrollView.contentSize = CGSizeMake(count * screenWidth, 0);
 
}

#pragma mark - setup a childviewcontroller
-(void)setupChildViewController:(NSInteger)i
{
    UIViewController *vc = self.childViewControllers[i];
    if (vc.view.superview) {
        return;
    }
    CGFloat vcX = i * screenWidth;
    vc.view.frame = CGRectMake(vcX, 0, screenWidth, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
    
}

#pragma title pressed
-(void)titlePressed:(UIButton *)button
{
    NSInteger i = button.tag;
    // set title button text color and font
    [self selectedButton:button];
 
    // get child viewcontroller
    [self setupChildViewController:i];
    
    // set content scrollview offset
    CGFloat vcX = i * screenWidth;
    self.contentScrollView.contentOffset = CGPointMake(vcX, 0);
}

#pragma set title button text color
-(void)selectedButton:(UIButton *)button
{
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedBtn.transform = CGAffineTransformIdentity;

    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    _selectedBtn = button;
    
    // set button title center
    [self centerButton:button];
}

#pragma button center
-(void)centerButton:(UIButton *)button
{
    CGFloat offSetX = button.center.x - screenWidth * 0.5;
    if (offSetX < 0) {
        offSetX = 0;
    }
    CGFloat maxOffSetX = self.titlScrollView.contentSize.width - screenWidth;
    if (offSetX > maxOffSetX) {
        offSetX = maxOffSetX;
    }
    
    [self.titlScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];

}



#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // calculate button index
    NSInteger index = scrollView.contentOffset.x / screenWidth;
    
    // get title button
    UIButton *btn = self.titlBtns[index];
    
    // set title button
    [self selectedButton:btn];
    
    // setup childviewcontroller
    [self setupChildViewController:index];
    
    
}

// set title scale
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // calculate left and right button index
    NSInteger leftIndex = scrollView.contentOffset.x / screenWidth;
    NSInteger rightIndex = leftIndex + 1;
    
    UIButton *leftBtn = self.titlBtns[leftIndex];
    
    UIButton *rightBtn;
    if (rightIndex < self.titlBtns.count) {
        rightBtn = self.titlBtns[rightIndex];
    }
    
    // calculate scale
    CGFloat scaleRight = scrollView.contentOffset.x / screenWidth;
    scaleRight -= leftIndex;
    
    CGFloat scaleLeft = 1 - scaleRight;
    
    // convert scale 0 ~ 1 to 1 ~ 1.3
//    scaleLeft = scaleLeft * 0.3 + 1;
//    scaleRight = scaleRight * 0.3 + 1;
 
    // set button title scale
    leftBtn.transform = CGAffineTransformMakeScale(scaleLeft * 0.3 + 1, scaleLeft * 0.3 + 1);
    rightBtn.transform = CGAffineTransformMakeScale(scaleRight * 0.3 + 1, scaleRight * 0.3 + 1);

    // set button title color
    UIColor *leftColor = [UIColor colorWithRed:scaleLeft green:0 blue:0 alpha:1.0];
    UIColor *rightColor = [UIColor colorWithRed:scaleRight green:0 blue:0 alpha:1.0];

    [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
    [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];

}



// lazy loading
-(NSMutableArray *) titlBtns
{
    if (_titlBtns == nil) {
        _titlBtns = [NSMutableArray array];
    }
    
    return _titlBtns;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
