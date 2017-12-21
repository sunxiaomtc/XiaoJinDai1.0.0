//
//  NetWorkingUtil.m
//  AFNetworkingTest
//
//  Created by book on 14-9-1.
//  Copyright (c) 2014年 persen. All rights reserved.
//

#import "NetWorkingUtil.h"

#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "ReflectUtil.h"
#import "IOSmd5.h"
#import "User.h"



@interface NetWorkingUtil ()
{
    int  _requstSessionKeyStatus; //是否请求sessionKey结束  0:未请求 1:请求中  2：请求完毕
    
}
@end
//单例实现
@implementation NetWorkingUtil
static NetWorkingUtil *instance = nil;

static int netWorkState = 1;

//http://101.226.252.170:9091/
//static NSString *mainURL = @"http://101.226.252.170:9091/";
//static NSString *mainURL = @"http://192.168.1.226:8082/";


/*
 *  有值需要修改,请直接修改下面这些宏的值
 */
static NSString * mainURL = __API_HEADER__;

static NSString *appKey = kAppKey;
static NSString *accesstoken = @"";

static NSString *version = kVersion;
static NSString * os = kos ;

//static NSString *userID;

static AFHTTPSessionManager *manager;

+ (NetWorkingUtil *)netWorkingUtil {
    if (!instance) {
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        instance = [[super allocWithZone:NULL] init];
        [NetWorkingUtil reach];

    }
    return instance;
}

+ (NSString *) mainURL {

    return __API_HEADER__;
}


+ (id)allocWithZone:(NSZone *)zone
{
    return [self netWorkingUtil];
    
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)init {
    if (instance) {
        return instance;
    }
    self = [super init];
    return self;
}


/**
 要使用常规的AFN网络访问
 
 1. AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 
 所有的网络请求,均有manager发起
 
 2. 需要注意的是,默认提交请求的数据是二进制的,返回格式是JSON
 
 1> 如果提交数据是JSON的,需要将请求格式设置为AFJSONRequestSerializer
 2> 如果返回格式不是JSON的,
 
 3. 请求格式
 
 AFHTTPRequestSerializer            二进制格式
 AFJSONRequestSerializer            JSON
 AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
 
 4. 返回格式
 
 AFHTTPResponseSerializer           二进制格式
 AFJSONResponseSerializer           JSON
 AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
 AFXMLDocumentResponseSerializer (Mac OS X)
 AFPropertyListResponseSerializer   PList
 AFImageResponseSerializer          Image
 AFCompoundResponseSerializer       组合
 */
#pragma mark - 演练
#pragma mark - 检测网络连接
+ (void)reach
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"state..%d",status);
        netWorkState = status;
//        NSLog(@"state..%d",netWorkState);

    }];
}

/**
 mark by persen
 
 输入参数：
 name：方法名
 parameters:请求参数
 type 1:单列，返回字典结构 2:多列，返回数组结构，数组里面的每一个元素都是字典
 
 输出：void (^)(NSDictionary *dic 真正的结果值
 ,int status  -1:网络异常 0:失败 1;成功，并有结查值，2;成功，但无结果值 3:stateCode＝“01”，执行失败
 ,NSString *msg 信息)
 */
//老接口
-(void) request4MethodName:(NSString *)name parameters:(NSDictionary *)parameters result:(void (^)(id objs,int  status,NSString *msg)) result type:(int) type convertClassName:(NSString *)calssName key:(NSString *)key{
    //说明是第一次请求
    
    
    [self request4MethodNameWithSessionKey:name parameters:parameters result:result type:type convertClassName:calssName key:key];

}

//新接口
-(void) request4MethodNam:(NSString *)name parameters:(NSDictionary *)parameters result:(void (^)(id objs,int  status,NSString *msg)) result type:(int) type convertClassName:(NSString *)calssName key:(NSString *)key{
    //说明是第一次请求

    
    [self request4MethodNamWithSessionKey:name parameters:parameters result:result type:type convertClassName:calssName key:key];
    
}




//返回请求的url地址
- (NSString *)requWebName:(NSString *)name parameters:(NSDictionary *)parameter{

    
    NSString *postURL =  [[NSMutableString stringWithString:mainURL] stringByAppendingFormat:@"%@",name];
    NSLog(@"------***********-----%@",postURL);


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * accesstoken = [defaults objectForKey:@"accesstoken"];
    NSLog(@"---%@",accesstoken);

    
    if (accesstoken == nil) {
        accesstoken=@"";
    }
    NSDictionary *parma = @{@"UserId":[NSString stringWithFormat:@"%ld",(long)[User shareUser].userId],@"Platform":@"2",@"accesstoken":accesstoken,@"version":version,@"os":os};


    
    NSLog(@"------//////////-----%@",parma);
    NSArray * allkeys = [parma allKeys];
    
    if ([postURL containsString:@"?"]) {
       postURL = [postURL stringByAppendingString:@"&"];
    
    } else {
        postURL = [postURL stringByAppendingString:@"?"];
    }
    
    
    for (int i = 0; i < allkeys.count; i++)
    {
        NSString * key = [allkeys objectAtIndex:i];
        //如果你的字典中存储的多种不同的类型,那么最好用id类型去接受它
        id obj  = [parma objectForKey:key];
        
        postURL = [postURL stringByAppendingString:key];
        postURL = [postURL stringByAppendingString:@"="];
        postURL = [postURL stringByAppendingString:(NSString *)obj];
        
        if (i != allkeys.count-1) {
            postURL = [postURL stringByAppendingString:@"&"];
        }
        
    }
    NSLog(@"-----%@",postURL);
    return postURL;
}


//为了banner
- (NSString *)requNewWebName:(NSString *)name parameters:(NSDictionary *)parameter{
    
    
    NSString *postURL =  [[NSMutableString stringWithString:@""] stringByAppendingFormat:@"%@",name];
    NSLog(@"------***********-----%@",postURL);
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * accesstoken = [defaults objectForKey:@"accesstoken"];
    NSLog(@"---%@",accesstoken);
    
    
    if (accesstoken == nil) {
        accesstoken=@"";
    }
    NSDictionary *parma = @{@"UserId":[NSString stringWithFormat:@"%ld",(long)[User shareUser].userId],@"Platform":@"2",@"accesstoken":accesstoken,@"version":version,@"os":os};
    
    
    
    NSLog(@"------//////////-----%@",parma);
    NSArray * allkeys = [parma allKeys];
    
    if ([postURL containsString:@"?"]) {
        postURL = [postURL stringByAppendingString:@"&"];
        
    } else {
        postURL = [postURL stringByAppendingString:@"?"];
    }
    
    
    for (int i = 0; i < allkeys.count; i++)
    {
        NSString * key = [allkeys objectAtIndex:i];
        //如果你的字典中存储的多种不同的类型,那么最好用id类型去接受它
        id obj  = [parma objectForKey:key];
        
        postURL = [postURL stringByAppendingString:key];
        postURL = [postURL stringByAppendingString:@"="];
        postURL = [postURL stringByAppendingString:(NSString *)obj];
        
        if (i != allkeys.count-1) {
            postURL = [postURL stringByAppendingString:@"&"];
        }
        
    }
    NSLog(@"-----%@",postURL);
    return postURL;
}


//老接口
-(void) request4MethodNameWithSessionKey:(NSString *)name parameters:(NSDictionary *)parameters result:(void (^)(id objs,int  status,NSString *msg)) result type:(int) type convertClassName:(NSString *)calssName  key:(NSString *)key{
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    
    NSString *postURL =  [[NSMutableString stringWithString:mainURL] stringByAppendingFormat:@"%@",name];
    NSLog(@"-----------%@",postURL);
    // 处理
    NSDictionary * parma = [self parameterDicWithDic:parameters];
    NSLog(@"++++++++++++++++%@",parma);
    [manager POST:postURL parameters:parma progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"---%@",resultStr);
        NSString *resultMsg;
        int statusInt;
        
        NSDictionary *obj = [resultStr objectFromJSONString];
        NSLog(@"obj:%@", obj);
        
        if (obj==nil) {
            NSLog(@"结果为空!");
            statusInt = -1;
            resultMsg = @"网络异常，请检查您的网络设置!";
            result(nil,statusInt,resultMsg);
            return;
        }
        
        resultMsg = [obj valueForKey:@"Message"];
        NSInteger stateCode = [[obj valueForKey:@"Code"] integerValue];
        NSLog(@"---%ld",stateCode);
        id resultArray = [obj valueForKey:@"Data"];
        NSLog(@"----%@",resultArray);
        
        //        NSInteger stateCode = [[obj valueForKey:@"msgType"] integerValue];
        //        resultMsg = [obj valueForKey:@"data"];
        //        id resultArray = [obj valueForKey:@"success"];
        
        
        NSLog(@"-----%@",resultArray);
        if(resultArray==nil || resultArray==[NSNull null]) {
            if(200 == stateCode)
                statusInt = 2;
            else {
                statusInt = 0;
            }
            NSLog(@"******%d",statusInt);
            result(nil,statusInt,resultMsg);
            return ;
        }
        
        if(200 == stateCode) {
            
            if ([resultArray isKindOfClass:[NSNumber class]]) {
                //                resultObj = resultArray;
                statusInt = 1;
            } else if ([resultArray isKindOfClass:[NSString class]]) {
                //                resultObj = resultArray;
                statusInt = 1;
            } else if ([resultArray isKindOfClass:[NSDictionary class]]) {
                //                resultObj = IsNilOrNull(key)?resultArray:[resultArray objectForKey:key];
                statusInt = 1;
            }else {
                if ([resultArray count] >0)
                    statusInt = 1;
                else
                    statusInt = 2;
            }
            
        }
        else
        {
            statusInt = 0;
        }
        
        //获取 token 和 userid
        if (statusInt == 1&& NotNilAndNull(resultArray) && [name isEqualToString:@"user/login"])
        {
            //1.先获取accesstoken   2.存进去 3.哪里用哪里取出来
            accesstoken = [resultArray valueForKey:@"accesstoken"];
            NSLog(@"%@",accesstoken);
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:accesstoken forKey:@"accesstoken"];
            [userDefaults synchronize];
        }
        
        id resultObj;
        
        if (statusInt == 0) {
            
            result(nil,statusInt,resultMsg);
            return;
        }
        
        if(type==1)
        {
            if ([resultArray isKindOfClass:[NSNumber class]])
            {
                resultObj = resultArray;
            }else if ([resultArray isKindOfClass:[NSString class]]){
                resultObj = resultArray;
            }else if ([resultArray isKindOfClass:[NSDictionary class]]) {
                // NSLog(@"111sss");
                if (key)
                {
                    resultObj = calssName==nil?[resultArray valueForKey:key]:[ReflectUtil reflectDataWithClassName:calssName otherObject:[resultArray valueForKey:key] isList:NO];
                }
                else
                {
                    resultObj = calssName==nil?resultArray:[ReflectUtil reflectDataWithClassName:calssName otherObject:resultArray isList:NO];
                }
                
            }
            
            else
            {
                id value = IsNilOrNull(key)?[resultArray firstObject]:[[resultArray firstObject] valueForKey:key];
                resultObj=calssName==nil?value:[ReflectUtil reflectDataWithClassName:calssName otherObject:value isList:NO];
            }
            
        }
        else
        {
            id value = IsNilOrNull(key)?resultArray:[resultArray  valueForKey:key];
            
            resultObj=calssName==nil?value:[ReflectUtil reflectDataWithClassName:calssName otherObject:value isList:YES];
        }
        NSLog(@"%@",postURL);
        result(resultObj,statusInt,resultMsg);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@",error.userInfo);
        result(nil,-1,@"网络异常，请检查您的网络设置");
    }];
}


//新
-(void) request4MethodNamWithSessionKey:(NSString *)name parameters:(NSDictionary *)parameters result:(void (^)(id objs,int  status,NSString *msg)) result type:(int) type convertClassName:(NSString *)calssName  key:(NSString *)key{
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    
    NSString *postURL =  [[NSMutableString stringWithString:mainURL] stringByAppendingFormat:@"%@",name];
    
    // 处理
    NSDictionary * parma = [self parameterDicWithDic:parameters];
    [manager POST:postURL parameters:parma progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@",responseObject);
        //NSLog(@"%@",postURL);
        NSString *resultStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *resultMsg;
        int statusInt;
        //        resultStr
        
        NSDictionary *obj = [resultStr objectFromJSONString];
        if (obj==nil) {
            NSLog(@"结果为空!");
            statusInt = 0;
            resultMsg = @"网络异常，请检查您的网络设置!";
            result(nil,statusInt,resultMsg);
            return;
        }
        
        
        NSInteger stateCode = [[obj valueForKey:@"success"] integerValue]; //查询数据成功状态值：1成功  0 失败
        //        resultMsg = [obj valueForKey:@"msgType"]; //返回提示语
        //NSLog(@"----返回的数据：%@",obj);
        
        id resultArray = [obj valueForKey:@"data"];//返回的参数
        
        /** 数据异常*/
        if(resultArray == nil || resultArray==[NSNull null]) {
            statusInt = 0;
            resultMsg = @"数据异常";
            result(nil,statusInt,resultMsg);
            return ;
        }
//        else if ([resultArray isEqualToString:@"未登陆"])
//        {
//            [[User shareUser] saveExit];
//        }
        //设置状态值
        if(200 == stateCode ||stateCode==0 ) {
            
            statusInt = 0; // token 过期，重新获取
        }
        else
        {
            if ([resultArray isKindOfClass:[NSNumber class]]) {
                //                resultObj = resultArray;
                statusInt = 1;
            } else if ([resultArray isKindOfClass:[NSString class]]) {
                //                resultObj = resultArray;
                statusInt = 1;
            } else if ([resultArray isKindOfClass:[NSDictionary class]]) {
                //                resultObj = IsNilOrNull(key)?resultArray:[resultArray objectForKey:key];
                statusInt = 1;
            }
        }
        //获取 token 和 userid，/**token过期*/
        if (statusInt == 0&& NotNilAndNull(resultArray) && [name isEqualToString:@"user/login"])
        {
            //1.先获取accesstoken   2.存进去 3.哪里用哪里取出来
            accesstoken = [resultArray valueForKey:@"accesstoken"];
            NSLog(@"%@",accesstoken);
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:accesstoken forKey:@"accesstoken"];
            [userDefaults synchronize];
        }
        
        id resultObj;
        
        if(type==1)
        {
            if ([resultArray isKindOfClass:[NSNumber class]])
            {
                resultObj = resultArray; //实数数据
                NSLog(@"%@",resultArray);
            }else if ([resultArray isKindOfClass:[NSString class]]){
                resultObj = resultArray;//字符串数据
            }else if ([resultArray isKindOfClass:[NSDictionary class]]) {
                //字典数据
                if (key)
                {
                    resultObj = calssName == nil?[resultArray valueForKey:key]:[ReflectUtil reflectDataWithClassName:calssName otherObject:[resultArray valueForKey:key] isList:NO];
                }
                else
                {
                    resultObj = calssName == nil?resultArray:[ReflectUtil reflectDataWithClassName:calssName otherObject:resultArray isList:NO];
                }
            }
            else
            {
                id value = IsNilOrNull(key)?resultArray:[[resultArray firstObject] valueForKey:key];
                resultObj = calssName == nil?value:[ReflectUtil reflectDataWithClassName:calssName otherObject:value isList:NO];
            }
        }
        else
        {
            id value = IsNilOrNull(key)?resultArray:[resultArray  valueForKey:key];
            
            resultObj=calssName==nil?value:[ReflectUtil reflectDataWithClassName:calssName otherObject:value isList:YES];
            //NSLog(@"%@",resultObj);
            
        }
        if (statusInt==0) {
            if([resultArray isKindOfClass:[NSString class]])
            {
                resultMsg = resultArray;
            }else
            {
                resultMsg = @"";
            }
        }
        
        NSLog(@"%@",postURL);
        result(resultObj,statusInt,resultMsg);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误:%@",error.userInfo);
        result(nil,-1,@"网络异常，请检查您的网络设置");
    }];
}


/**
 mark by persen
 描述：通用接品单列查询，返回字典结构
 输入参数：
 name：方法名
 parameters:请求参数
 
 输出：void (^)(NSDictionary *dic 真正的结果值
 ,int status  -1:网络异常 0:失败 1;成功，并有结查值，2;成功，但无结果值
 ,NSString *msg 信息)
 */


//老接口
-(void) requestDic4MethodName:(NSString *)name parameters:(NSDictionary *)parameters result:(void (^)(NSDictionary *dic,int  status,NSString *msg))result{
    [self request4MethodName:name parameters:parameters result:result type:1 convertClassName:nil key:nil];
}

//新接口
-(void) requestDic4MethodNam:(NSString *)name parameters:(NSDictionary *)parameters result:(void (^)(NSDictionary *dic ,int  status,NSString *msg))result{
    
    [self request4MethodNam:name parameters:parameters result:result type:1 convertClassName:nil key:nil];
    
    
    
}

/**
 mark by persen
 描述：通用接品单列查询，返回指定对象结构
 输入参数：
 name：方法名
 parameters:请求参数
 className：指定对象类名
 
 输出：void (^)(id obj 指定对象的结果值
 ,int status  -1:网络异常 0:失败 1;成功，并有结查值，2;成功，但无结果值
 ,NSString *msg 信息)
 */
-(void) requestObj4MethodName:(NSString *)name parameters:(NSDictionary *)parameters result:(void (^)(id obj,int  status,NSString *msg)) result convertClassName:(NSString *)className key:(NSString *)key{
    [self request4MethodName:name parameters:parameters result:result type:1 convertClassName:className key:key];
}


/**
 mark by persen
 描述：通用接品多列查询，返回数组－－>指定对象结构
 输入参数：
 name：方法名
 parameters:请求参数
 className：指定对象类名
 
 输出：void (^)(NSArray *arr 真正的结果值
 ,int status  -1:网络异常 0:失败 1;成功，并有结查值，2;成功，但无结果值
 ,NSString *msg 信息)
 */

//老
-(void) requestArr4MethodName:(NSString *)name parameters:(NSDictionary *)parameters result:(void (^)(NSArray *arr,int  status,NSString *msg)) result convertClassName:(NSString *)className key:(NSString *)key{
    [self request4MethodName:name parameters:parameters result:result type:2 convertClassName:className key:key];
}

//新
-(void) requestArr4MethodNam:(NSString *)name parameters:(NSDictionary *)parameters result:(void (^)(NSArray *arr,int  status,NSString *msg)) result convertClassName:(NSString *)className key:(NSString *)key{
    [self request4MethodNam:name parameters:parameters result:result type:2 convertClassName:className key:key];
}



-(void) getImage
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    UIImageView *imageView;
#warning todo - URL 需要更改 URL获取Image
    [imageView sd_setImageWithURL:[NSURL URLWithString:nil]];
}

/**
 mark by persen
 描述：通用接品单列查询，返回字典结构
 输入参数：
 name：方法名
 controllerName : 所属控制器
 parameters:请求参数
 
 输出：void (^)(NSDictionary *dic 真正的结果值
 ,int status  -1:网络异常 0:失败 1;成功，并有结查值，2;成功，但无结果值
 ,NSString *msg 信息)
 */

//-(void) customRequestDic4MethodName:(NSString *)name controller:(NSString *)controllerName parameters:(NSDictionary *)parameters result:(void (^)(NSDictionary *dic,int  status,NSString *msg)) result {
//    [self customRequest4MethodName:name controller:controllerName parameters:parameters result:result type:1 convertClassName:nil];
//}


/**
 mark by persen
 描述：通用接品多列查询，返回数组－－>指定对象结构
 输入参数：
 name：方法名
 controllerName : 所属控制器
 parameters:请求参数
 className：指定对象类名
 
 输出：void (^)(NSArray *arr 真正的结果值
 ,int status  -1:网络异常 0:失败 1;成功，并有结查值，2;成功，但无结果值
 ,NSString *msg 信息)
 */
//-(void) customRequestArr4MethodName:(NSString *)name controller:controllerName parameters:(NSDictionary *)parameters result:(void (^)(NSArray *arr,int  status,NSString *msg)) result convertClassName:(NSString *)className
//{
//    [self customRequest4MethodName:name controller:controllerName parameters:parameters result:result type:2 convertClassName:className];
//}

/**
 mark by persen
 描述：自定义接口查询
 输入参数：
 name：方法名
 controllerName : 所属控制器
 parameters:请求参数
 type 1:单列，返回字典结构 2:多列，返回数组结构，数组里面的每一个元素都是字典
 
 type 1:单列，返回字典结构 2:多列，返回数组结构，数组里面的每一个元素都是字典
 输出：void (^)(NSDictionary *dic 真正的结果值
 ,int status  -1:网络异常 0:失败 1;成功，并有结查值，2;成功，但无结果值
 ,NSString *msg 信息)
 */
//-(void) customRequest4MethodName:(NSString *)name controller:(NSString *)controllerName parameters:(NSDictionary *)parameters result:(void (^)(id objs,int status,NSString *msg)) result type:(int) type convertClassName:(NSString *)calssName {
//    [self request4MethodName:[NSString stringWithFormat:@"ci/%@.do?%@",controllerName,name]parameters:parameters result:result type:type convertClassName:calssName isCustomInterface:YES];
//    
//}
/**
 自定义接口
 mark by persen
 描述：通用接品单列查询，返回图片的二进制数据
 输入参数：
 name：方法名
 controllerName : 所属控制器
 parameters:请求参数
 
 输出：void (^)(NSData *imageData 真正的结果值
 ,int status  -1:网络异常 0:失败 1;成功，并有结查值，2;成功，但无结果值
 ,NSString *msg 信息)
 */
-(void) customRequestImage4MethodName:(NSString *)name controller:(NSString *)controllerName parameters:(NSDictionary *)parameters result:(void (^)(NSData *imageDate)) result
{
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    NSString *postURL =  [[NSMutableString stringWithString:mainURL] stringByAppendingFormat:@"ci/%@.do?%@&sessionkey=%@",controllerName,name,accesstoken];
    [manager POST:postURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        result(data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil);
    }];
}

-(void) customNoCiRequestImage4MethodName:(NSString *)name controller:(NSString *)controllerName parameters:(NSDictionary *)parameters result:(void (^)(NSData *imageDate)) result
{
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    NSString *postURL =  [[NSMutableString stringWithString:mainURL] stringByAppendingFormat:@"%@.do?%@&sessionkey=%@",controllerName,name,accesstoken];
    [manager POST:postURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        result(data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil);
    }];
   
}



/**
 mark by persen
 描述：加载网络图片资源
 输入参数：
 imageView：需要加载的图片view
 imageUrl : 图片地址
 */

+ (void)setImage:(UIImageView*)imageView url:(NSString*)imageUrl defaultIconName:(NSString*)defaultIconName successBlock:(void (^)(UIImage *))block
{
    NSLog(@"url:%@",imageUrl);
    if (!imageView) imageView = [[UIImageView alloc] init];
    UIImage * defaultImage;
    if (defaultIconName) defaultImage = [UIImage imageNamed:defaultIconName];

    if (defaultImage) {
        if (imageUrl == nil) {
            if (block) block(defaultImage);
            return;
        }
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:defaultImage options:SDWebImageLowPriority|SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                imageView.image = image;
                if (block) block(image);
            } else {
                imageView.image = defaultImage;
                if (block) block(defaultImage);
            }
        }];
    } else {
        @try {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil options:SDWebImageLowPriority|SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    imageView.image = image;
                    if (block) block(image);
                }
            }];
        } @catch (NSException *exception) {
            NSLog(@"图片url为空");
        } @finally {
            
        }
       
    }
}


/**
 mark persen
 描述：只获取结果返回id结构
 输入参数：
 name：方法名
 controllerName : 所属控制器
 parameters:请求参数
 */
//- (void) customRequestObj4MethodName:(NSString *)name controller:(NSString *)controllerName parameters:(NSDictionary *)parameters result:(void (^)(id obj, int status, NSString *msg)) result convertClassName:(NSString *)calssName
//{
//    
//    [self customRequest4MethodName:name controller:controllerName parameters:parameters result:result type:1 convertClassName:calssName];
//

- (AFHTTPSessionManager*)requestImageMethodName:(NSString *)name parameters:(NSDictionary *)parameters images :(NSArray *)images result:(void (^)(id obj,int  status,NSString *msg)) result
{
    NSString *postURL =  [[NSMutableString stringWithString:mainURL] stringByAppendingFormat:@"%@",name];
    
    if (images.count == 0) {
        NSLog(@"上传内容没有包含图片");
        return nil;
    }
    
    for (int i = 0; i < images.count; i++)
    {
        
        if (![images[i] isKindOfClass:[UIImage class]]) {
            NSLog(@"images中第%d个元素不是UIImage对象",i+1);
            return nil;
        }
    }
    NSDictionary *parma = [self parameterDicWithDic:parameters];
    AFHTTPSessionManager *operation = [manager POST:postURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateString = [formatter stringFromDate:date];
        
        for (UIImage *image in images) {
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
            NSData *imageData;
            
            imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:@"images" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"-------%@",resultStr);
        NSString *resultMsg;
        int statusInt;
        //        resultStr
        NSDictionary *obj = [resultStr objectFromJSONString];
        NSLog(@"obj:%@", obj);
        
        if (obj==nil) {
            NSLog(@"结果为空!");
            statusInt = -1;
            resultMsg = @"请求失败，请检查网络环境!";
            result(nil,statusInt,resultMsg);
            return;
        }
        
        resultMsg = [obj valueForKey:@"Massage"];
        NSInteger stateCode = [[obj valueForKey:@"Code"] integerValue];
        id resultArray = [obj valueForKey:@"Data"];
        
        if(resultArray==nil || resultArray==[NSNull null]) {
            if(200 == stateCode)
                statusInt = 2;
            else {
                statusInt = 0;
            }
            
            result(nil,statusInt,resultMsg);
            return ;
        }
        
        if(200 == stateCode) {
            if ([resultArray isKindOfClass:[NSNumber class]]) {
                //                resultObj = resultArray;
                statusInt = 1;
            } else if ([resultArray isKindOfClass:[NSString class]]) {
                //                resultObj = resultArray;
                statusInt = 1;
            } else if ([resultArray isKindOfClass:[NSDictionary class]]) {
                //                resultObj = IsNilOrNull(key)?resultArray:[resultArray objectForKey:key];
                statusInt = 1;
            }else {
                if ([resultArray count] >0)
                    statusInt = 1;
                else
                    statusInt = 2;
            }
            
        }
        else
        {
            statusInt = 0;
        }
        
        
        id resultObj;
        
        
        if ([resultArray isKindOfClass:[NSNumber class]])
        {
            resultObj = resultArray;
        }else if ([resultArray isKindOfClass:[NSString class]])
            resultObj = resultArray;
        else if ([resultArray isKindOfClass:[NSDictionary class]]) {
            resultObj = resultArray;
        }
        else
        {
            id value = [resultArray firstObject];
            resultObj=value;
        }
        result(resultObj,statusInt,resultMsg);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil,-1,@"网络异常，请检查您的网络设置");
    }];
    
    return operation;
}

#pragma mark - private
- (NSDictionary *)parameterDicWithDic:(NSDictionary *)pamar
{

//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString * accesstoken = [defaults objectForKey:@"accesstoken"];
//    NSLog(@"---%@",accesstoken);
//
//
//
//    NSDictionary *parma = @{@"UserId":[NSString stringWithFormat:@"%ld",(long)[User shareUser].userId],@"Platform":@"2",@"accesstoken":accesstoken,@"version":version,@"os":os};
//    NSLog(@"++++++++++++++++%@",parma);
    
    
    
    
    // 对传的参数进行处理
    NSMutableDictionary * dic = pamar?[NSMutableDictionary dictionaryWithDictionary:pamar]:[NSMutableDictionary dictionary];
//     token
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * accesstoken = [defaults objectForKey:@"accesstoken"];
    if (accesstoken != nil)
    {
        [dic setObject:accesstoken forKey:@"accesstoken"];
    }

    // UserID
    NSInteger userId = [User shareUser].userId;
    if (userId)
    {
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)userId] forKey:@"UserId"];
    }
    
    if (os) {
        [dic setObject:os forKey:@"os"];
    }
    
    if (version) {
        [dic setObject:version forKey:@"version"];
    }
    
    [dic setObject:@"2" forKey:@"Platform"];
//     如果还要添加 继续
//
//     排序
    NSArray *keys = [self sortKeys:[dic allKeys]];
    
    // 生成加密参数
    NSMutableString *valueStr = [NSMutableString string];
    for (NSString *key in keys)
    {
        id obj = [dic objectForKey:key];
//        if (IsNilOrNull(obj)) continue;
        NSString *str;
        if ([obj isKindOfClass:[NSString class]])// 字符串
        {
            str = (NSString *)obj;
        }
        else if ([obj isKindOfClass:[NSNumber class]]) // number
        {
            str = [obj stringValue];
        }
        else
        {
            str = [obj JSONString];
        }
//        if (IsStrEmpty(str)) continue;
//        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        [valueStr appendFormat:@"%@|",str];
//        NSLog(@"value = %@  key ＝ %@  str =%@",str,key,valueStr);
    }
    
    [valueStr appendString:appKey];
    [dic setObject:[IOSmd5 md5:valueStr] forKey:@"Sign"];
    
    return dic;
}

- (NSArray *)sortKeys:(NSArray *)keys
{
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(NSString*  _Nonnull obj1, NSString*  _Nonnull obj2)
            {
                NSComparisonResult result =  [obj1 compare:obj2 options:NSLiteralSearch];
                return result == NSOrderedDescending;
            }];
    return keys;
}

+(void)startMultiPartUploadTaskWithURL:(NSString *)url
                           imagesArray:(NSArray *)images
                     parameterOfimages:(NSString *)parameter
                        parametersDict:(NSDictionary *)parameters
                      compressionRatio:(float)ratio
                          succeedBlock:(void(^)(id operation, id responseObject))succeedBlock
                           failedBlock:(void(^)(id operation, NSError *error))failedBlock
                   uploadProgressBlock:(void(^)(float uploadPercent,long long totalBytesWritten,long long totalBytesExpectedToWrite))uploadProgressBlock
{
    
}

@end
