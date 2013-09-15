//
//  RequestFormAPIClient.h
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/15.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestFormAPIClient : NSObject
// メッセージを送信。結果をブロックスで返すAPI
-(void)sendRequestWithContent:(NSString *)content resultBlock:(void(^)(BOOL isSuccess))resultBlock;

@end
