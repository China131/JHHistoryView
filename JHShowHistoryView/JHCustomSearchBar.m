//
//  JHCustomSearchBar.m
//  CJPubllicLessons
//
//  Created by cjatech-简豪 on 15/12/3.
//  Copyright (c) 2015年 cjatech-简豪. All rights reserved.
//

#import "JHCustomSearchBar.h"
#define SELF_WIDTH self.frame.size.width
@interface JHCustomSearchBar()<UITextFieldDelegate>
{
//    UITextField * _searchTextField;
    UIButton *_searchBtn;
    UIButton *_rightViewBtn;
}

@end

@implementation JHCustomSearchBar

/**
 *  初始化方法
 *
 *  @param frame    自定义搜索栏frame
 *  @param delegate 代理
 *
 *  @return 自定义搜索栏对象
 */
-(instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate{
    if (self == [super initWithFrame:frame]) {
        _delegate = delegate;
        [self configBaseView];
    }
    return self;
}


/**
 *  基本界面搭建
 */
- (void)configBaseView{
    /* 文本框 */
    _searchTextField                   = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SELF_WIDTH/3*2, self.frame.size.height)];
    _searchTextField.delegate          = self;
    _searchTextField.layer.borderWidth = 1;
    _searchTextField.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:_searchTextField];
    
    /* 文本框右侧视图 */
    _rightViewBtn                      = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightViewBtn.frame                = CGRectMake(0, 0, 20, 20);
    [_rightViewBtn setBackgroundColor:[UIColor blueColor]];
    [_rightViewBtn setTitle:@"1" forState:UIControlStateNormal];
    [_rightViewBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_rightViewBtn];
    _searchTextField.rightView         = _rightViewBtn;
    _searchTextField.rightViewMode     = UITextFieldViewModeWhileEditing;

    /* 搜索按钮 */
    _searchBtn                         = [UIButton buttonWithType:UIButtonTypeSystem];
    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(textFieldShouldReturn:) forControlEvents:UIControlEventTouchUpInside];
    _searchBtn.frame                   = CGRectMake(CGRectGetMaxX(_searchTextField.frame)+3, 0, SELF_WIDTH/3-10, self.frame.size.height);
    [self addSubview:_searchBtn];
    _searchBtn.layer.borderWidth       = 1;
    _searchBtn.layer.borderColor       = [UIColor blackColor].CGColor;
    
    /* 注册接收文本框值变化的通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

/**
 *  文本框右侧视图点击事件 默认为清空按钮
 */
- (void)clearBtnClick{
    _searchTextField.text = nil;
    [self textFieldValueChanged:nil];
}

/**
 *  接收到通知中心的文本框值变化通知时的响应事件
 *
 *  @param textField 通知信息
 */
- (void)textFieldValueChanged:(NSNotification *)textField{
    if (_delegate) {
        [_delegate textCustomValueChanged:_searchTextField];
    }
}


/**
 *  设置文本框的占位文字
 *
 *  @param placeHolderString 占位文字
 */
-(void)setPlaceHolderString:(NSString *)placeHolderString{
    _placeHolderString           = placeHolderString;
    _searchTextField.placeholder = _placeHolderString;
}

/**
 *  文本框协议方法 点击键盘的return按键时的响应方法
 *
 *  @param textField 当前文本框
 *
 *
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_delegate) {
        [_delegate searchButtonClick:_searchTextField];
    }
    [_searchTextField resignFirstResponder];
    return YES;
}


/**
 *  析构函数  在销毁本页面时移除通知中心接受者
 */
-(void)dealloc{    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
