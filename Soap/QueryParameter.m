//
//  QueryParameter.m
//  Soap
//
//  Created by isid on 2015/04/06.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "QueryParameter.h"

@implementation QueryParameter

@synthesize queryString;

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
	NSMutableString *soapParam = [[NSMutableString alloc] init];
    //−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    //  オブジェクト名
    [WebServiceUtil appendStringParameterElementWithSoapparam:soapParam key:@"urn:queryString" value:self.queryString];
    
	return soapParam;
}

@end
