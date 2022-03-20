//
//  CCViewController.m
//  CCNestScrollView
//
//  Created by lucc on 03/19/2022.
//  Copyright (c) 2022 lucc. All rights reserved.
//

#import "CCViewController.h"
#import "UIScrollView+CCNest.h"

@interface CCViewController ()<UIScrollViewDelegate>
//父UIScrollView
@property (nonatomic, strong) UIScrollView *fatherscrollView;
//头部区
@property (nonatomic, strong) UIView *headerView;
//子UIScrollView
@property (nonatomic, strong) UIScrollView *childScrollView;
//子UIScrollView2
@property(nonatomic, strong) UIScrollView *childScrollView2;
//横向滚动的scrollView
@property(nonatomic, strong) UIScrollView *horizontalScrollView;
@end

@implementation CCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.fatherscrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.fatherscrollView.delegate = self;
    self.fatherscrollView.bounces = YES;
    self.fatherscrollView.backgroundColor = UIColor.grayColor;
    self.fatherscrollView.contentSize = CGSizeMake(0, self.view.bounds.size.height+200);
    self.fatherscrollView.hookGestureDelegate = YES;
    self.fatherscrollView.shouldRecognizeSimultaneously = YES;
    self.fatherscrollView.role = CCNestScrollRoleFather;
    self.fatherscrollView.canScroll = YES;
    self.fatherscrollView.criticalOffset =  160 - [UIApplication sharedApplication].statusBarFrame.size.height;
    [self.view addSubview:self.fatherscrollView];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    self.headerView.backgroundColor = UIColor.greenColor;
    [self.fatherscrollView addSubview:self.headerView];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"悬浮标题";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 160, self.view.bounds.size.width, 40);
    label.backgroundColor = UIColor.whiteColor;
    [self.headerView addSubview:label];
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height)];
    contentView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height);
    contentView.pagingEnabled = YES;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.bounces = YES;
    contentView.delegate = self;
    self.horizontalScrollView = contentView;
    [self.fatherscrollView addSubview:contentView];
    
    self.childScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.childScrollView.delegate = self;
    self.childScrollView.contentSize = CGSizeMake(0, self.view.bounds.size.height * 1.5);
    self.childScrollView.backgroundColor = UIColor.redColor;
    self.childScrollView.role = CCNestScrollRoleChild;
    self.childScrollView.superSrcollView = self.fatherscrollView;
    self.childScrollView.criticalOffset = 0;
    [contentView addSubview:self.childScrollView];
    self.fatherscrollView.childScrollView = self.childScrollView;

    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont systemFontOfSize:50];
    contentLabel.text = @"子滚动内容";
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.childScrollView addSubview:contentLabel];
    
    self.childScrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.childScrollView2.delegate = self;
    self.childScrollView2.contentSize = CGSizeMake(0, self.view.bounds.size.height * 1.5);
    self.childScrollView2.backgroundColor = UIColor.blueColor;
    self.childScrollView2.role = CCNestScrollRoleChild;
    self.childScrollView2.superSrcollView = self.fatherscrollView;
    self.childScrollView2.criticalOffset = 0;
    [contentView addSubview:self.childScrollView2];

    UILabel *contentLabel2 = [[UILabel alloc] init];
    contentLabel2.font = [UIFont systemFontOfSize:50];
    contentLabel2.text = @"子滚动内容2";
    contentLabel2.textAlignment = NSTextAlignmentCenter;
    contentLabel2.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.childScrollView2 addSubview:contentLabel2];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"内部虽然hook了该方法，这边仍然可以处理其它逻辑，互不干扰");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.horizontalScrollView == scrollView) {
        if (scrollView.contentOffset.x >= self.view.bounds.size.width) {
            self.fatherscrollView.childScrollView = self.childScrollView2;
        } else {
            self.fatherscrollView.childScrollView = self.childScrollView;
        }
    }
}

@end
