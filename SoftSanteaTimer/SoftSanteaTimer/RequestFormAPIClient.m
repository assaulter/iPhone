//
//  RequestFormAPIClient.m
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/15.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import "RequestFormAPIClient.h"
#import "AppDelegate.h"

@interface RequestFormAPIClient() {
    NSDateFormatter *_formatter;
}
@property(readonly, nonatomic) NSString *formUrl;
@property(readonly, nonatomic) NSString *currentDate;
@property(readonly, nonatomic) NSString *currentVersion;
@end

@implementation RequestFormAPIClient

@synthesize formUrl=_formUrl, currentDate=_currentDate, currentVersion=_currentVersion;

-(void)sendRequestWithContent:(NSString *)content resultBlock:(void(^)(BOOL isSuccess))resultBlock {
    // send data
    NSDictionary *dict = @{@"date": self.currentDate,
                           @"content": content,
                           @"iOSVersion": [[UIDevice currentDevice] systemVersion],
                           @"appVersion": self.currentVersion
                           };
    NSString *params = [self createParamsWithData:dict];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@?%@", self.formUrl, params];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest *request = [self createRequestFromUrl:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
        [mainQueue addOperationWithBlock:^{
            // 結果をmainThreadで返す実験
            resultBlock([self isSuccessWithResponse:response data:data err:connectionError]);
        }];
    }];
}

#pragma mark - private
- (BOOL)isSuccessWithResponse:(NSURLResponse*)response data:(NSData*)data err:(NSError*)err {
    if(data == nil) return NO; // OFFLINE
    if(err != nil) return NO; // サーバエラー
    
    return YES;
}

-(NSMutableURLRequest *)createRequestFromUrl:(NSURL *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    return request;
}

- (NSString*)createParamsWithData:(NSDictionary*)dict {
    NSMutableString* result = [NSMutableString new];
    BOOL isFirst = YES;
    for(NSString* key in dict.allKeys) {
        if(isFirst) {
            isFirst = NO;
        } else {
            [result appendFormat:@"&"];
        }
        [result appendFormat:@"%@=%@", key, [dict[key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return result;
}

#pragma mark - override getter
-(NSString *)formUrl {
    if (!_formUrl) {
        _formUrl = @"https://script.google.com/macros/s/AKfycbwRwYlgbN2zfyrJ9BPwu19Wh7_P99DcwZ_xg8YCvz6IIUhmE7Rj/exec";
    }

    return _formUrl;
}

-(NSString *)currentDate {
    if (!_formatter) {
        _formatter = [NSDateFormatter new];
        [_formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    }
    
    return [_formatter stringFromDate:[NSDate date]];
}

-(NSString *)currentVersion {
    if (!_currentVersion) {
        _currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVewsionString"];
    }
    
    return _currentVersion;
}

@end
