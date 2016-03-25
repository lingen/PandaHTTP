//
//  OPHNetwork.h
//  Pods
//
//  Created by lingen on 16/3/24.
//
//

#import <Foundation/Foundation.h>
#import "OPHRequest.h"

@class OPHResponse;

/**
 *  同步请求
 */
@interface OPHNetwork : NSObject


+(instancetype)sharedInstance;

-(OPHResponse*)syncRequestGet:(OPHRequest*)request;

/**
 *  异步请求
 *
 *  @param url         请求URL
 *  @param timeout     超时时间
 *  @param resultBlock 回调结果
 */
-(void)asyncRequest:(OPHRequest*)request resultBlock:(void (^)(OPHResponse* response))resultBlock;



@end
