//
//  OPHRequest.m
//  Pods
//
//  Created by lingen on 16/3/25.
//
//

#import "OPHRequest.h"


@implementation OPHRequest


+(instancetype)reqeust:(NSString*)url type:(OPHRequestType)type{
    return [OPHRequest reqeust:url type:type params:nil timeout:120];
}

+(instancetype)reqeust:(NSString *)url type:(OPHRequestType)type params:(NSDictionary*)params{
    return [OPHRequest reqeust:url type:type params:params timeout:120];
}

+(instancetype)reqeust:(NSString *)url type:(OPHRequestType)type params:(NSDictionary *)params timeout:(NSTimeInterval)timeout{
    OPHRequest *ophRequest = [[OPHRequest alloc] init];
    ophRequest.url = url;
    ophRequest.type = type;
    ophRequest.timeout = timeout;
    ophRequest.params = params;
    return ophRequest;
}
@end
