//
//  JZIntroViewController.m
//  GitHubContributions
//
//  Created by Justin Fincher on 2017/1/4.
//  Copyright © 2017年 JustZht. All rights reserved.
//

#import "JZIntroViewController.h"
#import <Masonry/Masonry.h>
#import "JZHeader.h"
#import <Shimmer/FBShimmeringView.h>

#define INTRO_TOTAL_PAGE_NUM 9

@interface JZIntroViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIVisualEffectView *effectContainerView;
@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *iconLabel;
@property (nonatomic,strong) FBShimmeringView *setupLabelContainerView;
@property (nonatomic,strong) UILabel *setupLabel;

@property (nonatomic,strong) UIImageView *githubIdImageView;
@property (nonatomic,strong) UILabel *githubIdFindLabel;
@property (nonatomic,strong) UILabel *githubIdInputNoticeLabel;
@property (nonatomic,strong) UITextField *githubIdInputField;

@property (nonatomic,strong) UIImageView *phoneBodyImageView;
@property (nonatomic,strong) UIView *phoneScreenMaskView;

@property (nonatomic,strong) UILabel *phoneScreenTodayUnAddedLabel;
@property (nonatomic,strong) UILabel *phoneScreenTodayAddingLabel;
@property (nonatomic,strong) UILabel *phoneScreenTodayAddedLabel;

@property (nonatomic,strong) UIImageView *phoneScreenTodayUnAddedImageView;
@property (nonatomic,strong) UIImageView *phoneScreenTodayAddingImageView;
@property (nonatomic,strong) UIImageView *phoneScreenTodayAddedImageView;



@end

@implementation JZIntroViewController

- (NSUInteger)numberOfPages
{
    return INTRO_TOTAL_PAGE_NUM;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self configureAnimations];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView)
    {
        static NSInteger previousPage = 0;
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        if (previousPage != page)
        {
            self.pageControl.currentPage = page;
            previousPage = page;
        }
    }
}

- (void)configureViews
{
    self.scrollView.delegate = self;
    
    
    
    self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_icon"]];
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.25);
        make.height.mas_equalTo(self.contentView.mas_height).multipliedBy(0.2);
        make.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.2);
    }];
    [self keepView:self.iconImageView onPages:@[@(0)] atTimes:@[@(0)]];
    
    self.iconLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.iconLabel.text = @"CONTRIBUTIONS";
    self.iconLabel.minimumScaleFactor = 0.1;
    self.iconLabel.adjustsFontSizeToFitWidth = YES;
    self.iconLabel.font = [UIFont fontWithName:@"Avenir-Light" size:50];
    self.iconLabel.textAlignment = NSTextAlignmentCenter;
    self.iconLabel.textColor = UIColorFromRGB(0x676767);
    [self.contentView addSubview:self.iconLabel];
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.contentView);
         make.top.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.45);
         make.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.22);
     }];
    [self keepView:self.iconLabel onPages:@[@(0)] withAttribute:IFTTTHorizontalPositionAttributeCenterX];
    
    self.setupLabelContainerView = [[FBShimmeringView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.setupLabelContainerView];
    [self.setupLabelContainerView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.75);
        make.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.12);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.9);
    }];
    self.setupLabelContainerView.shimmering = YES;
    [self keepView:self.setupLabelContainerView onPages:@[@(0)] withAttribute:IFTTTHorizontalPositionAttributeCenterX];
    
    self.setupLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.setupLabel.text = @"SETUP";
    self.setupLabel.minimumScaleFactor = 0.1;
    self.setupLabel.adjustsFontSizeToFitWidth = YES;
    self.setupLabel.font = [UIFont fontWithName:@"Avenir-Light" size:50];
    self.setupLabel.textAlignment = NSTextAlignmentCenter;
    self.setupLabel.textColor = UIColorFromRGB(0x676767);
    [self.setupLabelContainerView addSubview:self.setupLabel];
    [self.setupLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.center.mas_equalTo(self.setupLabelContainerView);
    }];
    self.setupLabelContainerView.contentView = self.setupLabel;
    self.setupLabelContainerView.shimmeringBeginFadeDuration = 0.3;
    self.setupLabelContainerView.shimmeringSpeed = 50;
    self.setupLabelContainerView.shimmeringOpacity = 0.3;
    self.setupLabelContainerView.shimmeringAnimationOpacity = 1.0f;

    
    self.githubIdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_github_id_screenshot"]];
    [self.contentView addSubview:self.githubIdImageView];
    [self.githubIdImageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.contentView.mas_height).multipliedBy(0.5);
        make.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    [self keepView:self.githubIdImageView onPages:@[@(1)] withAttribute:IFTTTHorizontalPositionAttributeCenterX];
    
    self.githubIdFindLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.githubIdFindLabel];
    self.githubIdFindLabel.font = [UIFont fontWithName:@"Avenir-Light" size:50];
    self.githubIdFindLabel.numberOfLines = 3;
    self.githubIdFindLabel.adjustsFontSizeToFitWidth = YES;
    self.githubIdFindLabel.minimumScaleFactor = 0.1;
    self.githubIdFindLabel.textColor = UIColorFromRGB(0x676767);
    self.githubIdFindLabel.textAlignment = NSTextAlignmentCenter;
    self.githubIdFindLabel.text = @"DON'T KNOW YOUR GITHUB ID? GO TO YOUR GITHUB PROFILE AND FIND YOUR ID BY URL";
    [self.githubIdFindLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.contentView);
         make.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.45);
         make.top.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.4);
         make.bottom.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.55);
     }];
    [self keepView:self.githubIdFindLabel onPages:@[@(1)] withAttribute:IFTTTHorizontalPositionAttributeCenterX];

    self.githubIdInputNoticeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.githubIdInputNoticeLabel];
    self.githubIdInputNoticeLabel.font = [UIFont fontWithName:@"Avenir-Light" size:50];
    self.githubIdInputNoticeLabel.adjustsFontSizeToFitWidth = YES;
    self.githubIdInputNoticeLabel.textColor = UIColorFromRGB(0x676767);
    self.githubIdInputNoticeLabel.textAlignment = NSTextAlignmentCenter;
    self.githubIdInputNoticeLabel.text = @"INPUT YOUR GITHUB ID";
    [self.githubIdInputNoticeLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.contentView);
         make.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.35);
         make.top.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.05);
         make.bottom.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.15);
     }];
    [self keepView:self.githubIdInputNoticeLabel onPages:@[@(1)] withAttribute:IFTTTHorizontalPositionAttributeCenterX];

    self.githubIdInputField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.githubIdInputField];
    self.githubIdInputField.font = [UIFont fontWithName:@"Avenir-Medium" size:30];
    self.githubIdInputField.adjustsFontSizeToFitWidth = YES;
    self.githubIdInputField.minimumFontSize = 0.02;
    self.githubIdInputField.textColor = UIColorFromRGB(0x272727);
    self.githubIdInputField.placeholder = @"YOUR ID";
    self.githubIdInputField.textAlignment = NSTextAlignmentCenter;
    [self.githubIdInputField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.contentView);
         make.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.35);
         make.top.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.20);
         make.bottom.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.25);
     }];
    [self keepView:self.githubIdInputField onPages:@[@(1)] withAttribute:IFTTTHorizontalPositionAttributeCenterX];
    
    
    self.phoneBodyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_iphone_screen_blend"]];
    [self.contentView addSubview:self.phoneBodyImageView];
    [self.phoneBodyImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.contentView);
         make.height.mas_equalTo(self.contentView.mas_height).multipliedBy(0.9);
         make.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.5623*0.9);
         make.top.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.4);
     }];
    [self keepView:self.phoneBodyImageView onPages:@[@(2),@(3)] withAttribute:IFTTTHorizontalPositionAttributeCenterX];
    
    self.phoneScreenMaskView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.phoneBodyImageView addSubview:self.phoneScreenMaskView];
    [self.phoneScreenMaskView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.center.mas_equalTo(self.phoneBodyImageView);
        make.size.mas_equalTo(self.phoneBodyImageView).multipliedBy(0.7136);
    }];
    self.phoneScreenMaskView.backgroundColor = [UIColor blackColor];
    self.phoneScreenMaskView.layer.masksToBounds = YES;
    
    
    self.phoneScreenTodayUnAddedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phoneScreenTodayUnAdded"]];
    [self.phoneScreenMaskView addSubview:self.phoneScreenTodayUnAddedImageView];
    [self.phoneScreenTodayUnAddedImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.mas_equalTo(self.phoneScreenMaskView);
         make.size.mas_equalTo(self.phoneScreenMaskView);
     }];
    self.phoneScreenTodayUnAddedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.phoneScreenTodayUnAddedLabel];
    self.phoneScreenTodayUnAddedLabel.font = [UIFont fontWithName:@"Avenir-Light" size:50];
    self.phoneScreenTodayUnAddedLabel.adjustsFontSizeToFitWidth = YES;
    self.phoneScreenTodayUnAddedLabel.minimumScaleFactor = 0.02;
    self.phoneScreenTodayUnAddedLabel.textColor = UIColorFromRGB(0x272727);
    self.phoneScreenTodayUnAddedLabel.text = @"AFTER SETTING GITHUB ID, NAVIGATE TO TODAY VIEW AND PRESS 'EDIT'";
    self.phoneScreenTodayUnAddedLabel.textAlignment = NSTextAlignmentCenter;
    self.phoneScreenTodayUnAddedLabel.numberOfLines = 0;
    [self.phoneScreenTodayUnAddedLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.contentView);
         make.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.35);
         make.top.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.1);
         make.bottom.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.4);
     }];
    [self keepView:self.phoneScreenTodayUnAddedLabel onPages:@[@(2)] withAttribute:IFTTTHorizontalPositionAttributeCenterX];
    
    
    self.phoneScreenTodayAddingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phoneScreenTodayAdding"]];
    [self.phoneScreenMaskView addSubview:self.phoneScreenTodayAddingImageView];
    [self.phoneScreenTodayAddingImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.phoneScreenMaskView);
         make.size.mas_equalTo(self.phoneScreenMaskView);
     }];
    NSLayoutConstraint *phoneScreenTodayAddingImageViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.phoneScreenTodayAddingImageView
                                                                                                     attribute:NSLayoutAttributeCenterY
                                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                                        toItem:self.phoneScreenMaskView
                                                                                                     attribute:NSLayoutAttributeTop
                                                                                                    multiplier:1.0f constant:0.f];
    [self.phoneScreenMaskView addConstraint:phoneScreenTodayAddingImageViewTopConstraint];
    IFTTTConstraintMultiplierAnimation *phoneScreenTodayAddingImageViewTopConstraintMultiplierAnimation = [IFTTTConstraintMultiplierAnimation animationWithSuperview:self.phoneScreenMaskView
                                                                                                                      constraint:phoneScreenTodayAddingImageViewTopConstraint
                                                                                                                       attribute:IFTTTLayoutAttributeHeight
                                                                                                                   referenceView:self.phoneScreenMaskView];
    [phoneScreenTodayAddingImageViewTopConstraintMultiplierAnimation addKeyframeForTime:2 multiplier:2.f withEasingFunction:IFTTTEasingFunctionEaseOutCubic];
    [phoneScreenTodayAddingImageViewTopConstraintMultiplierAnimation addKeyframeForTime:3 multiplier:0.5f];
    [self.animator addAnimation:phoneScreenTodayAddingImageViewTopConstraintMultiplierAnimation];
    
    [self.contentView addSubview:self.phoneScreenTodayUnAddedLabel];
    self.phoneScreenTodayUnAddedLabel.font = [UIFont fontWithName:@"Avenir-Light" size:50];
    self.phoneScreenTodayUnAddedLabel.adjustsFontSizeToFitWidth = YES;
    self.phoneScreenTodayUnAddedLabel.minimumScaleFactor = 0.02;
    self.phoneScreenTodayUnAddedLabel.textColor = UIColorFromRGB(0x272727);
    self.phoneScreenTodayUnAddedLabel.text = @"AFTER SETTING GITHUB ID, NAVIGATE TO TODAY VIEW AND PRESS 'EDIT'";
    self.phoneScreenTodayUnAddedLabel.textAlignment = NSTextAlignmentCenter;
    self.phoneScreenTodayUnAddedLabel.numberOfLines = 0;
    [self.phoneScreenTodayUnAddedLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.contentView);
         make.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.35);
         make.top.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.1);
         make.bottom.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.4);
     }];
    [self keepView:self.phoneScreenTodayUnAddedLabel onPages:@[@(2)] withAttribute:IFTTTHorizontalPositionAttributeCenterX];
    
    self.phoneScreenTodayAddingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.phoneScreenTodayAddingLabel];
    self.phoneScreenTodayAddingLabel.font = [UIFont fontWithName:@"Avenir-Light" size:50];
    self.phoneScreenTodayAddingLabel.adjustsFontSizeToFitWidth = YES;
    self.phoneScreenTodayAddingLabel.minimumScaleFactor = 0.02;
    self.phoneScreenTodayAddingLabel.textColor = UIColorFromRGB(0x272727);
    self.phoneScreenTodayAddingLabel.text = @"ADD 'GITHUB CONTRIBUTIONS' TO WIDGET LIST BY TAPPING ADD SYMBOL";
    self.phoneScreenTodayAddingLabel.textAlignment = NSTextAlignmentCenter;
    self.phoneScreenTodayAddingLabel.numberOfLines = 0;
    [self.phoneScreenTodayAddingLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.contentView);
         make.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.35);
         make.top.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.1);
         make.bottom.mas_equalTo(self.contentView.mas_bottom).multipliedBy(0.4);
     }];
    [self keepView:self.phoneScreenTodayAddingLabel onPages:@[@(3)] withAttribute:IFTTTHorizontalPositionAttributeCenterX];
    
    
    self.effectContainerView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [self.contentView addSubview:self.effectContainerView];
    [self.effectContainerView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(self.contentView.mas_bottom);
         make.centerX.mas_equalTo(self.contentView);
         make.width.mas_equalTo(self.view.mas_width);
         make.height.mas_equalTo(self.contentView.mas_height).multipliedBy(0.1);
     }];
    [self keepView:self.effectContainerView onPages:@[@(0),@(1),@(2),@(3),@(4),@(5)] withAttribute:IFTTTHorizontalPositionAttributeCenterX];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    [self.effectContainerView addSubview:self.pageControl];
    self.pageControl.numberOfPages = INTRO_TOTAL_PAGE_NUM;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.mas_equalTo(self.effectContainerView);
     }];
}

- (void)configureAnimations
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end