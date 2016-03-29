//
//  NSError+OPH.h
//  AtWork2
//
//  Created by lingen on 16/3/28.
//  Copyright © 2016年 Foreveross. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (OPH)
/**
 *
 *
 *
 */

/**
 *  是否超时
 *
 *  @return 返回是否超时
 */
-(BOOL)OPH_TimeoutError;

/**
 *  是否网络不存在
 *
 *  @return 返回网络是否不存在
 */
-(BOOL)OPH_NetWorkNotExists;

/**
 *  服务错误
 *
 *  @return 服务出错
 */
-(BOOL)OPH_ServiceError;

/**
 *  服务异常
 *
 *  @param status statusCode
 *  @param msg    描述
 *
 *  @return 返回实例
 */
+(instancetype)OPH_ServiceError:(int)status msg:(NSString*)msg;

/**
 *  返回业务上的status
 *
 *  @return 返回int
 */
-(int)OPH_ServiceStatus;

/**
 *  返回业务上的message
 *
 *  @return 返回Message
 */
-(NSString*)OPH_ServiceMessage;

@end
