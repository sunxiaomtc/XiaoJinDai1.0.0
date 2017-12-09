//
//  VZAFRequest.m
//  VizzleListExample
//
//  Created by moxin.xt on 14-9-29.
//  Copyright (c) 2014年 VizLab. All rights reserved.
//

#import "VZAFRequest.h"
#import "VizzleConfig.h"

#ifdef _AFNETWORKING_
#import "AFNetworking.h"

@interface VZAFClient : AFHTTPSessionManager

+ (instancetype) sharedClient;

@end

@implementation VZAFClient

+ (instancetype) sharedClient
{
    static VZAFClient* client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[VZAFClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    return client;
}

@end
#endif


@interface VZAFRequest()

#ifdef _AFNETWORKING_
@property(nonatomic,strong) VZAFClient * afClient;
#endif

@property (nonatomic, strong) NSString* url;
@property (nonatomic, copy) NSDictionary* queries;
@property (nonatomic, copy) NSDictionary * fileData;

#ifdef _AFNETWORKING_
@property(nonatomic,strong) NSURLSessionTask* currentTask;
#endif

@end

@implementation VZAFRequest

@synthesize isPost = _isPost;
@synthesize delegate = _delegate;
@synthesize requestURL     = _requestURL;
@synthesize stringEncoding = _stringEncoding;
@synthesize timeoutSeconds = _timeoutSeconds;
@synthesize responseObject = _responseObject;
@synthesize responseString = _responseString;
@synthesize responseError  = _responseError;


- (void)initRequestWithBaseURL:(NSString*)url
{
#ifdef _AFNETWORKING_
    
    NSParameterAssert(url);
    
    if (url.length == 0) {
        [self requestDidFailWithError:[NSError errorWithDomain:VZErrorDomain code:kMethodNameError userInfo:@{NSLocalizedDescriptionKey : @"kMethodNameError"}]];
        return;
    }
    
    self.timeoutSeconds = 60.0f;
    self.stringEncoding = NSUTF8StringEncoding;
    self.url = url;
    
    self.afClient = [VZAFClient sharedClient];
    self.afClient.session.configuration.timeoutIntervalForRequest = self.timeoutSeconds;
    
    
#else
    
    [self requestDidFailWithError:[NSError errorWithDomain:VZErrorDomain code:kAFNetworkingError userInfo:@{NSLocalizedDescriptionKey : @"Did not find AFNetworking!"}]];
    
#endif
    
}

- (void)dealloc
{
    [self cancel];
#ifdef _AFNETWORKING_
    self.currentTask = nil;
#endif
}

- (void)addHeaderParams:(NSDictionary *)params
{
#ifdef _AFNETWORKING_
//    self.afClient.session.configuration.HTTPAdditionalHeaders = params;
    
    if (params.allKeys.count) {
        for (NSInteger i = 0; i < params.allKeys.count; i++) {
            [self.afClient.requestSerializer setValue:params.allValues[i] forHTTPHeaderField:params.allKeys[i]];
        }
    }
#endif
}

- (void)addQueries:(NSDictionary *)queries
{
#ifdef _AFNETWORKING_
    self.queries = [queries copy];
#endif
    
}

- (void)addBodyData:(NSDictionary *)aData forKey:(NSString *)key
{
#ifdef _AFNETWORKING_
    self.fileData = aData;
#endif
}

- (void)load {
    
#ifdef _AFNETWORKING_
    
    NSString * type = self.isPost ? @"POST" : @"GET";
    
    NSMutableURLRequest * request = [self.afClient.requestSerializer requestWithMethod:type URLString:self.url parameters:self.queries error:nil];
    self.requestURL = request.URL.absoluteString;
    
    [self requestDidStart];
    
    __weak typeof(&*self) weakSelf = self;
    if (self.isPost) {
        self.currentTask = [self.afClient POST:self.url parameters:self.queries success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            __strong typeof (weakSelf) strongSelf = weakSelf;
            
            if (strongSelf) {
                //AF没有获取responseString的方法
                strongSelf -> _responseString = [NSString stringWithFormat:@"%@",responseObject];
                strongSelf -> _responseObject = responseObject;
            }
            
            [weakSelf requestDidFinish:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            __strong typeof (weakSelf) strongSelf = weakSelf;
            
            if (strongSelf) {
                strongSelf -> _responseString = [NSString stringWithFormat:@"%@",task.response];
                strongSelf -> _responseError = error;
            }
            [weakSelf requestDidFailWithError:error];
        }];
    } else {
        self.currentTask = [self.afClient GET:self.url parameters:self.queries success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            __strong typeof (weakSelf) strongSelf = weakSelf;
            
            if (strongSelf) {
                //AF没有获取responseString的方法
                strongSelf -> _responseString = [NSString stringWithFormat:@"%@",responseObject];
                strongSelf -> _responseObject = responseObject;
            }
            
            [weakSelf requestDidFinish:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            __strong typeof (weakSelf) strongSelf = weakSelf;
            
            if (strongSelf) {
                //AF没有获取responseString的方法
                strongSelf -> _responseString = [NSString stringWithFormat:@"%@",task.response];
                strongSelf -> _responseError = error;
            }
            [weakSelf requestDidFailWithError:error];
        }];
    }
    
#endif
    
}
- (void)cancel
{
#ifdef _AFNETWORKING_
    [self.currentTask cancel];
#endif
}

- (void)requestDidStart
{
    if ([self.delegate respondsToSelector:@selector(requestDidStart:)]) {
        [self.delegate requestDidStart:self];
    }
}

- (void)requestDidFinish:(id)JSON
{
    if ([self.delegate respondsToSelector:@selector(requestDidFinish:)]) {
        [self.delegate requestDidFinish:JSON];
    }
}

- (void)requestDidFailWithError:(NSError* )error
{
    if ([self.delegate respondsToSelector:@selector(requestDidFailWithError:)]) {
        [self.delegate requestDidFailWithError:error];
    }
}

@end
