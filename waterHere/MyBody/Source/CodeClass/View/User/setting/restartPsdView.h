//
//  restartPsdView.h
//  ZouZou
//
//  Created by lanou3g on 15/10/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol restartPasViewDelegate <NSObject>

-(void)getData;

@end


@interface restartPsdView : UIView

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *passLabel;
@property(nonatomic,strong)UILabel *passagainLabel;
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *passTextField;
@property(nonatomic,strong)UITextField *passaginTextField;
@property(nonatomic,strong)UIButton *makeSubmit;

@property(nonatomic,weak)id<restartPasViewDelegate>delegate;
@end
