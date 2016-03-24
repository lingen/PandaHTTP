//
//  PandaHTTPTests.m
//  PandaHTTPTests
//
//  Created by lingen.liu on 03/23/2016.
//  Copyright (c) 2016 lingen.liu. All rights reserved.
//

@import XCTest;
#import "OPH.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    
    OPHRequest* request = [OPHRequest reqeust:@"http://httpbin.org/get" type:OPH_HTTP_GET];
    
    OPHResponse* response = [[OPHNetwork sharedInstance] syncRequestGet:request];
    
    
    NSDictionary* result = [response excepedNSDictionaryResult];
    
    [self waitForTimeInterval:3];
}

-(void)testSyncExample{
    
}


- (void)waitForTimeInterval:(NSTimeInterval)delay
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"wait"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:delay + 1 handler:nil];
}

@end

