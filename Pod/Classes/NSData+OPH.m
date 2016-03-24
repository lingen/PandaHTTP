//
//  NSData+OPH.m
//  Pods
//
//  Created by lingen on 16/3/25.
//
//

#import "NSData+OPH.h"
#import "OPHJsonStatusResult.h"
@implementation NSData (OPH)

/**
 *  返回NSData的OPHJsonStatusResult模式结果
 *
 *  @return 返回OPHJsonStatusResult，如格式不符合则为nil
 */
-(OPHJsonStatusResult*)OPH_JsonStatusResult{
    NSError* error;
    NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:self
                                                         options:NSJSONReadingMutableLeaves
                                                           error:&error];
    
    if (!error) {
        OPHJsonStatusResult *reponse = [[OPHJsonStatusResult alloc] init];
        reponse.status = [jsonData[OPHJsonStatusResult_STATUS] intValue];
        reponse.message = jsonData[OPHJsonStatusResult_MESSAGE];
        reponse.result = jsonData[OPHJsonStatusResult_RESULT];
        return reponse;
    }
    
    return nil;
}

/**
 *  返回String格式
 *
 *  @return
 */
-(NSString*)OPH_StringResult{
    return  [[NSString alloc] initWithData:self encoding:NSASCIIStringEncoding];
}

@end
