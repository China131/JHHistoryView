//
//  JHCusomHistory.m
//  CJPubllicLessons
//
//  Created by cjatech-简豪 on 15/12/2.
//  Copyright (c) 2015年 cjatech-简豪. All rights reserved.
//

#import "JHCusomHistory.h"
#import "JHCustomFlow.h"
#import "JHCell.h"
#import "JHHeader.h"
@interface JHCusomHistory ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView    *_collectionView;   //流布局视图
    NSMutableArray      *_dataArr;          //流布局数据源
}

@end

@implementation JHCusomHistory


/**
 *  初始化方法
 *
 *  @param frame 流布局frame
 *  @param items 外部导入的数据源
 *  @param click item点击响应回调block
 *
 *  @return 自定义流布局对象
 */
-(id)initWithFrame:(CGRect)frame andItems:(NSArray *)items andItemClickBlock:(itemClickBlock)click{
    
    if (self == [super initWithFrame:frame]) {
        _dataArr                    = [NSMutableArray arrayWithArray:items];
        _itemClick                  = click;
        self.userInteractionEnabled = YES;
        [self configBaseView];
    }
    return self;
}


/**
 *  搭建基本视图
 */
- (void)configBaseView{
    self.backgroundColor            = [UIColor whiteColor];
    
    /* 自定义布局格式 */
    JHCustomFlow *flow              = [[JHCustomFlow alloc] init];
    flow.minimumLineSpacing         = 5;
    flow.minimumInteritemSpacing    = 5;
    
    /* 初始化流布局视图 */
    _collectionView                 = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
    _collectionView.dataSource      = self;
    _collectionView.delegate        = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    /* 提前注册流布局item */
    [_collectionView registerClass:[JHCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[JHHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}


#pragma mark -------------> UICollectionView协议方法
/**
 *  自定义流布局item个数 要比数据源的个数多1 需要一个作为清除历史记录的行
 *
 *  @param collectionView 当前流布局视图
 *  @param section        nil
 *
 *  @return 自定义流布局item的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataArr[section] count];
}


/**
 *  第index项的item的size大小
 *
 *  @param collectionView       当前流布局视图
 *  @param collectionViewLayout nil
 *  @param indexPath            item索引
 *
 *  @return size大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row == _dataArr.count) {
//        return CGSizeMake(self.frame.size.width, 40);
//    }
    
    NSString *str      = _dataArr[indexPath.section][indexPath.row];
    /* 根据每一项的字符串确定每一项的size */
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    CGSize size        = [str boundingRectWithSize:CGSizeMake(self.frame.size.width, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    size.height        = 40;
    size.width         += 10;
    return size;
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    [collectionView.collectionViewLayout invalidateLayout];
    return _dataArr.count;
}


/**
 *  流布局的边界距离 上下左右
 *
 *
 *
 *  @return 边界距离值
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(3, 5, 3, 3);
}


/**
 *  第index项的item视图
 *
 *  @param collectionView 当前流布局
 *  @param indexPath      索引
 *
 *  @return               item视图
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JHCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    for (UIView *vie in cell.contentView.subviews) {
//        if ([vie isKindOfClass:[UILabel class]]) {
//            [vie removeFromSuperview];
//        }
//    }
//    if (indexPath.row == _dataArr.count) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
//        /* 判断最后一个item的内容 如果没有历史记录 内容就为暂无历史记录  否则为清除历史记录 */
//        label.text = (_dataArr.count==0?(@"暂无历史记录"):(@"清除历史记录"));
//        label.textAlignment = NSTextAlignmentCenter;
//        [cell.contentView addSubview:label];
//        return cell;
//    }
    NSString *str                       = _dataArr[indexPath.section][indexPath.row];
    NSDictionary *dict                  = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    CGSize size                         = [str boundingRectWithSize:CGSizeMake(self.frame.size.width, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    UILabel *label                      =cell.textLabel;
    label.frame = cell.bounds;
    label.text                          = str;
    label.font                          = [UIFont systemFontOfSize:18];
    cell.contentView.layer.cornerRadius = 5;
    cell.contentView.clipsToBounds      = YES;
    cell.contentView.backgroundColor    = [UIColor colorWithRed:arc4random()%250/256.0 + 0.3 green:arc4random()%255/256.0+0.2  blue:arc4random()%250/255.0 + 0.1 alpha:0.7];
    label.layer.borderColor             = [UIColor whiteColor].CGColor;
    [cell.contentView addSubview:label];
//    label.center                        = cell.contentView.center;
    return cell;
}



/**
 *  当前点击的item的响应方法
 *
 *  @param collectionView 当前流布局
 *  @param indexPath      索引
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    /* 响应回调block */
    _itemClick(indexPath.row);
}




-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(100, 50);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    if (!view) {
        view = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    }
    view.backgroundColor = [UIColor greenColor];
    if (kind == UICollectionElementKindSectionHeader) {
        return view;
    }
    
    return nil;
    
}















@end
