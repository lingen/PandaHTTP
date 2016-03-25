//
//  OPHNetwork.m
//  Pods
//
//  Created by lingen on 16/3/24.
//
//

#import "OPHNetwork.h"
#import "OPHRequest.h"


/**
 *  GET请求头
 */
static NSString* HTTP_GET = @"GET";

/**
 *  POST请求头
 */
static NSString* HTTP_POST = @"POST";

/**
 *  PUT请求头
 */
static NSString* HTTP_PUT = @"PUT";

/**
 *  DELETE请求头
 */
static NSString* HTTP_DELETE = @"DELETE";

/**
 *  请求头字符
 */
static NSString* CONTENT_TYPE =@"Content-Type";

static NSString* Content_Length = @"Content-Length";

/**
 *  JSON请求格式
 */
static NSString* JSON_CONTENT_TYPE = @"application/json";

@interface OPHNetwork()

@end



/**
 *  OPHNetwork实现
 */
@implementation OPHNetwork

/**
 *  实例共享，单例
 *
 *  @return 返回OPHNetwork单例
 */
+(instancetype)sharedInstance{
    static OPHNetwork* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[OPHNetwork alloc] init];
    });
    return instance;
}


-(OPHResponse*)syncRequestGet:(OPHRequest*)request{
    return [self p_syncRequest:request];
}

/**
 *  异步请求
 *
 *  @param url         请求URL
 *  @param timeout     超时时间
 *  @param resultBlock 回调结果
 */
-(void)asyncRequest:(OPHRequest*)request resultBlock:(void (^)(OPHResponse* response))resultBlock{
    
    
    __weak typeof (request) weakRequest = request;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        OPHResponse* reponse = [self p_syncRequest:weakRequest];
        if (resultBlock) {
            resultBlock(reponse);
        }
    });
    
}


#pragma REPONSE

-(OPHResponse*)p_syncRequest:(OPHRequest*)ophRequest{
    
    [self p_checkMainThread];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ophRequest.url]];
    [request setHTTPMethod:[self p_getRequestMethod:ophRequest.type]];
    [request setTimeoutInterval:ophRequest.timeout];
    
    NSDictionary* params = ophRequest.params;
    
    if (params!= nil && params.allKeys.count > 0) {
        [request setValue:JSON_CONTENT_TYPE forHTTPHeaderField:CONTENT_TYPE];
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:params
                                                              options:NSJSONWritingPrettyPrinted
                                                                error:nil];
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:Content_Length];
        
        [request setHTTPBody: requestData];
    }
    
    NSError *error = nil;
    NSHTTPURLResponse* response = nil;
    NSData* reponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    return [self p_getOPHJSONResponse:response reponseData:reponseData];
}

-(OPHResponse*)p_getOPHJSONResponse:(NSHTTPURLResponse*)response reponseData:(NSData*)reponseData{
    int statuCode = (int)response.statusCode;
    
    OPHResponse* reponse  = nil;
    
    if (statuCode == 200) {
        reponse = [OPHResponse okReponse:reponseData];
    }else{
        reponse = [OPHResponse errorStatusCodeResponse:statuCode];
    }
    return reponse;
}

-(NSString*)p_getRequestMethod:(OPHRequestType)type{
    if (type == OPH_HTTP_GET) {
        return HTTP_GET;
    }
    
    else if(type == OPH_HTTP_POST){
        return HTTP_POST;
    }
    
    else if(type == OPH_HTTP_PUT){
        return HTTP_PUT;
    }
    
    else if(type == OPH_HTTP_DELETE) {
        return HTTP_DELETE;
    }
    return nil;
}

/**
 *  检查是否在主线程进行操作
 */
-(void)p_checkMainThread{
    BOOL isMainThread = [NSThread isMainThread];
    if (isMainThread) {
        [NSException raise:@"db main thread exception" format:@"DB Actions Not Allow in Main Thread"];
    }
}

@end
