//
//  CWNumberKeyboard.m
//  CWNumberKeyboardDemo
//
//  Created by william on 16/3/19.
//  Copyright © 2016年 陈大威. All rights reserved.
//

#define CUSTOM_KEYBOARD_HEIGHT   310           //自定义键盘高度
#define RGBCOLORVA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#import "CWNumberKeyboard.h"
#import "NetWorkingUtil.h"
#import "XShareProjectController.h"

@interface CWNumberKeyboard()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mTextNumberFiled;
@property (strong, nonatomic) IBOutlet UIView *mKeyboardView;
@property (weak, nonatomic) IBOutlet UIButton *mDeleteBtn;
//@property (weak, nonatomic) IBOutlet UIButton *mResignBtn;
@property (nonatomic , copy) numberKeyboardBlock block;
@property (nonatomic,strong)NSDictionary * welfDic;
@property (nonatomic, strong)UIAlertView *alert ;
@property (nonatomic,assign)NSString * projectId;
@property (nonatomic,strong)NSDictionary * tiYanDic;
@property (weak, nonatomic) IBOutlet UILabel *yqLabel;


@end

@implementation CWNumberKeyboard
- (id)init
{
    self = [super init];
    
    if(self)
    {
        // 添加keyboardview
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self setBackgroundColor:RGBCOLORVA(0x000000, 0.2)];
        [[NSBundle mainBundle] loadNibNamed:@"CWNumberKeyboard" owner:self options:nil];
        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTapAction:)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:singleRecognizer];
        
        self.mKeyboardView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CUSTOM_KEYBOARD_HEIGHT);
        [self addSubview:self.mKeyboardView];
        _mTextNumberFiled.placeholder = @"0.00";
        _mTextNumberFiled.delegate = self;
        [_mTextNumberFiled addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        //将UITextField键盘设置为空 有光标 但是不弹出键盘 这一步很重要
        _mTextNumberFiled.inputView = [[UIView alloc] initWithFrame:CGRectZero];
        
        // 设置图片
        [self.mDeleteBtn setImage:[UIImage imageNamed:@"CWNumberKeyboard.bundle/delete.png"]
                        forState:UIControlStateNormal];
//        [self.mResignBtn setImage:[UIImage imageNamed:@"CWNumberKeyboard.bundle/resign.png"]
//                        forState:UIControlStateNormal];
        [self getWelfarePayments];
        [self getExper];
    }
    
    return self;
}
- (void)textFieldChange:(UITextField *)textField
{
    _mTextNumberFiled.text = textField.text;
    NSLog(@"dddd");
    [self getEarn];
}



//我的福利金
- (void)getWelfarePayments
{
    
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/getUserAssetInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        _welfDic = dic;

    }];
}
//体验金
- (void)getExper
{
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];

    [util requestDic4MethodNam:@"v2/accept/project/welfareFind" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        _tiYanDic = dic;
        if (status == 0) {
        }else{
            _projectId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"projectId"]];
        }
    }];
    
}


//预期收益
- (void)getEarn
{
    int tzje = [_mTextNumberFiled.text intValue];
    int project = [_projectId intValue];
    [[NetWorkingUtil netWorkingUtil] requestDic4MethodNam:@"v2/accept/project/investIncome" parameters:@{@"projectId":@(project),@"amount":@(tzje),@"projectType":@(1)} result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self];
        }else{
            _yqLabel.text = [NSString stringWithFormat:@"%.2f元",[[dic objectForKey:@"income"] floatValue]];
        }
    }];
}
- (void)showNumKeyboardViewAnimateWithPrice:(NSString *)priceString andBlock:(numberKeyboardBlock)block{
    _block = block;
    float vaule = self.mTextNumberFiled.text.floatValue;
    [self.mTextNumberFiled setText:(0 == vaule)?@"":priceString];
    [self setBackgroundColor:RGBCOLORVA(0x000000, 0.2)];
    [UIView animateWithDuration:0.2 animations:^{
        self.mKeyboardView.frame = CGRectMake(0, SCREEN_HEIGHT-CUSTOM_KEYBOARD_HEIGHT, SCREEN_WIDTH, CUSTOM_KEYBOARD_HEIGHT);
        
    } completion:^(BOOL finished) {
        [self.mTextNumberFiled becomeFirstResponder];
    }];
}
- (void)hideNumKeyboardViewWithAnimateWithConfirm:(BOOL)isConfirm{
    [UIView animateWithDuration:0.2 animations:^{
        self.mKeyboardView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CUSTOM_KEYBOARD_HEIGHT);
        
    } completion:^(BOOL finished) {
        if (isConfirm) {
            float vaule = self.mTextNumberFiled.text.floatValue;
            _block([NSString stringWithFormat:@"%0.2lf",vaule]);
        }
        [self.mTextNumberFiled resignFirstResponder];
        [self setBackgroundColor:[UIColor clearColor]];
        self.hidden = YES;
    }];
}
-(void)bgViewTapAction:(UITapGestureRecognizer*)recognizer
{
    [self hideNumKeyboardViewWithAnimateWithConfirm:NO];
}

/*
 1000->0
 1001->1
 1002->2
 1003->3
 1004->4
 1005->5
 1006->6
 1007->7
 1008->8
 1009->9
 1010->.
 1011->消失
 1012->删除
 1013->确认
 */
- (IBAction)keyboardViewAction:(UIButton *)sender
{
    NSInteger tag = sender.tag;

    switch (tag)
    {
        case 1010:
        {
            // 小数点
//            if(self.mTextNumberFiled.text.length > 0 && ![self.mTextNumberFiled.text containsString:@"."]){
//                [self.mTextNumberFiled insertText:@"."];
//            }
            
        }
            break;
        case 1011:
        {
            // 取消
            [self hideNumKeyboardViewWithAnimateWithConfirm:NO];
        }
            break;
        case 1012:
        {
            // 删除
            if(self.mTextNumberFiled.text.length > 0)
                [self.mTextNumberFiled deleteBackward];
        }
            break;
        case 1013:
        {
            if (IsStrEmpty(_mTextNumberFiled.text)) {
                [MBProgressHUD showMessag:@"请输入金额" toView:self];
                return ;
            }
            
            if ([[_welfDic objectForKey:@"welfareFund"] floatValue]==0) {
                [MBProgressHUD showMessag:@"福利金余额为0" toView:self];
                return ;
            }
            if ([_mTextNumberFiled.text integerValue] % 10 != 0) {
                [MBProgressHUD showMessag:@"投标金额不是10的倍数,不能投标" toView:self];
                return;
            }
            if ([_mTextNumberFiled.text floatValue]>[[_welfDic objectForKey:@"welfareFund"] floatValue]) {
                [MBProgressHUD showMessag:@"投资金额超出福利金范围" toView:self];
                return;
            }
            NSLog(@"%@",[_tiYanDic objectForKey:@"minbidamount"]);
            if ([_mTextNumberFiled.text floatValue]<[[_tiYanDic objectForKey:@"minbidamount"] floatValue]) {
                [MBProgressHUD showMessag:@"投资金额低于起投金额" toView:self];
                return;
            }
            
            NSLog(@"%@",_mTextNumberFiled.text);
            [[NetWorkingUtil netWorkingUtil] requestDic4MethodNam:@"v2/accept/project/welfareInvest" parameters:@{@"projectId":_projectId,@"amount":_mTextNumberFiled.text} result:^(NSDictionary *dic, int status, NSString *msg) {
                NSLog(@"%@",dic);
                if (status == 0) {
                }else{
                    NSLog(@"%@",msg);
                    [MBProgressHUD showMessag:msg toView:self];
                    _alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"投标成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [_alert show];
                    
                }
                
            }];
            //确定 文本框失去焦点 并且下滑消失
            [self hideNumKeyboardViewWithAnimateWithConfirm:YES];
            
        }
            break;
        default:
        {
            // 数字
            // 含有小数点
            if([self.mTextNumberFiled.text containsString:@"."]){
                NSRange ran = [self.mTextNumberFiled.text rangeOfString:@"."];
                if (self.mTextNumberFiled.text.length - ran.location <= 2) {
                    NSString *text = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
                    [self.mTextNumberFiled insertText:text];
                }
            }else{
                NSString *text = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
                [self.mTextNumberFiled insertText:text];
            }
            
            
        }
            break;
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    XShareProjectController * VC = [XShareProjectController new];
    [[self viewController].navigationController pushViewController:VC animated:YES];
}

@end
