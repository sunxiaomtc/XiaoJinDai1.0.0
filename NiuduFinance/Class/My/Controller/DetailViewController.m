//
//  DetailViewController.m
//  NiuduFinance
//
//  Created by 123 on 17/8/4.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "DetailViewController.h"
#import "MingXiTableViewCell.h"
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView * dhView;
@property (nonatomic, strong) UILabel * dhTitleLabe;
@property (nonatomic, strong) UIButton * imageVie;
@property (nonatomic, strong) UIImageView * bgImageVie;
@property (nonatomic, strong) UILabel * fljyeLabel;
@property (nonatomic, strong) UILabel * fljyeNum;

@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,strong)NSMutableArray * fuLiAry;
@property (nonatomic,strong)NSMutableArray * timeAry;

@property (nonatomic,strong)NSMutableArray * arrayall;
@property (nonatomic,strong)NSMutableArray * sectionArray;
@end

@implementation DetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setTableViewInfo];
    [self getWelfarePayments];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _start = 0;
    _limit = 1000;
    _fuLiAry = [NSMutableArray array];
    _timeAry = [NSMutableArray array];
    _arrayall=[[NSMutableArray alloc]init];
    _sectionArray=[[NSMutableArray alloc]init];
    
    _dhView = [UIView new];
    [_dhView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_dhView];
    [_dhView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 157));
    }];
    
    _bgImageVie = [UIImageView new];
    UIImage * image1 = [UIImage imageNamed:@"矩形-11"];
    _bgImageVie.image = image1;
    [self.dhView addSubview:_bgImageVie];
    [_bgImageVie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 157));
    }];
    
    _dhTitleLabe = [UILabel new];
    [_dhTitleLabe setText:@"福利金"];
    [_dhTitleLabe setTextColor:[UIColor whiteColor]];
    [_dhTitleLabe setFont:[UIFont systemFontOfSize:17]];
    [self.bgImageVie addSubview:_dhTitleLabe];
    [_dhTitleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(34);
        make.height.mas_equalTo(16);
    }];
    
    _imageVie = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imageVie setImage:[UIImage imageNamed:@"nav_back_normal.png"] forState:UIControlStateNormal];
    [_imageVie addTarget:self action:@selector(labelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.dhView addSubview:_imageVie];
    [_imageVie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dhTitleLabe.mas_centerY);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
//    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
//    [_imageVie addGestureRecognizer:labelTapGestureRecognizer];
//    _imageVie.userInteractionEnabled = YES;
    
    _fljyeLabel = [UILabel new];
    [_fljyeLabel setText:@"福利金余额(元)"];
    [_fljyeLabel setFont:[UIFont systemFontOfSize:12]];
    [_fljyeLabel setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.bgImageVie addSubview:_fljyeLabel];
    [_fljyeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(_dhTitleLabe.mas_bottom).with.offset(39);
        make.height.mas_equalTo(12);
    }];
    
    _fljyeNum = [UILabel new];
    [_fljyeNum setText:@"0.00"];
    [_fljyeNum setFont:[UIFont systemFontOfSize:26]];
    [_fljyeNum setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.bgImageVie addSubview:_fljyeNum];
    [_fljyeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(_fljyeLabel.mas_bottom).with.offset(13);
        make.height.mas_equalTo(20);
    }];
    
    [self getFundAccountData];
}
- (void)labelClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//我的福利金
- (void)getWelfarePayments
{
    
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/getUserAssetInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _fljyeNum.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"welfareFund"] floatValue]];
            
        }
        [self.tableView reloadData];
    }];
}

- (void)getFundAccountData
{
    
    [self.httpUtil requestDic4MethodNam:@"v2/accept/account/findAllFundSerials" parameters:@{@"limit":@(_limit),@"start":@(_start),@"type":@(1)} result:^(id dic, int status, NSString *msg) {
        
        NSLog(@"%d",status);
        NSLog(@"%@",dic);
        //        [self.data addObjectsFromArray:dic];
        if (status == 0) {
//            [MBProgressHUD showMessag:msg toView:self.view];
            
            if (_fuLiAry.count == 0) {
//                self.hideNoNetWork = NO;
//                self.noNetWorkView.top = 53;
//                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
//                self.noNetWorkView.width = SCREEN_WIDTH;
            }
        }else{
            [_fuLiAry removeAllObjects];
            [_fuLiAry addObjectsFromArray:dic];
            NSMutableArray *arrayss=[[NSMutableArray alloc]init];
            [_arrayall removeAllObjects];
            
            for (NSDictionary * dict in _fuLiAry) {
                NSString * timeStampString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"creationdate"]];
                NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
                NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
                [objDateformat setDateFormat:@"yyyy年MM月"];
                NSLog(@"%@",  [objDateformat stringFromDate: date]);
                NSString * string = [objDateformat stringFromDate:date];
                NSString * str = [string substringWithRange:NSMakeRange(0, 8)];
                
                //对时间进行分组，相同的时间放到相同的分组
                int counts=0;
                for (int i=0; i<_timeAry.count; i++) {
                    if ([[_timeAry objectAtIndex:i]isEqualToString:str]) {
                        counts++;
                    }
                    else{
                        
                    }
                }
                if (counts>0) {
                    [arrayss addObject:dict];
                }
                else
                {
                    [_arrayall addObject:arrayss];
                    arrayss=[[NSMutableArray alloc]init];
                    
                    [arrayss addObject:dict];
                }
                
                int sec=0;
                for (int i=0; i<_sectionArray.count; i++) {
                    if ([[_sectionArray objectAtIndex:i]isEqualToString:str]) {
                        sec++;
                    }
                    else
                    {
                        
                    }
                }
                if (sec==0) {
                    [_sectionArray addObject:str];
                }
                
                //                if (_timeAry.count==0) {
                //                    [arrayss addObject:dict];
                //                }
                
                [_timeAry addObject:str];
                
                
                //                [_timeAry addObject:[dict objectForKey:@"creationdate"]];
            }
            [_arrayall addObject:arrayss];
            NSLog(@"%@",_timeAry);
            NSLog(@"%@,,,,,,,",_arrayall);
            
//            [_tableView.mj_footer resetNoMoreData];
            
        }
        
        [_tableView reloadData];
        
    }];
    
}


- (void)setTableViewInfo
{
//    [self setupRefreshWithTableView:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"MingXiTableViewCell" bundle:nil] forCellReuseIdentifier:@"MingXiTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_arrayall.count == 0) {
        return 0;
    }
    return _arrayall.count-1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_arrayall.count == 0) {
        return 1;
    }
    return [[_arrayall objectAtIndex:section+1]count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel * iamgeLabel = [[UILabel alloc] init];
    [iamgeLabel setTextColor:[UIColor colorWithHexString:@"#0096FF"]];
    iamgeLabel.layer.cornerRadius = 5.0f;
    iamgeLabel.clipsToBounds = YES;
    [iamgeLabel setBackgroundColor:[UIColor colorWithHexString:@"#0096FF"]];
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH-20, 44)];
    if (_sectionArray.count == 0) {
        return view;
    }else
    title.text=[_sectionArray objectAtIndex:section];
    iamgeLabel.text = [_sectionArray objectAtIndex:section];
    [view addSubview:title];
    [view addSubview:iamgeLabel];
    [iamgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//        static NSString *CellIdentifier = @"Cell";
//        UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        self.tableView.showsVerticalScrollIndicator = NO;
    
    static NSString *cellID = @"MingXiTableViewCell";
    MingXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MingXiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSLog(@"%ld",indexPath.row);
    //    if (indexPath.row == 0) {
    //        cell.titleLabel.text = @"123";
    //    }else
    //    if (indexPath.row<_fuLiAry.count) {
    //        [cell setFundAccountDic:_fuLiAry[indexPath.row-1]];
    //    }
    if (_arrayall.count == 0)
    {
        return cell;
    }else
    
    [cell setFundAccountDic:[[_arrayall objectAtIndex:indexPath.section+1]objectAtIndex:indexPath.row]];
    return cell;
}


@end
