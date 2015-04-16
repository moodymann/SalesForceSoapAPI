//
//  MBWebServiceInfo.h
//  Soap
//
//  Created by isid on 2015/03/12.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBWebServiceInfo : NSObject{
    
}

+ (void)initWith;
+ (NSString *)getConnectDomain;
+ (NSString *)getRootServiceURL;
+ (NSString *)getLoginServiceURL;
+ (NSString *)getLoginServiceAction;
+ (NSTimeInterval)getLoginServiceTimeout;
+ (NSString *)getUserName;
+ (NSString *)getPassWord;

@end
