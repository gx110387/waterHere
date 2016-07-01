//
//  IntroView.m
//  DrawPad
//
//  Created by Adam Cooper on 2/4/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "ABCIntroView.h"

@interface ABCIntroView () <UIScrollViewDelegate>
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIPageControl *pageControl;
@property UIView *holeView;
@property UIView *circleView;
@property UIButton *doneButton;

@end

@implementation ABCIntroView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundImageView.image = [UIImage imageNamed:@"Intro_Screen_Background"];
        [self addSubview:backgroundImageView];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.8, self.frame.size.width, 10)];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
        [self addSubview:self.pageControl];
    
        [self createViewOne];
        [self createViewTwo];
        [self createViewThree];
        [self createViewFour];
        
        
        //Done Button
        self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.85, self.frame.size.width*.8, 60)];
        [self.doneButton setTintColor:[UIColor whiteColor]];
        [self.doneButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
        [self.doneButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
        self.doneButton.backgroundColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
        self.doneButton.layer.borderColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000].CGColor;
        [self.doneButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.doneButton.layer.borderWidth =.5;
        self.doneButton.layer.cornerRadius = 15;
        [self addSubview:self.doneButton];
            
        
        self.pageControl.numberOfPages = 4;
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width*4, self.scrollView.frame.size.height);
        
        //This is the starting point of the ScrollView
        CGPoint scrollPoint = CGPointMake(0, 0);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    return self;
}

- (void)onFinishedIntroButtonPressed:(id)sender {
    [self.delegate onDoneButtonPressed];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    
}


-(void)createViewOne{
    
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
    titleLabel.text = [NSString stringWithFormat:@"点滴旅行~"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.1, self.frame.size.width*.8, self.frame.size.width)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"Intro_Screen_One"];
    imageview.layer.cornerRadius = 20;
    [view addSubview:imageview];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"记录旅行中的一点一滴~"];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0];
    descriptionLabel.textColor = [UIColor whiteColor];
  
    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
    [descriptionLabel sizeToFit];
    [view addSubview:descriptionLabel];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.72);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}


-(void)createViewTwo{
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth, 0, originWidth, originHeight)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
    titleLabel.text = [NSString stringWithFormat:@"分享快乐~"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.1, self.frame.size.width*.8, self.frame.size.width)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"Intro_Screen_Two"];
     imageview.layer.cornerRadius = 20;
    [view addSubview:imageview];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"书写旅途中的快乐瞬间~"];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
    [descriptionLabel sizeToFit];
    [view addSubview:descriptionLabel];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.72);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}

-(void)createViewThree{
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth*2, 0, originWidth, originHeight)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
    titleLabel.text = [NSString stringWithFormat:@"热门活动~"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.1, self.frame.size.width*.8, self.frame.size.width)];
  
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"Intro_Screen_Three"];
     imageview.layer.cornerRadius = 20;
    [view addSubview:imageview];
    
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"任性! 玩玩玩~"];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
    [descriptionLabel sizeToFit];
    [view addSubview:descriptionLabel];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.72);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}


-(void)createViewFour{
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth*3, 0, originWidth, originHeight)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.05, self.frame.size.width*.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height*.1);
    titleLabel.text = [NSString stringWithFormat:@"净化心灵~"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.1, self.frame.size.width*.8, self.frame.size.width)];

    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"Intro_Screen_Four"];
     imageview.layer.cornerRadius = 20;
    [view addSubview:imageview];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*.1, self.frame.size.height*.7, self.frame.size.width*.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"感受生命的升华~"];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
    [descriptionLabel sizeToFit];
    [view addSubview:descriptionLabel];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.72);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com