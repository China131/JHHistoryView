//
//  JHCustomSearchBar.h
//  CJPubllicLessons
//
//  Created by cjatech-简豪 on 15/12/3.
//  Copyright (c) 2015年 cjatech-简豪. All rights reserved.
//

/*******************************************
 *
 *
 *
 *自定义搜索栏
 *
 *
 *
 ********************************************/


#import <UIKit/UIKit.h>
//自定义搜索栏协议
@protocol JHSearchBarDelegate <NSObject>

@required

//搜索按钮点击响应协议方法
- (void)searchButtonClick:(id)sender;

//搜索框关键字值变化响应协议方法
- (void)textCustomValueChanged:(id)sender;

@end



@interface JHCustomSearchBar : UIView

@property (assign, nonatomic)   id<JHSearchBarDelegate>     delegate;           //遵守自定义搜索栏协议的代理
@property (copy, nonatomic)     NSString                    * placeHolderString;//自定义搜索栏的占位文字
@property (strong, nonatomic)   UITextField                 * searchTextField;  //自定义搜索栏的文本框

//重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate;

@end
