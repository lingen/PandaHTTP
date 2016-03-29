//
//  OPHResponse.m
//  Pods
//
//  Created by lingen on 16/3/25.
//
//

#import "OPHResponse.h"
#import "NSData+OPH.h"

@implementation OPHResponse


/**
 *  请求是否OK
 *
 *  @return 返回HTTP请求是否OK
 */
-(BOOL)isRequestOk{
    return _statusCode == 200;
}

/**
 *  响应结果
 *
 *  @return 返回响应是否OK
 */
-(id)response{
    return _data;
}

/**
 *  错误信息
 *
 *  @return 返回错误信息
 */
-(NSError*)error{
    return _error;
}

/**
 *  正确的请求
 *
 *  @param data 格式
 *
 *  @return 返回实例
 */
+(instancetype)okReponse:(NSData*)data{
    OPHResponse* response = [[OPHResponse alloc] init];
    response.statusCode = 200;
    response.data = data;
    return response;
}

/**
 *  错误的HTTP响应
 *
 *  @param statusCode HTTP状态码
 *
 *  @return 返回实例
 */
+(instancetype)errorStatusCodeResponse:(int)statusCode error:(NSError*)error{

    OPHResponse* response = [[OPHResponse alloc] init];
    response.statusCode = statusCode;
     response.error = error;
     if (!error) {
          response.error = [NSError errorWithDomain:@"HTTP请求出错" code:OPH_SERVICE_ERROR userInfo:@{@"statusCode":@(statusCode)}];
     }
    return response;
}

/**
 *
 * 获取到期望的结果
 *  @return
 */
-(OPHJsonStatusResult*)expectedJsonStatusResultObject{
    if (![self isRequestOk]) {
        return nil;
    }
    return [self.data OPH_JsonStatusResult];
}


-(NSDictionary*)excepedNSDictionaryResult{
    if (![self isRequestOk]) {
        return nil;
    }
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:self.data
                                                         options:kNilOptions
                                                           error:nil];
    return json;
}
/**
 *  获取期望的NSString结果
 *
 */
-(NSString*)expectedStringResult{
    if (![self isRequestOk]) {
        return nil;
    }
    return [self.data OPH_StringResult];
}

@end
