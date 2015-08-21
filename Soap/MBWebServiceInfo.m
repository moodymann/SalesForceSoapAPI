//
//  MBWebServiceInfo.m
//  Soap
//
//  Created by isid on 2015/03/12.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "MBWebServiceInfo.h"

@implementation MBWebServiceInfo

static NSDictionary *webServiceInfo;

+ (void)initWith {
	
	if (!webServiceInfo) {
		NSString *path = [[NSBundle mainBundle] pathForResource:@"MBWebServiceInfoSandBox" ofType:@"plist"];
		webServiceInfo = [NSDictionary dictionaryWithContentsOfFile:path];
	}
}

+ (BOOL)getSecureConnect{
	return [[webServiceInfo objectForKey:@"secureConnect"] boolValue];
}

+ (NSString *)getRootServiceURL {
	return [webServiceInfo objectForKey:@"rootServiceURL"];
}
+ (NSString *)getConnectDomain {
	return [webServiceInfo objectForKey:@"connectDomain"];
}

+ (NSString *)getUserName {
	return [webServiceInfo objectForKey:@"userName"];
}

+ (NSString *)getPassWord {
	return [webServiceInfo objectForKey:@"password"];
}

+ (NSString *)getLoginServiceURL {
	return [NSString stringWithFormat:@"%@", [self getRootServiceURL]];
}

+ (NSString *)getLoginServiceAction {
	return [NSString stringWithFormat:@"%@?%@", [self getLoginServiceURL], @"WSDL"];
}

+ (NSTimeInterval)getLoginServiceTimeout {
	return 60;
}

@end
