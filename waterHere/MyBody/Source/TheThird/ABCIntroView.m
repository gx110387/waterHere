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
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, MainScreenHeight-G_Iphone6(34+44+18+10), self.frame.size.width, 10)];
        self.pageControl.currentPageIndicatorTintColor = CustomerColorOfAlpha(182, 193, 201, 1) ;
        [self addSubview:self.pageControl];
    
     
     
        [self createViewOne:@"Intro_Screen_One" content:@"记录旅行中的一点一滴~" width:0];
        [self createViewOne:@"Intro_Screen_Two" content:@"书写旅途中的快乐瞬间~" width:MainScreenWidth];
         [self createViewOne:@"Intro_Screen_Three" content:@"任性! 玩玩玩~" width:MainScreenWidth*2];
         [self createViewOne:@"Intro_Screen_Four" content:@"感受生命的升华~" width:MainScreenWidth*3];
        
        
        
        //Done Button
        self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(G_Iphone6(50), MainScreenHeight - G_Iphone6(44+34),MainScreenWidth - G_Iphone6(100),  G_Iphone6(44))];
        [self.doneButton setTintColor:[UIColor whiteColor]];
        [self.doneButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
        [self.doneButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
        self.doneButton.backgroundColor = CustomerColorOfAlpha(85, 172, 238, 1);
        self.doneButton.layer.borderColor = CustomerColorOfAlpha(85, 172, 238, 1).CGColor;
        [self.doneButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.doneButton.layer.borderWidth =.5;
        self.doneButton.layer.cornerRadius = G_Iphone6(44)/2;
        self.doneButton.layer.masksToBounds = YES;
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


-(void)createViewOne:(NSString *)ImageName content:(NSString *)content width:(CGFloat)width{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width, 0, MainScreenWidth, MainScreenHeight)];
//    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(G_Iphone6(48), G_Iphone6(96), MainScreenWidth - G_Iphone6(48*2), G_Iphone6(400))];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:ImageName];
    imageview.layer.cornerRadius = 20;
    [view addSubview:imageview];

    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageview.frame)+G_Iphone6(10), MainScreenWidth, G_Iphone6(30))];
    descriptionLabel.text = content;
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0];
    descriptionLabel.textColor = [UIColor whiteColor];
  
    descriptionLabel.textAlignment =  NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
//    [descriptionLabel sizeToFit];
    [view addSubview:descriptionLabel];
//    
//    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height*.72);
//    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}






@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com