//
//  OPHRequest.h
//  Pods
//
//  Created by lingen on 16/3/25.
//
//

#import <Foundation/Foundation.h>


#import "OPHResponse.h"

typedef NS_ENUM(NSInteger,OPHRequestType) {
    OPH_HTTP_GET,
    
    OPH_HTTP_POST,
    
    OPH_HTTP_PUT,
    
    OPH_HTTP_DELETE
};


@interface OPHRequest : NSObject


@property (nonatomic,assign) OPHRequestType type;

@property (nonatomic,strong) NSDictionary* params;

@property (nonatomic,assign) NSTimeInterval timeout;

@property (nonatomic,strong) NSString* url;


-(NSString*) url;

+(instancetype)jsonReqeust:(NSString*)url type:(OPHRequestType)type;

+(instancetype)jsonReqeust:(NSString *)url type:(OPHRequestType)type params:(NSDictionary*)params;

+(instancetype)jsonReqeust:(NSString *)url type:(OPHRequestType)type params:(NSDictionary *)params timeout:(NSTimeInterval)timeout;


@end
