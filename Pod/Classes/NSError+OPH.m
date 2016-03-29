//
//  NSError+OPH.m
//  AtWork2
//
//  Created by lingen on 16/3/28.
//  Copyright © 2016年 Foreveross. All rights reserved.
//

#import "NSError+OPH.h"
#import "OPHRequest.h"

@implementation NSError (OPH)

/**
 *  是否超时
 *
 *  @return 返回是否超时
 */
-(BOOL)OPH_TimeoutError{
     if (self.code == kCFURLErrorTimedOut) {
          return YES;
     }
     return NO;
}

/**
 *  是否网络不存在
 *
 *  @return 返回网络是否不存在
 */
-(BOOL)OPH_NetWorkNotExists{
     if (self.code == kCFURLErrorNotConnectedToInternet) {
          return YES;
     }
     return NO;
}

/**
 *  服务错误
 *
 *  @return 服务出错
 */
-(BOOL)OPH_ServiceError{
     if (self.code == OPH_SERVICE_ERROR) {
          return YES;
     }
     return NO;
}

/**
 *  服务异常
 *
 *  @param status statusCode
 *  @param msg    描述
 *
 *  @return 返回实例
 */
+(instancetype)OPH_ServiceError:(int)status msg:(NSString*)msg{
     NSError* error = [NSError errorWithDomain:@"服务异常" code:OPH_SERVICE_ERROR userInfo:@{@"status":@(status),@"message":msg}];
     return error;
}

/**
 *  返回业务上的status
 *
 *  @return 返回int
 */
-(int)OPH_ServiceStatus{
     if (self.code == OPH_SERVICE_ERROR) {
          return [self.userInfo[@"status"] intValue];
     }
     return -1;
}

/**
 *  返回业务上的message
 *
 *  @return 返回Message
 */
-(NSString*)OPH_ServiceMessage{
     if (self.code == OPH_SERVICE_ERROR) {
          return self.userInfo[@"message"];
     }
     return nil;
}
@end
