//
//  HYXiaLaView.m
//  NiuduFinance
//
//  Created by Apple on 2017/12/4.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "HYXiaLaView.h"

@implementation HYXiaLaView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //[self setUI];
    }
    return self;
}

//设置UI
-(void)setUI
{
    UIButton *mcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mcBtn.frame = CGRectMake(0, 50, self.frame.size.width, self.frame.size.height - 50);
    mcBtn.backgroundColor = [UIColor blackColor];
    mcBtn.alpha = 0.5;
    [mcBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    self.mcBtn = mcBtn;
    [self addSubview:mcBtn];
}

-(void)setTitleArr:(NSArray *)titleArr
{
    _titleArr = titleArr;
    for(int i = 0; i < titleArr.count;i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        CGFloat x = SCREEN_WIDTH * (i / titleArr.count);
//        NSLog(@"%f",x);
        btn.frame = CGRectMake((SCREEN_WIDTH * i) / titleArr.count, 0, SCREEN_WIDTH / titleArr.count, 50);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:COLOR(55, 55, 55, 1) forState:UIControlStateNormal];
        [btn setTitleColor:COLOR(31, 233, 211, 1) forState:UIControlStateSelected];
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn
{
    if(self.mcBtn)
    {
        if(btn.selected == NO)
        {
            for(int i = 0; i < self.titleArr.count;i ++)
            {
                UIButton *btn = (UIButton *)[self viewWithTag:1000 + i];
                if(btn.selected == YES)
                {
                    btn.selected = NO;
                }
            }
            btn.selected = YES;
            NSDictionary *dic = self.dataArr[btn.tag - 1000];
            NSInteger num = [dic[@"num"] integerValue];
            CGFloat high = [dic[@"high"] floatValue];
            NSArray *arr = dic[@"data"];
            [self reloadTable:arr CellNum:num CellHigh:high];
        }else
        {
            [self cancelClick:nil];
        }
    }else
    {
        btn.selected = YES;
        [self setUI];
        NSDictionary *dic = self.dataArr[btn.tag - 1000];
        NSInteger num = [dic[@"num"] integerValue];
        CGFloat high = [dic[@"high"] floatValue];
        NSArray *arr = dic[@"data"];
        [self giveModelData:arr cellNum:num cellHigh:high];
    }
}

-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
}

-(void)giveModelData:(NSArray *)model cellNum:(NSInteger)num cellHigh:(CGFloat)high
{
    self.resultArr = model;
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = high;
    self.mainTV = tableView;
    [self addSubview:tableView];
    
    [UIView animateWithDuration:0.3 animations:^{
        tableView.frame = CGRectMake(0, 50, SCREEN_WIDTH, high * num);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)reloadTable:(NSArray *)model CellNum:(NSInteger)num CellHigh:(CGFloat)high
{
    self.resultArr = model;
    [UIView animateWithDuration:0.3 animations:^{
        self.mainTV.frame = CGRectMake(0, 50, SCREEN_WIDTH, high * num);
    } completion:^(BOOL finished) {
        
    }];
    [self.mainTV reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = self.resultArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cancelClick:nil];
    NSLog(@"%@",self.resultArr[indexPath.row]);
}

-(void)cancelClick:(UIButton *)btn
{
    for(int i = 0; i < self.titleArr.count;i ++)
    {
        UIButton *btn = (UIButton *)[self viewWithTag:1000 + i];
        if(btn.selected == YES)
        {
            btn.selected = NO;
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.mainTV.frame = CGRectMake(0, 50, SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        [self.mcBtn removeFromSuperview];
        [self.mainTV removeFromSuperview];
    }];
}

-(NSArray *)resultArr
{
    if(_resultArr == nil)
    {
        _resultArr = [NSArray array];
    }
    return _resultArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
