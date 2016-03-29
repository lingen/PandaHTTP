//
//  OPHJsonStatusResult.h
//  Pods
//
//  Created by lingen on 16/3/25.
//
//

#import <Foundation/Foundation.h>



static NSString* OPHJsonStatusResult_STATUS = @"status";

static NSString* OPHJsonStatusResult_RESULT = @"result";

static NSString* OPHJsonStatusResult_MESSAGE = @"message";

/**
 *  NSDATA的一种适配模式
 */
@interface OPHJsonStatusResult : NSObject

@property (nonatomic,assign) int status;

@property (nonatomic,strong) NSString* message;

@property (nonatomic,strong) NSDictionary* result;

/**
 *  业务上是否成功
 *
 *  @return 返回BOOL值
 */
-(BOOL)isResultSuccess;



@end
