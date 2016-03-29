//
//  OPHResponse.h
//  Pods
//
//  Created by lingen on 16/3/25.
//
//

#import <Foundation/Foundation.h>
#import "OPHJsonStatusResult.h"

/**
 *  HTTP错误
 */
static int OPH_HTTP_ERROR = -9991002;

/**
 *  业务服务错误
 */
static int OPH_SERVICE_ERROR = - 9991001;

/**
 *  数据格式错误
 */
static int OPH_DATA_ERROR = -9991003;

/**
 *  超时错误
 */
static int OPH_TIMEOUT_ERROR = - 9991004;



@interface OPHResponse : NSObject

/**
 *  JSON返回格式
 */
@property (nonatomic,strong) NSData* data;

/**
 *  HTTP状态码
 */
@property (nonatomic,assign) int statusCode;

/**
 *  错误信息
 */
@property (nonatomic,strong) NSError* error;

/**
 *  返回请求的结果是否正常
 *
 *  @return
 */
-(BOOL)isRequestOk;

/**
 *  正确的请求
 *
 *  @param data 格式
 *
 *  @return 返回实例
 */
+(instancetype)okReponse:(NSData*)data;

/**
 *  错误的HTTP响应
 *
 *  @param statusCode HTTP状态码
 *
 *  @return 返回实例
 */
+(instancetype)errorStatusCodeResponse:(int)statusCode error:(NSError*)error;

/**
 *
 * 获取期望的OPHJsonStatusResult结果
 *  @return
 */
-(OPHJsonStatusResult*)expectedJsonStatusResultObject;

/**
 *  获取期望的NSString结果
 *
 */
-(NSString*)expectedStringResult;

/**
 *  返回NSDictionary数据
 *
 *  @return 返回NSDictionary
 */
-(NSDictionary*)excepedNSDictionaryResult;


@end
