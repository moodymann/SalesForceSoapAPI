//
//  DescribeSObjectParameter.m
//  Soap
//
//  Created by isid on 2015/03/16.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "DescribeSObjectParameter.h"

@implementation DescribeSObjectParameter

@synthesize sObject;

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
//	[soapParam appendString:@"<urn:describeSObject>"];
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    //  オブジェクト名
    [WebServiceUtil appendStringParameterElementWithSoapparam:soapParam key:@"urn:sObjectType" value:self.sObject];
//	[soapParam appendString:@"</urn:describeSObject>"];
    
	return soapParam;
}

@end
