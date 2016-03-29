# PandaHTTP

[![CI Status](http://img.shields.io/travis/lingen.liu/PandaHTTP.svg?style=flat)](https://travis-ci.org/lingen.liu/PandaHTTP)
[![Version](https://img.shields.io/cocoapods/v/PandaHTTP.svg?style=flat)](http://cocoapods.org/pods/PandaHTTP)
[![License](https://img.shields.io/cocoapods/l/PandaHTTP.svg?style=flat)](http://cocoapods.org/pods/PandaHTTP)
[![Platform](https://img.shields.io/cocoapods/p/PandaHTTP.svg?style=flat)](http://cocoapods.org/pods/PandaHTTP)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PandaHTTP is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PandaHTTP"
```

## Author

lingen.liu, lingen.liu@gmail.com

## License

PandaHTTP is available under the MIT license. See the LICENSE file for more info.

#PandaHTTP
>PandaHttp是对网络层的一个简单封装类库

1. 简化对网络的操作
2. 倡导同步式的网络操作
3. 针对WorkPlus API特有的JSON输入及返回提供了适配

>PandaHTTP同样提供了异步API，但在WorkPlus是不允许的，WorkPlus只能使用同步API

示例：

~~~
/**
 *  请求登录
 *
 *  @param username 登录的用户名
 *  @param password 登录的pncd
 *
 *  @return 登录成功，返回AWauth
 */
-(AWAuth*)requestLogin:(NSString*)username password:(NSString*)password error:(NSError**)error{
     //登录URL
     NSString* loginUrl = [NSString stringWithFormat:@"%@token",BeeWorks_Config_ApiUrl];
     
     //登录参数
     NSDictionary *loginParams = @{@"grant_type": @"password",
                                   @"scope" : @"user",
                                   @"domain_id" : BeeWorks_Config_DomainId,
                                   @"client_id" : username,
                                   @"client_secret" : password,
                                   @"device_id" : [AWDevice deviceId],
                                   @"device_platform" : @"IOS"};
     
     //构建一个登录请求
     OPHRequest *request = [OPHRequest jsonReqeust:loginUrl type:OPH_HTTP_POST params:loginParams];
     
     OPHResponse* response =  [[OPHNetwork sharedInstance] syncRequest:request];
     
     if ([response isRequestOk]) {
          OPHJsonStatusResult *jsonStatus = [response expectedJsonStatusResultObject];
          //网络请求成功
          if (jsonStatus) {
               int statusCode = jsonStatus.status;
               //业务上正确
               if (statusCode == 0) {
                    AWAuth *result = [AWAuth authWithDictionary:jsonStatus.result];
                    if (!result.username) {
                         result.username = username;
                    }
                    return result;
               }else{
                    //返回一个业务异常
                    *error = [NSError OPH_ServiceError:statusCode msg:jsonStatus.message];
               }
          }

     }else{
          if ([response.error OPH_NetWorkNotExists]) {
               dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD showErrorWithStatus:@"网络不存在"];
               });
          }
          else if([response.error OPH_TimeoutError]){
               dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD showErrorWithStatus:@"请求超时"];
               });
          }
     }
     
     return nil;
}
~~~

OPHRequest

~~~
//构建一个请求
OPHRequest *request = [OPHRequest jsonReqeust:loginUrl type:OPH_HTTP_POST params:loginParams];
~~~

OPHNetwork

~~~
//发出请求
OPHResponse* response = [[OPHNetwork sharedInstance] syncRequest:request]
~~~

OPHResponse可以直接返回你期望的数据

~~~
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
~~~


OPHJsonStatusResult是对WorkPlus API最常用的status,message,result结果的一个封装

