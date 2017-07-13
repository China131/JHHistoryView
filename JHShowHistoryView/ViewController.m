//
//  ViewController.m
//  JHShowHistoryView
//
//  Created by 简豪 on 16/7/3.
//  Copyright © 2016年 codingMan. All rights reserved.
//

#import "ViewController.h"
#import "JHCusomHistory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*        添加自定义视图         */
    JHCusomHistory *history = [[JHCusomHistory alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 650) andItems:@[@"熊出没",@"死神来了19",@"钢铁侠0",@"海上钢琴师",@"121",@"最后一只恐龙",@"苍井空",@"假如爱有天意",@"好好先生",@"特种部队",@"生化危机",@"魔兽",@"熊出没",@"来了19",@"钢铁侠",@"海上钢琴师",@"121",@"最后一只恐龙",@"苍井空",@"假如有天意",@"好好生",@"特77种部队",@"生化8机",@"魔兽",@"熊出没",@"死神来了19",@"钢铁侠0",@"海上钢师",@"121",@"最恐龙",@"苍井空",@"假如爱有天==意",@"好先生",@"特种部队",@"生化危机",@"魔兽"] andItemClickBlock:^(NSInteger i) {
        
        
        /*        相应点击事件 i为点击的索引值         */
        
        
    }];
    
    [self.view addSubview:history];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
