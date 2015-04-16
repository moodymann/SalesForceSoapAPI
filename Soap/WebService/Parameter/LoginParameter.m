//
//  LoginParameter.m
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "LoginParameter.h"

@implementation LoginParameter

@synthesize userId;                         //  ユーザーID
@synthesize password;                       //  パスワード

/*******************************************************************************
 *  init
 *  初期処理
 */
- (id)init
{
    if ((self = [super init])) {
        
    }
	return self;
}

/*******************************************************************************
 *  getSoapParameter
 *
 */
- (NSString *)getSoapParameter
{
	NSMutableString *soapParam = [[NSMutableString alloc]init];
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
//	[soapParam appendString:@"<n1:login xmlns:n1=\"urn:partner.soap.sforce.com\">"];
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    //  ユーザ名
    [WebServiceUtil appendStringParameterElementWithSoapparam:soapParam key:@"urn:username" value:self.userId];
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    //  パス
    [WebServiceUtil appendStringParameterElementWithSoapparam:soapParam key:@"urn:password" value:self.password];
    
//	[soapParam appendString:@"</n1:login>"];
	
	return soapParam;
}

@end
