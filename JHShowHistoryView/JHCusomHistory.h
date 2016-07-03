//
//  JHCusomHistory.h
//  CJPubllicLessons
//
//  Created by cjatech-简豪 on 15/12/2.
//  Copyright (c) 2015年 cjatech-简豪. All rights reserved.
//

/*******************************************
 *
 *
 *
 *自定义历史记录横向流布局 基于UICollectionView
 *
 *
 *
 ********************************************/

#import <UIKit/UIKit.h>

typedef void (^itemClickBlock)(NSInteger i);;

@interface JHCusomHistory : UIView

@property (copy, nonatomic) itemClickBlock itemClick;   //Item点击事件的回调block


//初始化方法
- (id)initWithFrame:(CGRect)frame
           andItems:(NSArray *)items
  andItemClickBlock:(itemClickBlock)click;


@end
