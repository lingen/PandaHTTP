//
//  NSData+OPH.h
//  Pods
//
//  Created by lingen on 16/3/25.
//
//

#import <Foundation/Foundation.h>
@class OPHJsonStatusResult;

@interface NSData (OPH)

/**
 *  返回NSData的OPHJsonStatusResult模式结果
 *
 *  @return 返回OPHJsonStatusResult，如格式不符合则为nil
 */
-(OPHJsonStatusResult*)OPH_JsonStatusResult;

/**
 *  返回String格式
 *
 *  @return <#return value description#>
 */
-(NSString*)OPH_StringResult;

@end
